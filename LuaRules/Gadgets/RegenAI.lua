
-- status:
-- 0 dead
-- 1 construction queued
-- 2 under construction
-- 3 exiting factory
-- 4 moving to position
-- 5 assigning orders
-- 6 all set!
-- 7 morphing, such as a bug that self-destroy to create an exploit

-- When status is 1, the ID is the id of the builder

function gadget:GetInfo()
	return {
		name = "Regenerative AI",
		desc = "An AI that rebuild what it loses",
		author = "zwzsg",
		version = "1.3",
		date = "4th of August 2009",
		license = "Public Domain",
		layer = 84,
		enabled = true
	}
end

VFS.Include("LuaRules/Gadgets/libs/new_cmd_id.lua",nil)

if (gadgetHandler:IsSyncedCode()) then
--SYNCED


	-- Idle Packet / Counter Dispatch Data
	local minBuffer = 18 -- don't auto-dispatch if less that this many packets in buffer
	local dispatchCoolDown = 2 -- in seconds, wait at least this amount between two autodispatch from the same port/connection
	local dispatchRange = 400 -- don't autodispatch if attacker is further than that
	local maxIdleTime = 8 -- in seconds, auto bufferize packets if they have been idle for that amount of time
	local notIdleIfEnemyInThatRange = 250
	local idleTimer={}
	local dispatchTimer={}
	local orders={}

	-- Regenerative AI Data and Functions
	local RegenData={}
	local AlreadyDispatching=false
	local AlreadyFoundImpossible={}

	local function StoreIt(u,ud,x,z)
		if Spring.GetUnitRulesParam(u,"NoRegenAI") then
			return false
		end
		if UnitDefs[ud].needGeo then
			-- Poorly written check: Check for any feature, not just datavent, and the area most likely doesn't exactly fit
			local f=Spring.GetFeaturesInRectangle(x-16,z-16,x+16,z+16)
			if f and #f>=1 then
				return true
			else
				return false
			end
		end
		return true
	end


	local function IsItOccupied(u1)
		local ux1,_,uz1=Spring.GetUnitPosition(u1)
		local ud1=UnitDefs[Spring.GetUnitDefID(u1)]
		local usx1,usz1=ud1.xsize*8-4,ud1.zsize*8-4
		for _,u2 in ipairs(Spring.GetAllUnits()) do
			local ud2=UnitDefs[Spring.GetUnitDefID(u2)]
			if ud2.canMove==false or (ud2.speed or 0)<1 then
				local ux2,_,uz2=Spring.GetUnitPosition(u2)
				local usx2,usz2=ud2.xsize*8,ud2.zsize*8
				if math.abs(ux2 - ux1)<usx1+usx2 and math.abs(uz2 - uz1)<usz1+usz2 then
					return 1
				end
			end
		end
		return nil
	end


	local function isUnitComplete(UnitID)
		local health,maxHealth,paralyzeDamage,captureProgress,buildProgress=Spring.GetUnitHealth(UnitID)
		if buildProgress and buildProgress>=1 then
			return true
		else
			return false
		end
	end


	local function SaveRegenData(team)
		local function AddOrder(q,id,params,options)
			table.insert(q,{id=id,params=params,options=options})
		end
		local function AddStateOrder(q,id,param)
			table.insert(q,{id=id,params={param},options={}})
		end
		local function AddQueue(q,queue)
			local OrdersOnUnits={
				[CMD.ATTACK]=true,
				[CMD.GUARD]=true,
				[CMD.RECLAIM]=true,
				[CMD.REPAIR]=true,
				[CMD.CAPTURE]=true,
				[CMD.LOAD_UNITS]=true,
				[CMD.LOAD_ONTO]=true,
				[CMD.UNLOAD_UNITS]=true,
				[CMD.DEATHWAIT]=true,
			}
			for _,o in ipairs(queue) do
				local id=o.id
				local params={}
				local options={}
				local shifted=false
				for _,param in ipairs(o.params) do
					table.insert(params,param)
				end
				for _,option in ipairs(o.options) do
					table.insert(options,option)
					if option=="shift" then
						shifted=true
					end
				end
				if not shifted then
					table.insert(options,"shift")
				end
				if #o.params==1 and OrdersOnUnits[o.id] and Spring.ValidUnitID(o.params[1]) then
					id=CMD_IF_UNIT_IN_AREA
					local TargetType=Spring.GetUnitDefID(o.params[1])
					local x,y,z=Spring.GetUnitPosition(o.params[1])
					params={o.id,TargetType,x,y,z,128,1}
					-- order to redo, unitdef to look for, center, radius, blocking order
					-- blocking = wait until there's a unit to guard/attack/etc..
				end
				table.insert(q,{id=id,params=params,options=options})
			end
		end
		local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(team)
		if (string.lower(Spring.GetTeamLuaAI(team))==string.lower(gadget:GetInfo().name)) or
			(CustomTeamOptions and CustomTeamOptions["aioverride"] and string.lower(CustomTeamOptions["aioverride"])==string.lower(gadget:GetInfo().name)) then
			local UnitsWithOrders={}
			for _,u in ipairs(Spring.GetTeamUnits(team)) do
				local udid=Spring.GetUnitDefID(u)
				local ud=UnitDefs[Spring.GetUnitDefID(u)]
				local heading=Spring.GetUnitHeading(u)
				local buildfacing=Spring.GetUnitBuildFacing(u)
				local x,_,z=Spring.GetUnitPosition(u)
				local states=Spring.GetUnitStates(u)
				local q={}
				-- Add extra orders to restore unit states
				AddStateOrder(q,CMD.FIRE_STATE,states["firestate"])
				AddStateOrder(q,CMD.MOVE_STATE,states["movestate"])
				if states["cloak"]~=ud.startCloaked then
					AddStateOrder(q,CMD.CLOAK,states["cloak"] and 1 or 0)
				end
				if states["active"]~=ud.activateWhenBuilt then
					AddStateOrder(q,CMD.ONOFF,states["active"] and 1 or 0)
				end
				if (states["trajectory"] and 1 or 0)~=ud.highTrajectoryType then
					AddStateOrder(q,CMD.TRAJECTORY,states["trajectory"] and 1 or 0)
				end
				-- Could add here restoration of autoland, autorepairlevel, loopbackattack states
				-- New Worm state
				if Spring.GetUnitRulesParam(u,"autohold") then
					AddStateOrder(q,CMD_AUTOHOLD,Spring.GetUnitRulesParam(u,"autohold")>=1 and 1 or 0)
				end
				-- Old Worm and Old Bug state
				if Spring.GetUnitRulesParam(u,"burrow") then
					AddStateOrder(q,CMD_BURROW,Spring.GetUnitRulesParam(u,"burrow")>=1 and 1 or 0)
				end
				if states["repeat"] then
					AddStateOrder(q,CMD_REPEAT,nil)
				end
				AddQueue(q,Spring.GetFactoryCommands(u) or {})
				AddQueue(q,Spring.GetUnitCommands(u) or {})
				for _,b in ipairs(Spring.GetFullBuildQueue(u) or {}) do
					local unitDefID,count = next(b,nil)
					for c=1,count,1 do
						AddOrder(q,-unitDefID,{},{})
					end
				end
				-- Some units shan't be regenerated
				if StoreIt(u,ud.id,x,z) then
					table.insert(UnitsWithOrders,{status=6,name=ud.name,id=u,x=x,z=z,heading=heading,buildfacing=buildfacing,orders=q})
				end
			end
			table.sort(
				UnitsWithOrders,
				function(a,b)
					return UnitDefNames[a.name].health>UnitDefNames[b.name].health
				end
				)
			RegenData[team]=UnitsWithOrders
		end
	end



	--function gadget:Initialize()
	--end


	function gadget:GameStart()
		for _,team in ipairs(Spring.GetTeamList()) do
			local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(team)
			if (string.lower(Spring.GetTeamLuaAI(team))==string.lower(gadget:GetInfo().name)) or
				(CustomTeamOptions and CustomTeamOptions["aioverride"] and string.lower(CustomTeamOptions["aioverride"])==string.lower(gadget:GetInfo().name)) then
				RegenData[team]={RegenAI=true}
			end
		end
	end



	local function Regen(frame,uwoi,uwo,team)
		if uwo.status==1 or uwo.status==7 then -- If unit was merely queued or destroyed for morphing
			if RegenData[team][uwoi].timer+30*30<frame then -- And not recreated for last thirty seconds
				RegenData[team][uwoi].status=0 -- Consider it lost and remake it
				--Spring.Echo(gadget:GetInfo().name..": "..uwo.name.." was in limbo for over 30s, considering it lost and requeueing one.")
				--Spring.SendMessageToTeam(team,uwo.name.." was in limbo for over 30s, considering it lost and requeueing one.")
			end
		elseif uwo.timer and uwo.status~=3 then
			RegenData[team][uwoi].timer=nil
		end

		--0: Dead unit, must respawn:
		if uwo.status==0 then

			-- Spawner: Inits --
			local udid=UnitDefNames[uwo.name].id
			if AlreadyFoundImpossible[udid] then--or (uwo.name=="packet" and AlreadyDispatching) then
				return
			end
			local BuilderID=nil
			local DistToBuilder=nil
			--if uwo.name=="exploit" then -- To make an exploit one needs a bug
			--	udid=UnitDefNames["bug"].id
			--end

			-- Spawner: Find a builder --
			for _,b in ipairs(Spring.GetTeamUnits(team)) do
				--if uwo.name=="packet" and isTeleporter[Spring.GetUnitDefID(b)] and Spring.GetTeamRulesParam(team,"bufferSize")>0 then
				--	CanBuildIt=true
				--end
				local bdbo=UnitDefs[Spring.GetUnitDefID(b)].buildOptions
				if bdbo and #bdbo>=1 then
					local CanBuildIt=false
					for _,buildable in ipairs(bdbo) do
						if udid==buildable then
							--Spring.SendMessageToTeam(team,UnitDefs[Spring.GetUnitDefID(b)].name.." has "..uwo.name.." in buildmenu")
							CanBuildIt=true
							break
						end
					end
					if CanBuildIt and isUnitComplete(b) and
						#(Spring.GetUnitCommands(b) or {})==0 and
						#(Spring.GetCommandQueue(b) or {})==0 and
						#(Spring.GetFactoryCommands(b) or {})==0 and
						((not dispatchTimer[b]) or (Spring.GetGameSeconds()>dispatchCoolDown+dispatchTimer[b])) then
						local bx,_,bz=Spring.GetUnitPosition(b)
						local d=(bx-uwo.x)^2+(bz-uwo.z)^2
						if not BuilderID or d<DistToBuilder then
							--Spring.SendMessageToTeam(team,UnitDefs[Spring.GetUnitDefID(b)].name.." free to build "..uwo.name)
							BuilderID=b
							DistToBuilder=d
						end
					end
				end
			end

			-- Spawner: A builder was found --
			if BuilderID then
				if uwo.name=="packet" and isTeleporter[Spring.GetUnitDefID(BuilderID)] then
					AlreadyDispatching=true
					dispatchTimer[BuilderID]=Spring.GetGameSeconds()
					Spring.GiveOrderToUnit(BuilderID,CMD_DISPATCH,{uwo.x,Spring.GetGroundHeight(uwo.x,uwo.z),uwo.z},{})
				elseif UnitDefs[Spring.GetUnitDefID(BuilderID)].isFactory then
					Spring.GiveOrderToUnit(BuilderID,-udid,{},{})
				else
					Spring.GiveOrderToUnit(BuilderID,-udid,{uwo.x,Spring.GetGroundHeight(uwo.x,uwo.z),uwo.z,uwo.buildfacing},{"shift"})
				end
				RegenData[team][uwoi].status=1 -- construction queued
				RegenData[team][uwoi].id=BuilderID
				RegenData[team][uwoi].timer=frame
			else
				AlreadyFoundImpossible[udid]=true
			end

		--1: Queued unit:
		elseif uwo.status==1 then
		-- Do nothing, waiting for UnitCreated event

		--2: Under construction:
		elseif uwo.status==2 then
			if isUnitComplete(uwo.id) then -- if construction finished
				local ud=UnitDefs[Spring.GetUnitDefID(uwo.id)]
				if (not ud.canMove) or (ud.speed or 0)<1 then -- if immmobile
					Spring.GiveOrderToUnit(uwo.id,CMD.STOP,{},{})
					RegenData[team][uwoi].status=5 -- skip moving, go directly to order assignation
				else
					RegenData[team][uwoi].status=3 -- probably busy exiting factory
					RegenData[team][uwoi].timer=frame
				end
			end
		end

		--3: Exiting factory:
		if uwo.status==3 then
			if (not IsItOccupied(uwo.id)) or RegenData[team][uwoi].timer+15*30<frame then -- if out of factory or inside factory for over 15s
				-- MOVE TO POSITION --
				RegenData[team][uwoi].timer=nil
				Spring.GiveOrderToUnit(uwo.id,CMD.MOVE,{uwo.x,Spring.GetGroundHeight(uwo.x,uwo.z),uwo.z},{})
				RegenData[team][uwoi].status=4 -- Moving to position
			end
		end

		--4: Moving to position
		if uwo.status==4 then
			local x,_,z=Spring.GetUnitPosition(uwo.id)
			local q=Spring.GetCommandQueue(uwo.id)
			if (not q) or (#q==0) or q[1].id~=CMD.MOVE then -- if move finished
				-- Morph bug into exploit
				if uwo.name=="exploit" and UnitDefs[Spring.GetUnitDefID(uwo.id)].name=="bug" then
					Spring.GiveOrderToUnit(uwo.id,CMD_DEPLOY,{},{})
					RegenData[team][uwoi].status=1 -- the bug is queued into creating an exploit
					return
				end
				RegenData[team][uwoi].status=5
			end
		end

		--5: Assigning order list
		if uwo.status==5 then
			-- Issue all the orders
			for _,o in ipairs(uwo.orders) do
				Spring.GiveOrderToUnit(uwo.id,o.id,o.params,o.options)
			end
			--Spring.SendMessageToTeam(team,uwo.name.." deployed and re-assigned!")
			RegenData[team][uwoi].status=6
		end

	end



	function gadget:GameFrame(frame)

		-- Orders given out of GameFrame
		for i,o in pairs(orders) do
			if orders[i][5]==2 then -- delete that order in case displaying it causes error
				orders[i]=nil
			elseif orders[i][5]==1 then -- display that order in case executing it causes error
				orders[i][5]=2
				Spring.Echo(gadget:GetInfo().name..": Spring.GiveOrderToUnit(",o[1],o[2],o[3],o[4],")")
				local cmd_name=o[2]
				for name,cmd in pairs(CMD) do
					if cmd == o[2] then
						cmd_name = name
					end
				end
				Spring.Echo(gadget:GetInfo().name..": "..UnitDefs[Spring.GetUnitDefID(o[1])].name.." given invalid "..cmd_name.." order")
			elseif Spring.ValidUnitID(o[1]) and not Spring.GetUnitIsDead(o[1]) then
				orders[i][5]=1
				Spring.GiveOrderToUnit(o[1],o[2],o[3],o[4])
			else
				Spring.Echo(gadget:GetInfo().name..": attempted to give order to ID="..o[1].." non-existant unit")
			end
			orders[i]=nil
		end

		-- Idle Packets
		if false and frame % 27 == 0 then
			for _,team in ipairs(Spring.GetTeamList()) do
				if RegenData[team] then
					for _,u in ipairs(Spring.GetTeamUnitsByDefs(team,packet)) do
						local enemy = Spring.GetUnitNearestEnemy(u,notIdleIfEnemyInThatRange)
						local vx,vy,vz = Spring.GetUnitVelocity(u)
						local c = Spring.GetUnitCommands(u) or {}
						local stunned = Spring.GetUnitIsStunned(u)
						if #c==0 and (not enemy) and (not stunned) and vx==0 and vy==0 and vz==0 then
							idleTimer[u]=idleTimer[u] or Spring.GetGameSeconds()
							if Spring.GetGameSeconds()>idleTimer[u]+maxIdleTime then
								--BufferizePacket(u)
								local closestID,closestDist = nil,nil
								for _,tp in ipairs(Spring.GetTeamUnitsByDefs(Spring.GetUnitTeam(u),{teleporter})) do
									if not closestID or Spring.GetUnitSeparation(u,tp)<closestDist then
										closestID = tp
										closestDist = Spring.GetUnitSeparation(u,tp)
									end
								end
								if closestID then
									Spring.GiveOrderToUnit(u,CMD_ENTER,{closestID},{"shift"})
								end
							end
						else
							if idleTimer[u] then
								idleTimer[u]=nil
							end
						end
					end
				end
			end
		end

		-- Regenerative AI
		if (frame+97)%79==0 then
			for _,team in ipairs(Spring.GetTeamList()) do
				if RegenData[team] then
					if frame==61 then
						SaveRegenData(team)
					else
						AlreadyDispatching=false
						AlreadyFoundImpossible={}
						for uwoi,uwo in pairs(RegenData[team]) do
							if uwo.status~=6 then
								Regen(frame,uwoi,uwo,team)
							end
						end
					end
				end
			end
		end
	end


	function gadget:UnitDamaged(u,ud,team,damage,para,weapon,attacker,aud,ateam)
		if damage>0.5 and RegenData[team] then

		end
	end


	function gadget:UnitDestroyed(u,ud,team,atk,atkd,atkteam)
		if dispatchTimer[u] then
			dispatchTimer[u]=nil
		end
		if idleTimer[u] then
			idleTimer[u]=nil
		end
		for _,rgteam in ipairs(Spring.GetTeamList()) do
			if RegenData[rgteam] then
				for uwoi,uwo in ipairs(RegenData[rgteam]) do
					if uwo.id==u then
						if atk==ud and (UnitDefs[ud].name=="exploit" or UnitDefs[ud].name=="bug") then
							RegenData[rgteam][uwoi].status=7 -- should be morphing and come back as a UnitCreated with a new ID
							RegenData[rgteam][uwoi].timer=Spring.GetGameFrame()
						else
							RegenData[rgteam][uwoi].status=0
							--Spring.SendMessageToTeam(rgteam,"Lost a "..uwo.name)
						end
					end
				end
			end
		end
	end


	function gadget:UnitTaken(u,ud,team,newteam)
		if RegenData[team] then
			if not Spring.AreTeamsAllied(team,newteam) then -- If the new owner is not allied with the AI
				for uwoi,uwo in ipairs(RegenData[team]) do
					if uwo.id==u then
						RegenData[team][uwoi].status=0
					end
				end
			end
		end
	end


	function gadget:UnitCreated(u,ud,team)
		if RegenData[team] then
			local WannabeIdx=nil
			local WannabeDist=nil
			for uwoi,uwo in ipairs(RegenData[team]) do
				if (uwo.status==1 and uwo.name==UnitDefs[ud].name)
					--or (uwo.status==0 and uwo.name==UnitDefs[ud].name and uwo.name=="packet")
					--or (uwo.status==7 and (uwo.name=="bug" or uwo.name=="exploit") and (UnitDefs[ud].name=="bug" or UnitDefs[ud].name=="exploit"))
					then
					local x,_,z=Spring.GetUnitPosition(u)
					local d=(x-uwo.x)^2+(z-uwo.z)^2
					if (not WannabeIdx) or d<WannabeDist then
						WannabeIdx=uwoi
						WannabeDist=d
					end
				end
			end
			local uwoi=WannabeIdx
			local uwo=RegenData[team][uwoi]
			if WannabeIdx and ((UnitDefs[ud].speed or 0)>=1 or WannabeDist<28^2) then
				--Spring.SendMessageToTeam(team,"New "..uwo.name.." found!")
				RegenData[team][uwoi].id=u
				RegenData[team][uwoi].status=2 -- under construction
				if isUnitComplete(u) then
					RegenData[team][uwoi].status=3
				end
			end
		end
	end

	--function gadget:UnitFinished(u,ud,team)
	--end


else
--UNSYNCED

end
