

function gadget:GetInfo()
	return {
		name = "Pseudo Orders",
		desc = "Transfer, synced TimeWait, queuable Repeat, ...",
		author = "zwzsg",
		date = "August, 4th, 2009",
		license = "Public domain",
		layer = 17,
		enabled = true
	}
end

VFS.Include("LuaRules/Gadgets/libs/new_cmd_id.lua",nil)

--[[
-- Looks like I didn't need those after all
local TmWtDscrptn = {
	name="Time Wait",
	type=CMDTYPE.NUMBER,
	tooltip="Wait a given amoutn of seconds",
	id=CMD_TIMEWAIT,
	action="timewait",
	cursor="wait", -- not sure
}

local TrnsfrDscrptn = {
	name="Transfer",
	type=CMDTYPE.NUMBER,
	tooltip="Give unit to a team",
	id=CMD_TRANSFER,
	action="transfer",
	cursor="Unload units",
}
]]--

if (gadgetHandler:IsSyncedCode()) then
--SYNCED

	local WaitTimers={}
	local Transfers={}
	local Orders={}

	local function CustomCommand(u,ud,team,cmd,params,options,tag,synced)
		if cmd == CMD_TIMEWAIT then
			if #params==1 and type(params[1])=="number" then
				local gs=Spring.GetGameSeconds()
				for wti,wt in ipairs(WaitTimers) do
					if wt.unit==u and wt.tag==tag then
						if gs>wt.ending then
							table.remove(WaitTimers,wti)
							return true,true
						else
							return true,false
						end
					end
				end
				table.insert(WaitTimers,{unit=u,duration=params[1],ending=gs+params[1],tag=tag})
				return true,false
			else
				Spring.Echo("Bad parameters to CMD_TIMEWAIT")
			end
		end
		if cmd == CMD_TRANSFER then
			if #params==1 and type(params[1])=="number" then
				if Spring.GetTeamInfo(params[1]) then
					table.insert(Transfers,{SourceUnit=u,DestinationTeam=params[1]})
					return true,(Spring.GetUnitTeam(u)==params[1])
				else
					Spring.Echo("Bad TeamID to CMD_TRANSFER")
				end
			else
				Spring.Echo("Bad parameters to CMD_TRANSFER")
			end
		end
		if cmd == CMD_REPEAT then
			if #params==0 then
				if Spring.GetUnitStates(u)["repeat"] then
					return true, true
				else
					table.insert(Orders,{unit=u,cmd=CMD.REPEAT,params={1},options={}})
					return true,true
				end
			else
				Spring.Echo("Bad parameters to CMD_REPEAT")
			end
		end
		if cmd == CMD_IF_UNIT_IN_AREA then
			local tcid,tudid,x,y,z,radius,blocking=unpack(params)
			local closest_d,closest_u
			if not UnitDefs[tudid] then
				Spring.Echo("CMD_IF_UNIT_IN_AREA: not a valid unitDefID",tudid)
				return false
			end
			--Spring.Echo("CMD_IF_UNIT_IN_AREA: looking for a "..UnitDefs[tudid].name.." at ",x,y,z," in radius ",radius," blocking=",blocking)
			for _,u in ipairs(Spring.GetUnitsInCylinder(x,z,radius)) do
				if Spring.GetUnitDefID(u)==tudid then
					local ux,_,uz=Spring.GetUnitPosition(u)
					local d=(ux-x)^2+(uz-z)^2
					if (closest_u==nil) or (d<closest_d) then
						closest_u=u
						closest_d=d
					end
				end
			end
			if closest_u and not Spring.GetUnitIsDead(closest_u) then
				table.insert(Orders,{unit=u,cmd=tcid,params={closest_u},options={}})
				return true,true
			else
				return true,tonumber(blocking)==0
			end
		end
		if cmd == CMD_TRIGGERWAIT then
			if #params~=1 then
				Spring.Echo("CMD_TRIGGERWAIT takes one parameter, not "..#params)
				return false
			elseif GG.MissionTrigger.States[params[1]] then
				return true,true
			else
				return true,false
			end
		end
		if cmd == CMD_SELFEXPLODE then
			if #params~=0 then
				Spring.Echo("CMD_SELFEXPLODE does not take any parameter!")
				return false
			else
				Spring.DestroyUnit(u,true,false)
				return true,true
			end
		end
		if cmd == CMD_SELFREMOVE then
			if #params~=0 then
				Spring.Echo("CMD_SELFREMOVE does not take any parameter!")
				return false
			else
				Spring.DestroyUnit(u,false,true,u)
				return true,true
			end
		end
		if cmd == CMD_SELECTABLE then
			if #params>1 then
				Spring.Echo("CMD_SELECTABLE takes one or zero parameter!")
				return false
			else
				local switch=((not params[1]) or tonumber(params[1])~="0") and true or false
				Spring.SetUnitNoSelect(u,switch)
				return true,true
			end
		end
	end

	function gadget:AllowCommand(u,ud,team,cmd,params,options,tag,synced)
		-- Factories never receive CommandFallback because they handle queue differently
		-- So I have to catch custom orders at the AllowCommmand stage
		if UnitDefs[ud].isFactory then
			CustomCommand(u,ud,team,cmd,params,options,tag,synced)
		end
		return true
	end

	function gadget:CommandFallback(u,ud,team,cmd,params,options,tag)
		-- returns: Used, Finished
		if UnitDefs[ud].isFactory then
			return false,false
		else
			return CustomCommand(u,ud,team,cmd,params,options,tag)
		end
	end

	function gadget:GameFrame(f)
		for _,o in ipairs(Orders) do
			if Spring.ValidUnitID(o.unit) then
				Spring.GiveOrderToUnit(o.unit,o.cmd,o.params,o.options)
			end
		end
		Orders={}
		for _,trnsfr in ipairs(Transfers) do
			if Spring.ValidUnitID(trnsfr.SourceUnit) then
				Spring.TransferUnit(trnsfr.SourceUnit,trnsfr.DestinationTeam)
			end
		end
		Transfers={}
	end

	function gadget:UnitDestroyed(u,ud,team)
		for ti=#WaitTimers,1,-1 do
			if u==WaitTimers[ti].unit then
				table.remove(WaitTimers,ti)
			end
		end
		for ti=#Transfers,1,-1 do
			if u==Transfers[ti].SourceUnit then
				table.remove(Transfers,ti)
			end
		end
		for oi=#Orders,1,-1 do
			if u==Orders[oi].unit then
				table.remove(Orders,oi)
			end
		end
	end


else
--UNSYNCED

	--[[
	-- Doesn't appear to be working
	function gadget:Initialize()
		Spring.SetCustomCommandDrawData(CMD_TIMEWAIT,"Wait", {.5,.5,1,1})
		Spring.SetCustomCommandDrawData(CMD_TRANSFER,"Resurrect", {.5,.5,1,1})
	end
	]]--


end
