

VFS.Include("LuaRules/Gadgets/libs/new_cmd_id.lua",nil)

CommandList={
{CMD.STOP,"Stop","S",CMDTYPE.ICON},
{CMD.MOVE,"Move","M",CMDTYPE.ICON_MAP},
{CMD.FIGHT,"Fight","F",CMDTYPE.ICON_MAP},
{CMD.ATTACK,"Attack","A",CMDTYPE.ICON_UNIT_OR_MAP}, --CMDTYPE.ICON_UNIT_OR_AREA}, -- Actually, can also be a rectangle
{CMD.AREA_ATTACK,"AreaAttack","AA",CMDTYPE.ICON_AREA},
{CMD.PATROL,"Patrol","P",CMDTYPE.ICON_MAP},
{CMD.GUARD,"Guard","G",CMDTYPE.ICON_UNIT},
{CMD.RESTORE,"Restore","Rest",CMDTYPE.ICON_AREA},
{CMD.RECLAIM,"Reclaim","Rec",CMDTYPE.ICON_UNIT_FEATURE_OR_AREA},
{CMD.REPAIR,"Repair","Rep",CMDTYPE.ICON_UNIT_OR_AREA},
{CMD.RESURRECT,"Resurrect","Rez",CMDTYPE.ICON_UNIT_FEATURE_OR_AREA},
{CMD.CAPTURE,"Capture","Capt",CMDTYPE.ICON_UNIT_OR_AREA},
{CMD.SELFD,"SelfDestruct","AutoDestruct","SD",CMDTYPE.ICON},
{CMD.DGUN,"DGun","DG",CMDTYPE.ICON_MAP},
{CMD.STOCKPILE,"Stockpile","SP",CMDTYPE.ICON},
{CMD.LOAD_UNITS,"LoadUnits","L",CMDTYPE.ICON_UNIT_OR_AREA},
{CMD.LOAD_ONTO,"LoadOnto","GL",CMDTYPE.ICON_UNIT},
{CMD.UNLOAD_UNITS,"UnloadUnits","U",CMDTYPE.ICON_UNIT_OR_AREA}, -- Add something to sort them depending on param num
{CMD.UNLOAD_UNIT,"UnloadUnit","U",CMDTYPE.ICON_MAP}, -- Add something to sort them depending on param num
{CMD_REPEAT,"Repeat","Rpt",CMDTYPE.ICON}, -- Enqueuable one
{CMD.WAIT,"Wait","W",CMDTYPE.ICON},
{CMD_TIMEWAIT,"TimeWait","WaitTime","TW",CMDTYPE.NUMBER},-- Replaced by my own custom gadget implementation
{CMD.DEATHWAIT,"DeathWait","DW",CMDTYPE.ICON_UNIT_OR_RECTANGLE},
{CMD.SQUADWAIT,"SquadWait","SW",CMDTYPE.NUMBER},
{CMD.GATHERWAIT,"GatherWait","GW",CMDTYPE.ICON},
{CMD.ONOFF,"OnOff","OO",CMDTYPE.ICON_MODE},
{CMD.CLOAK,"Cloak","C",CMDTYPE.ICON_MODE},
{CMD.FIRE_STATE,"FireState","FS",CMDTYPE.ICON_MODE},
{CMD.MOVE_STATE,"MoveState","MS",CMDTYPE.ICON_MODE},
{CMD.TRAJECTORY,"Trajectory","Traj",CMDTYPE.ICON_MODE},
{CMD.AUTOREPAIRLEVEL,"AutoRepairLevel","ARL",CMDTYPE.ICON_MODE},
{CMD.LOOPBACKATTACK,"LoopBackAttack","LBA",CMDTYPE.ICON_MODE},
{CMD.IDLEMODE,"IdleMode","IM",CMDTYPE.ICON_MODE},
{CMD.SET_WANTED_MAX_SPEED,"SetWantedMaxSpeed","Speed",CMDTYPE.NUMBER},
{CMD.SETBASE,"SetBase",true},
{CMD.INTERNAL,"Internal",true},
{CMD.AISELECT,"AISelect","AI",CMDTYPE.COMBO_BOX},
{CMD.GROUPSELECT,"GroupSelect","GS",CMDTYPE.ICON},
{CMD.GROUPADD,"GroupAdd","GA",CMDTYPE.ICON},
{CMD.GROUPCLEAR,"GroupClear","GC",CMDTYPE.ICON},
-- Mod specfic command:
{CMD_SPECIAL,"KPSpecialCmd",true},
{CMD_NX,"NX",CMDTYPE.ICON_MAP},
{CMD_DEPLOY,"Deploy",CMDTYPE.ICON},
{CMD_UNDEPLOY,"Undeploy",CMDTYPE.ICON},
{CMD_BUG2MINE,"BugToMine",CMDTYPE.ICON},
{CMD_MINE2BUG,"MineToBug",CMDTYPE.ICON},
{CMD_MINELAUNCHER,"MineLauncher",CMDTYPE.ICON},
{CMD_DISPATCH,"Dispatch",CMDTYPE.ICON_MAP},
{CMD_ENTER,"Enter",CMDTYPE.ICON_UNIT},
{CMD_BOMBARD,"Bombard",CMDTYPE.ICON_UNIT_OR_MAP},
{CMD_AUTOHOLD,"AutoHold",CMDTYPE.ICON_MODE},
{CMD_BURROW,"Burrow",CMDTYPE.ICON_MODE},
{CMD_FIREWALL,"Firewall",CMDTYPE.ICON_MAP},
{CMD_AIRSTRIKE,"AirStrike",CMDTYPE.ICON_MAP},
{CMD_TRANSFER,"Transfer",CMDTYPE.NUMBER},
{CMD_IF_UNIT_IN_AREA,"CmdIfUnitInArea",{7}},
{CMD_TRIGGERWAIT,"TriggerWait","WaitTrigger",CMDTYPE.NUMBER},
{CMD_SELFEXPLODE,"SelfExplode","Explode","SelfDestroy","Destroy",CMDTYPE.ICON},
{CMD_SELFREMOVE,"SelfRemove","Remove","SilentSelfRemove","SilentRemove","SilentSelfExplode","SilentExplode","SilentSelfDestroy","SilentDestroy",CMDTYPE.ICON},
{CMD_SELECTABLE,"Selectable","CanBeSelected",CMDTYPE.ICON},
}

KeyWords_ID={"ID"}
KeyWords_Team={"Team","T"}
KeyWords_Position={"Position","Pos"} -- "P" taken by Patrol
KeyWords_Rotation={"Rotation","R"}
KeyWords_Health={"Health","HP","H"}
KeyWords_BuildProgress={"Constructed"}
KeyWords_Order={"Order","o","Command","CMD"}
KeyWords_Build={"Build","B"}
KeyWords_BuildFacing={"Facing","F"}
KeyWords_Skip={"Skip"}
KeyWords_NoRegenAI={"NoRegenAI","NoRegen"}

-- States, keywords have to be the same as in the above command list
KeyWords_FireState={"FireState","FS"}
KeyWords_MoveState={"MoveState","MS"}
KeyWords_Repeat={"Repeat","Rpt"}
KeyWords_Cloak={"Cloak","C"}
KeyWords_Active={"OnOff","OO"}
KeyWords_Trajectory={"Trajectory","Traj"}
KeyWords_AutoLand={"AutoLand","AL"} -- Is there an associated command?
KeyWords_AutoRepairLevel={"AutoRepairLevel","ARL"}
KeyWords_LoopBackAttackAuto={"LoopBackAttack","LBA"}

KeyWords_Name={"Name"}
KeyWords_Trigger={"Trigger"}
KeyWords_InDisk={"InDisk"}
KeyWords_InRect={"InRectangle","InRect"}
KeyWords_Period={"Period"}
KeyWords_Once={"Once"}
KeyWords_Echo={"Echo","Message"}
KeyWords_And={"and","&&","&"}-- Not implemented
KeyWords_Or={"or","||","|"}-- Not implemented
KeyWords_Xor={"xor","^"}-- Not implemented
KeyWords_Not={"Not","!","~"}-- Not implemented

local function CheckCommandType(CmdType,ParamNbr)
	if type(CmdType)=="table" then
		for _,pn in ipairs(CmdType) do
			if pn==ParamNbr then
				return 1
			end
		end
		return 0
	elseif CmdType==CMDTYPE.ICON then
		if ParamNbr==0 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_MAP then
		if ParamNbr==3 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_AREA then
		if ParamNbr==4 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_UNIT then
		if ParamNbr==1 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_UNIT_OR_MAP then
		if ParamNbr==1 or ParamNbr==2 or ParamNbr==3 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_FRONT then
		if ParamNbr==3 or ParamNbr==6 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.COMBO_BOX then
		if ParamNbr==1 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_UNIT_OR_AREA then
		if ParamNbr==1 or ParamNbr==4 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_BUILDING then
		if ParamNbr==3 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_UNIT_OR_RECTANGLE then
		if ParamNbr==1 or ParamNbr==3 or ParamNbr==6 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.NUMBER then
		if ParamNbr==1 then
			return 1
		else
			return 0
		end
	elseif CmdType==CMDTYPE.ICON_UNIT_FEATURE_OR_AREA then
		if ParamNbr==5 then
			return 1
		else
			return 0
		end
	else
		return -1
	end
end



function SortFeatureList(FeatureList)
	table.sort(
			FeatureList,
			function(fa,fb)
				local xa,_,za=Spring.GetFeaturePosition(fa)
				local xb,_,zb=Spring.GetFeaturePosition(fb)
				if za~=zb then
					return za<zb
				elseif xa<xb then
					return xa<xb
				else
					return nil
				end
			end
		)
	return FeatureList
end


function SortUnitList(UnitList)
		table.sort(
				UnitList,
				function(ua,ub)
					local a=UnitDefs[Spring.GetUnitDefID(ua)]
					local b=UnitDefs[Spring.GetUnitDefID(ub)]

					if ((a.speed or 0)==0) ~= ((b.speed or 0)==0) then
						return (a.speed or 0)>(b.speed or 0)

					elseif a.xsize~=b.xsize then
						return a.xsize<b.xsize

					elseif a.zsize~=b.zsize then
						return a.zsize<b.zsize

					elseif a.health~=b.health then
						return a.health<b.health

					elseif a.name~=b.name then
						return a.name<b.name

					else
						local xa,_,za=Spring.GetUnitPosition(ua)
						local xb,_,zb=Spring.GetUnitPosition(ub)
						if za~=zb then
							return za<zb
						elseif xa<xb then
							return xa<xb
						else
							return nil
						end
					end
				end
			)
	return UnitList
end

-- The round2 function from http://lua-users.org/wiki/SimpleRound fails on 0.11
function FormatNbr(x,digits)
	local _,fractional = math.modf(x)
	if fractional==0 then
		return x
	elseif fractional<0.0001 then
		return math.floor(x)
	elseif fractional>0.9999 then
		return math.ceil(x)
	else
		local ret=string.format("%."..(digits or 0).."f",x)
		if digits and digits>0 then
			while true do
				local last = string.sub(ret,string.len(ret))
				if last=="0" or last=="." then
					ret = string.sub(ret,1,string.len(ret)-1)
				end
				if last~="0" then
					break
				end
			end
		end
		return ret
	end
end

function MakeDumpedUnitList(UnitList,UsedIDs,ArgAbbreviated,Grid)
	local kwi=1
	local son=" "
	if ArgAbbreviated then
		kwi=2
		son=""
	end
	local function Snap(x)
		if not Grid then -- Still snapping to at least 1
			return math.floor(0.5+x)
		else
			return Grid*math.floor(0.5+x/Grid)
		end
	end
	local DumpedUnitList = {}
	local SortedUL=SortUnitList(UnitList)
	for _,u in ipairs(SortedUL) do

		-- Empty String
		local s=""
		local ud=UnitDefs[Spring.GetUnitDefID(u)]
		local x,y,z=Spring.GetUnitPosition(u)
		local health,maxHealth,paralyzeDamage,captureProgress,buildProgress=Spring.GetUnitHealth(u)
		local us=Spring.GetUnitStates(u)

		-- ID
		if (not UsedIDs) or UsedIDs[u] then
			s=s.." "..KeyWords_ID[1]..u
		end

		-- Team
		--s=s.." "..KeyWords_Team[kwi]..son..Spring.GetUnitTeam(u)

		-- UnitName
		s=s.." "..ud.name

		-- Position
		s=s.." "..KeyWords_Position[kwi].." "..Snap(x).." "..Snap(z)

		-- Rotation
		if Spring.GetUnitHeading(u)~=0 then
			s=s.." "..KeyWords_Rotation[kwi]..son..math.floor(((Spring.GetUnitHeading(u)+524288)%65536)*360/655360+0.5)*10 -- Convert to degrees
		end

		-- Health
		if math.floor(health-maxHealth+0.5)~=0 then
			s=s.." "..KeyWords_Health[kwi==1 and 1 or #KeyWords_Health]..son..math.floor(100*health/maxHealth+0.5)
		end

		-- BuildProgress
		if buildProgress<1 then
			s=s.." "..KeyWords_BuildProgress[1]..son..math.floor(100*buildProgress)
		end

		-- States
		if us["firestate"]~=2 then -- Dunno where to read default one from UnitDefs
			s=s.." "..KeyWords_FireState[kwi]..son..us["firestate"]
		end
		if us["movestate"]~=1 then -- Dunno where to read default one from UnitDefs
			s=s.." "..KeyWords_MoveState[kwi]..son..us["movestate"]
		end
		if us["repeat"] then
			s=s.." "..KeyWords_Repeat[kwi==1 and 1 or #KeyWords_Repeat] --..son.."1"
		end
		if us["cloak"]~=ud.startCloaked then
			s=s.." "..KeyWords_Cloak[kwi]..son..(us["cloak"] and "1" or "0")
		end
		if us["active"]~=ud.activateWhenBuilt then
			s=s.." "..KeyWords_Active[kwi]..son..(us["active"] and "1" or "0")
		end
		if (us["trajectory"] and 1 or 0)~=ud.highTrajectoryType then
			s=s.." "..KeyWords_Trajectory[kwi]..son..(us["trajectory"] and "1" or "0")
		end
		if us["autoland"] then
			s=s.." "..KeyWords_AutoLand[kwi]..son..(us["autoland"] and "1" or "0")
		end
		if us["autorepairlevel"] and math.abs(us["autorepairlevel"]-0.3)>0.0001 then
			s=s.." "..KeyWords_AutoRepairLevel[kwi]..son..FormatNbr(us["autorepairlevel"],2)
		end
		if us["loopbackattack"] then
			s=s.." "..KeyWords_LoopBackAttackAuto[kwi]..son..(us["loopbackattack"] and "1" or "0")
		end

		-- New Worm state
		if Spring.GetUnitRulesParam(u,"autohold") then
			s=s.." AutoHold "..(Spring.GetUnitRulesParam(u,"autohold")>=1  and "1" or "0")
		end
		-- Old Worm and Old Bug state
		if Spring.GetUnitRulesParam(u,"burrow") then
			s=s.." Burrow "..(Spring.GetUnitRulesParam(u,"burrow")>=1  and "1" or "0")
		end

		-- Orders
		local OrdersList={}
		-- No need for GetFactoryCommands when we use GetFullBuildQueue later
		--for _,o in ipairs(Spring.GetFactoryCommands(u) or {}) do
		--	table.insert(OrdersList,o)
		--end
		for _,o in ipairs(Spring.GetCommandQueue(u) or {}) do
			table.insert(OrdersList,o)
		end
		local build=false
		for _,o in ipairs(OrdersList) do

			-- Check if order is a command of a known type
			local cmd=nil
			local cmdtype=nil
			local cmdname=KeyWords_Order[kwi]..o.id -- default name is like o312
			for _,c in ipairs(CommandList) do
				if c[1]==o.id then
					cmd=c
					cmdname=(kwi==1 and cmd[2] or cmd[#cmd-1])
					cmdtype=cmd[#cmd]
				end
			end

			if o.id~=CMD.SET_WANTED_MAX_SPEED then -- Skip those orders

				if true then
					-- Recopy table, because I don't want to modify the original
					local ps={}
					for _,p in ipairs(o.params) do
						table.insert(ps,p)
					end
					o.params=ps
				end

				-- If it is a build order
				if not cmd and o.id<0 then
					if not build then
						s=s.." "..KeyWords_Build[kwi]
					end
					build = (build or 0)+1
					cmdname=UnitDefs[-o.id].name
				else
					build=false
				end

				local modifier=""
				if o.shift then
					modifier=modifier.."shift+"
				end
				if o.ctrl then
					modifier=modifier.."ctrl+"
				end
				if o.alt then
					modifier=modifier.."alt+"
				end
				if o.right then
					modifier=modifier.."right+"
				end
				if o.internal then
					modifier=modifier.."internal+"
				end

				-- Order with modifiers
				s=s.." "..modifier..cmdname

				-- Parameters
				-- Number of parameter not corresponding to command type
				if CheckCommandType(cmdtype,#o.params)==0 then
					s=s.." bad_params_number"
				elseif (CheckCommandType(cmdtype,#o.params)<0) and (not (o.id<0)) then
					s=s.." unknown_params_types"
				end

				-- If there's parameters
				if o.params and #o.params>0 then

					-- Translate parameters that are unitid
					local target=nil
					if #o.params==1 and (cmdtype==CMDTYPE.ICON_UNIT
										or cmdtype==CMDTYPE.ICON_UNIT_OR_MAP
										or cmdtype==CMDTYPE.ICON_UNIT_OR_AREA
										or cmdtype==CMDTYPE.ICON_UNIT_OR_RECTANGLE
										or cmdtype==CMDTYPE.ICON_UNIT_FEATURE_OR_AREA) then
						if cmdtype==CMDTYPE.ICON_UNIT_FEATURE_OR_AREA and o.params[1]>Game.maxUnits then
							target=o.params[1] -- May not really handle order on feature with that
						else
							for j,v in ipairs(UnitList) do
								if v==o.params[1] then
									target=1+#UnitList - j -- First units have high ID, last units low ID, and I want the contrary
									-- That wouldn't work anyway. Translating Units ID would be way too complex.
								end
							end
						end
					end

					-- If attack order with near 0 radius area, remove radius parameter
					if o.id==CMD.ATTACK and #o.params==4 and math.floor(0.5+o.params[4])==0 then
						o.params={o.params[1],o.params[2],o.params[3]}
					end

					-- If three parameters and not of type front, then most probably there are x,y,z and we remove y
					if #o.params==3 and cmdtype~=CMDTYPE.ICON_FRONT then
						o.params={Snap(o.params[1]),Snap(o.params[3])}
					end

					-- If a build there order, remove y, rewrite facing
					if o.id<0 and #o.params==4 then
						o.params={Snap(o.params[1]),Snap(o.params[3]),KeyWords_BuildFacing[kwi]..son..o.params[4]}
					end

					if o.id==CMD_IF_UNIT_IN_AREA then
						local cmd2=nil
						local cmd2type=nil
						local cmd2name=tostring(o.params[1])
						for _,c in ipairs(CommandList) do
							if c[1]==o.params[1] then
								cmd2=c
								cmd2name=(kwi==1 and cmd2[2] or cmd2[#cmd2-1])
								cmd2type=cmd2[#cmd2]
							end
						end
						table.remove(o.params,4) -- removing 4th parameter, which should be Y
						if not cmd2type then
							s=s.." skip1 cmd2_"..cmd2name.."_unknown"
						elseif CheckCommandType(cmd2type,1)==0 then
							s=s.." skip1 cmd2_"..cmd2name.."_not_unit_type"
						elseif type(o.params[2])~="number" or not UnitDefs[o.params[2]] then
							s=s.." skip1"..tostring(o.params[2] or "nil").."_not_a_unitDefId"
						else
							o.params[1]=cmd2name
							o.params[2]=UnitDefs[o.params[2]].name
						end
					end

					-- If a triggerwait, replace trigger id by its name
					if o.id==CMD_TRIGGERWAIT then
						if GG.MissionTrigger then
							o.params[1]=GG.MissionTrigger.Equ[o.params[1]].Name or o.params[1]
						end
					end

					-- Write all parameters
					if target then
						s=s.." ID_"..o.params[1].. " Skip1 u"..target
					else
						for n,parameter in ipairs(o.params) do
							--if (#o.params==3 or #o.params==4 or #o.params==6) then
							--	--s=s.." "..type(parameter)..": "
							--end
							--if (#o.params==3 or #o.params==4 or #o.params==6) and type(parameter)=="number" then
							--	s=s.." "..math.floor(0.5+parameter)
							if type(parameter)=="number" then
								s=s.." "..math.floor(0.5+parameter)
							elseif type(parameter)=="nil" then
								s=s.." nil"
							else
								s=s.." "..parameter
							end
						end
					end
				end
			end
		end

		-- Build queue
		local bq=nil
		for _,b in ipairs(Spring.GetFullBuildQueue(u) or {}) do
			local unitDefID,count = next(b,nil)
			bq=(bq and bq or " "..KeyWords_Build[kwi]).." "..(count>1 and count.." " or "")..UnitDefs[unitDefID].name
		end
		if bq then
			s=s..bq
		end

		-- Store the line corresponding to that unit and proceed to next unit
		table.insert(DumpedUnitList,1,s)
	end
	return DumpedUnitList
end

function MakeDumpedFeatureList(OnlyTeamID,Abbreviated,Grid)
	DumpedFeatureList={}
	local function Snap(x)
		if not Grid then
			return x
		else
			return Grid*math.floor(0.5+x/Grid)
		end
	end
	local SortedFeatureList=SortFeatureList(Spring.GetAllFeatures())
	for _,f in ipairs(SortedFeatureList) do
		if (not OnlyTeamID) or Spring.GetFeatureTeam(f)==OnlyTeamID then
			local s=""
			local fd=FeatureDefs[Spring.GetFeatureDefID(f)]
			local t=Spring.GetFeatureTeam(f)
			local x,y,z=Spring.GetFeaturePosition(f)
			local heading=Spring.GetFeatureHeading(f)
			local rx,ry,rz=Spring.GetFeatureDirection(f)
			local health,maxHealth,resurrectProgress=Spring.GetFeatureHealth(f)
			-- Team
			if (not OnlyTeamID) and t and t~=Spring.GetGaiaTeamID() then
				s=" T"..t
			end
			-- Name
			s=s.." "..FeatureDefs[Spring.GetFeatureDefID(f)].name
			-- Position
			s=s.." "..Snap(x).." "..Snap(z)
			-- Rotation
			s=s.." R"..(math.floor(0.5+(heading+262144)*360/65536)%360)
			-- Health
			if health~=maxHealth then
				s=s.." H"..math.floor(0.5+100*health/maxHealth)
			end
			table.insert(DumpedFeatureList,s)
		end
	end
	return DumpedFeatureList
end


function MakeDumpedHeightMap()
	local MatrStr="\"["
	local mx=Game.mapSizeX
	local mz=Game.mapSizeZ
	local GetGroundHeight=Spring.GetGroundHeight
	local GetGroundOrigHeight=Spring.GetGroundOrigHeight
	local abs=math.abs
	local floor=math.floor
	local hmz={}
	local hmx={}
	local h
	for z=0,mz,8 do
		for x=0,mx,8 do
			h=GetGroundHeight(x,z)
			hmx[1+x/8]=abs(h-GetGroundOrigHeight(x,z))>=1 and tostring(floor(0.5+h)) or ""
		end
		hmz[1+z/8]=table.concat(hmx,",")
	end
	return "\"[["..table.concat(hmz,"][").."]]\""
end


function GetWords(line,spacers)
	local words={}
	local str=line
	local op=nil
	local spacers=spacers or {" ","\t",","}
	local function isSpacer(s)
		for _,spacer in ipairs(spacers) do
			if spacer==s then
				return true
			end
		end
		return false
	end
	while string.len(str)>0 do
		local cursor1=1
		while isSpacer(string.sub(str,cursor1,cursor1)) and cursor1<=string.len(str) do
			cursor1=cursor1+1
		end
		local cursor2=cursor1
		while cursor2<=string.len(str) and not isSpacer(string.sub(str,cursor2,cursor2)) do
			if cursor2==1 or isSpacer(string.sub(str,cursor2-1,cursor2-1)) then -- only count + - as + - if preceded by a spacer
				if string.sub(str,cursor2,cursor2)=="+" then
					op=op and 1*op or 1
					cursor1=cursor1+1
					cursor2=cursor1
				elseif string.sub(str,cursor2,cursor2)=="-" and
					(cursor2==1 or isSpacer(string.sub(str,cursor2-1,cursor2-1))) then
					op=op and -1*op or -1
					cursor1=cursor1+1
					cursor2=cursor1
				end
			end
			cursor2=cursor2+1
		end
		if cursor1<cursor2 then
			table.insert(words,(((op and op<0) and "-") or "")..string.sub(str,cursor1,cursor2-1))
			op=nil
		end
		str=string.sub(str,cursor2,-1)
	end
	return words
end

local function isDigit(c)
	if c=="0"
	or c=="1"
	or c=="2"
	or c=="3"
	or c=="4"
	or c=="5"
	or c=="6"
	or c=="7"
	or c=="8"
	or c=="9" then
		return true
	else
		return false
	end
end

local function isNumeral(w)
	if not w then
		return nil
	end
	if string.len(w)==0 then
		return false
	end
	for c=1,string.len(w) do
		if not isDigit(string.sub(w,c,c)) then
			return false
		end
	end
	return true
end

local function isAnyKeyWord(word,KeyWords)
	if not word then
		return nil
	end
	for _,kw in ipairs(KeyWords) do
		if string.len(word)>=string.len(kw) then
			if string.lower(string.sub(word,1,string.len(kw)))==string.lower(kw) then
				if string.len(word)==string.len(kw) then
					--Spring.Echo("word "..word.." is keyword "..kw)
					return true,nil
				elseif isNumeral(string.sub(word,string.len(kw)+1,string.len(word))) then
					--Spring.Echo("word "..word.." contains keyword "..kw)
					return true,string.sub(word,string.len(kw)+1,string.len(word))
				elseif string.len(word)>=2+string.len(kw) and string.sub(word,string.len(kw)+1,string.len(kw)+1)=="_" and isNumeral(string.sub(word,string.len(kw)+2,string.len(word))) then
					--Spring.Echo("word "..word.." contains keyword "..kw.." followed by underscore")
					return true,string.sub(word,string.len(kw)+2,string.len(word))
				end
			end
		end
	end
	return false
end

local function isAnyCmdKeyWord(word,KeyCmdWords)
	if not word then
		return nil
	end
	for kwi=2,#KeyCmdWords -1 do
		local kw=KeyCmdWords[kwi]
		if string.len(word)>=string.len(kw) then
			if string.lower(string.sub(word,1,string.len(kw)))==string.lower(kw) then
				if string.len(word)==string.len(kw) then
					--Spring.Echo("word "..word.." is keyword "..kw)
					return true,nil
				elseif isNumeral(string.sub(word,string.len(kw)+1,string.len(word))) then
					--Spring.Echo("word "..word.." contains keyword "..kw)
					return true,string.sub(word,string.len(kw)+1,string.len(word))
				end
			end
		end
	end
	return false
end

function SpawnUnit(line_or_words,suggested_team) -- will return the unused words, the new ID, the former ID, or false

	local FormerID,udid,x,y,z,team,rotation,health,buildProgress,facing,NoRegenAI
	local words={}
	if type(line_or_words)=="string" then
		words=GetWords(line_or_words)
	elseif type(line_or_words)=="table" then
		words=line_or_words
	else
		return false
	end

	local function Eat(list,pos)
		return table.remove(list,pos or 1)
	end
	-- To count
	local LoopCount = 0

	while(#words>0) do

		local found,param,fcofw,fcosw,iwc
		-- fcofw = first char of first word
		-- fcosw = first char of second word
		-- iwc = initial word count

		iwc=#words
		LoopCount=LoopCount+1

		-- Skip
		found,param=isAnyKeyWord(words[1],KeyWords_Skip)
		if found then
			Eat(words)
			if not param then
				if isNumeral(words[1]) then
					param=Eat(words)
				else
					param="1"
				end
			end
			for k=1,tonumber(param) do
				Eat(words)
			end
		end

		-- Identifier
		found,param=isAnyKeyWord(words[1],KeyWords_ID)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			FormerID=tonumber(param)
		end

		-- Team
		if not team then
			found,param=isAnyKeyWord(words[1],KeyWords_Team)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				team=tonumber(param)
			end
		end

		-- UnitDefId
		if words[1] and UnitDefNames[string.lower(words[1])] and UnitDefNames[string.lower(words[1])].id and not udid then
			udid=UnitDefNames[string.lower(words[1])].id
			table.remove(words,1)
		end

		-- Position
		if (not x) and (not z) then
			found,param=isAnyKeyWord(words[1],KeyWords_Position)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				x=tonumber(param)
				z=tonumber(Eat(words))
			end
		end

		-- Position without the keyword
		if (not x) and (not z) then
			fcofw,fcosw=string.lower(string.sub(words[1],1,1)),string.lower(string.sub(words[2],1,1))
			if isDigit(fcofw) and isDigit(fcosw) then
				x=tonumber(Eat(words))
				z=tonumber(Eat(words))
			end
		end

		-- Rotation
		if not rotation then
			found,param=isAnyKeyWord(words[1],KeyWords_Rotation)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				rotation=tonumber(param)
			end
		end

		-- Rotation without the keyword (only if after position and before UnitDefName)
		if x and z and (not udid) and (not rotation) then
			fcofw=string.lower(string.sub(words[1],1,1))
			if isDigit(fcofw) then
				rotation=tonumber(Eat(words))
			end
		end

		-- Health
		if not health then
			found,param=isAnyKeyWord(words[1],KeyWords_Health)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				health=tonumber(param)
			end
		end

		-- Build Progress
		if not buildProgress then
			found,param=isAnyKeyWord(words[1],KeyWords_BuildProgress)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				buildProgress=tonumber(param)
				if GG.unitSpecialDelta then
					Spring.Echo((udid and UnitDefs[udid].name or "Unit").." under construction skipped for Gundam RTS")
					return false
				end
			end
		end

		-- NoRegenAI
		if not NoRegenAI then
			found=isAnyKeyWord(words[1],KeyWords_NoRegenAI)
			if found then
				Eat(words)
				NoRegenAI=true
			end
		end

		if iwc==#words then -- No words eaten during that loop: we exit loop
			break
		end

	end

	team = team or suggested_team
	rotation = rotation or 0
	if rotation==0 or rotation==1 or rotation==2 or rotation==4 then
		facing=rotation
		rotation=facing*90
	else
		facing=math.floor(8.5+(rotation/90))%4
	end

	if udid and x and z then
		--Spring.Echo("Spawning Initial values:")
		--Spring.Echo("Unit",UnitDefs[udid].name)
		--Spring.Echo("Position",x,z)
		--Spring.Echo("Team",team)
		--Spring.Echo("Rotation",rotation)
		--Spring.Echo("Health",health)
		--Spring.Echo("Build Progress",buildProgress)
		local NewID=Spring.CreateUnit(udid,x,0,z,facing,team,buildProgress)
		if NewID then
			--Spring.Echo(UnitDefs[udid].name.." succesfully spawned!")
			if health or buildProgress then
				if not buildProgress then
					Spring.SetUnitHealth(NewID,(health and health/100 or 1)*UnitDefs[udid].health)
				else
					Spring.SetUnitHealth(NewID,{
						health=(health and health/100 or 1)*UnitDefs[udid].health,
						build=buildProgress/100,
					})
					Spring.SetUnitBlocking(NewID,false,false)
					-- The new unit has no builder building it
					-- So it will soon decay
					-- I set it to non-blocking
					-- So the builder proceed to build a new one while the old one decays
				end
			end
			if rotation~=0 and rotation~=90 and rotation~=180 and rotation~=270 then
				Spring.SetUnitRotation(NewID,0,-2*math.pi*rotation/360,0)
			end
			if NoRegenAI then
				Spring.SetUnitRulesParam(NewID,"NoRegenAI",1)
			end
			return words,NewID,FormerID
		else
			Spring.Echo("CreateUnit failed")
			return false
		end
	else
		Spring.Echo("Sorry, could not create unit")
		if #words>0 then
			Spring.Echo("Unused words:")
			for n,w in ipairs(words) do
				Spring.Echo(" word"..n.."=\""..w.."\"")
			end
		end
		return false
	end
end

-- Take a long string or a list of strings and then return a command array:
-- {{cmdId1,params1,options1},{cmdId2,params2,options2},{cmdId3,params3,options3},...}
-- or return false in case of error.
function ReadCommands(line_or_words,OldToNew)
	local udid,x,y,z,team,rotation,health,buildProgress,facing
	local words={}
	local Commands={}
	if type(line_or_words)=="string" then
		words=GetWords(line_or_words)
	elseif type(line_or_words)=="table" then
		words=line_or_words
	else
		return false
	end
	local function Eat(list,pos)
		return table.remove(list,pos or 1)
	end
	-- To count
	local LoopCount = 0
	while(#words>0) do

		local found,param,fcofw,fcosw,iwc
		-- fcofw = first char of first word
		-- fcosw = first char of second word
		-- iwc = initial word count

		iwc=#words
		LoopCount=LoopCount+1

		-- Skip
		found,param=isAnyKeyWord(words[1],KeyWords_Skip)
		if found then
			Eat(words)
			if not param then
				if isNumeral(words[1]) then
					param=Eat(words)
				else
					param="1"
				end
			end
			for k=1,tonumber(param) do
				Eat(words)
			end
		end

		-- Build something
		found,param=isAnyKeyWord(words[1],KeyWords_Build)
		if found then
			Eat(words)
			repeat
				if not param then
					param=Eat(words)
				end
				local count=nil
				if isNumeral(param) then
					count=param
					param=Eat(words)
				end
				local WhatToBuild=UnitDefNames[string.lower(param)].id
				local x,z
				if isNumeral(words[1]) and isNumeral(words[2]) then
					x=tonumber(Eat(words))
					z=tonumber(Eat(words))
				end
				local facing=0
				found,param=isAnyKeyWord(words[1],KeyWords_BuildFacing)
				if found then
					Eat(words)
					facing=param or Eat(words)
				end
				if x and z then
					local y=Spring.GetGroundHeight(x,z)
					-- cons building buildings
					table.insert(Commands,{-WhatToBuild,{x,y,z,facing},{"shift"}})
				else
					-- factories building units
					for n=1,(count or 1) do
						table.insert(Commands,{-WhatToBuild,{},{}})
					end
				end
				param=nil
			until not (words[1] and UnitDefNames[string.lower(words[1])] or isNumeral(words[1]))
		end

		for _,cmd in ipairs(CommandList) do
			found,param=isAnyCmdKeyWord(words[1],cmd)
			if found then
				--Spring.Echo("Found: "..words[1])
				Eat(words)
				local params={}
				if param then
					table.insert(params,tonumber(param))
				end
				if words[1]=="bad_params_number" then
					if cmd[1]==CMD.REPAIR then
						Spring.Echo("bad_params_number in CMD.REPAIR, aborting")
						break
					end
					Spring.Echo("bad_params_number, issuing the "..cmd[2].." order with all params anyway")
					Eat(words)
				end

				-- If that is a command that wants an unit id
				if #params==0 and (cmd[#cmd]==CMDTYPE.ICON_UNIT
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_MAP
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_AREA
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_RECTANGLE
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_FEATURE_OR_AREA) then
					found,param=isAnyKeyWord(words[1],KeyWords_ID)
					if found then
						Eat(words)
						if not param then
							param=Eat(words)
						end
						table.insert(params,tonumber(param))
					end
				end

				-- Get all the numeral as parameters to this command
				while(isNumeral(words[1])) do
					table.insert(params,tonumber(Eat(words)))
				end

				-- Add the y to x,z commands
				if #params==2 then
					table.insert(params,2,Spring.GetGroundHeight(params[1],params[2]))
				end

				-- Translate units ID
				if #params==1 and (cmd[#cmd]==CMDTYPE.ICON_UNIT
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_MAP
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_AREA
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_OR_RECTANGLE
								or cmd[#cmd]==CMDTYPE.ICON_UNIT_FEATURE_OR_AREA) then
					if OldToNew[params[1]] then
						params={OldToNew[params[1]]}
						if not Spring.ValidUnitID(params[1]) then
							Spring.Echo("Error, "..cmd[2].." order on invalid translated ID_"..params[1])
							break
						end
					else
						Spring.Echo("Error, "..cmd[2].." order on invalid ID_"..params[1])
						break
					end
				end

				if cmd[1]==CMD_IF_UNIT_IN_AREA then
					if #params+#words<2 then
						Spring.Echo("Not enough words left for CMD_IF_UNIT_IN_AREA")
						break
					end
					-- First parameter should be the cmd
					if #params==0 then
						table.insert(params,Eat(words))
					end
					if isNumeral(params[1]) then
						params[1]=tonumber(params[1])
					else
						for _,cmd2 in ipairs(CommandList) do
							found=isAnyCmdKeyWord(params[1],cmd2)
							if found then
								params[1]=cmd2[1]
								break
							end
						end
					end
					-- Second parameter should be the UnitDefName
					if #params==1 then
						table.insert(params,Eat(words))
					end
					if not isNumeral(params[2]) then
						if not UnitDefNames[params[2]].id then
							Spring.Echo("Error, ".." cmd involving unit with invalid unit type \""..tostring(params[1]).."\"")
							break
						else
							params[2]=UnitDefNames[params[2]].id
						end
					end
					while isNumeral(words[1] or "x") do
						table.insert(params,tonumber(Eat(words)))
					end
					if params[3] and params[4] then
						table.insert(params,4,Spring.GetGroundHeight(params[3],params[4]))
					end
					local pt="CMD_IF_UNIT_IN_AREA with params={"
					for _,p in ipairs(params) do
						pt=pt.."("..type(p)..")"..tostring(p)..","
					end
					pt=pt.."}"
					Spring.Echo(pt)
				end

				if cmd[1]==CMD_TRIGGERWAIT then
					if #params+#words<1 then
						Spring.Echo("Not enough words left for CMD_TRIGGERWAIT")
						break
					end
					if #params==0 then
						params={Eat(words)}
					end
					if type(params[1])=="number" then
						params[1]=tostring(params[1])
					end
					params[1]=string.lower(params[1])
					if GG.MissionTrigger.FromNames[params[1]] then
						params[1]=GG.MissionTrigger.FromNames[params[1]]
					elseif isNumeral(params[1]) and GG.MissionTrigger.FromNames["trigger"..params[1]] then
						params[1]=GG.MissionTrigger.FromNames["trigger"..params[1]]
					else
						Spring.Echo("Bad trigger name \""..tostring(params[1]).."\" in CMD_TRIGGERWAIT")
						break
					end
				end

				-- Echo what command we're about to issue for debug purpose:
				--Spring.Echo("Spring.GiveOrderToUnit(ID, "..cmd[1].." ("..cmd[2].."), {"..table.concat(params,",").."}, {\"shift\"})")

				-- Give the order:
				table.insert(Commands,{cmd[1],params,{"shift"}})
			end
		end

		-- Unnamed order (for ex: o115, CMD_115, Order 115)
		found,cmd_id=isAnyKeyWord(words[1],KeyWords_Order)
		if found then
			Eat(words)
			if not cmd_id then
				cmd_id=Eat(words)
			end
			params={}
			while(isNumeral(words[1])) do
				table.insert(params,tonumber(Eat(words)))
			end
			table.insert(Commands,{tonumber(cmd_id),params,{"shift"}})
		end

		if iwc==#words then -- No words eaten during that loop: we skip the word, and all following numeral
			local LostTxt=Eat(words)
			while(isNumeral(words[1])) do
				LostTxt=LostTxt.." "..Eat(words)
			end
			Spring.Echo("Skipping unknown command: "..LostTxt)
		end

	end
	return Commands
end

function AssignOrder(line_or_words,OldToNew) -- will return the unused words
	local udid,x,y,z,team,rotation,health,buildProgress,facing
	local words={}
	if type(line_or_words)=="string" then
		words=GetWords(line_or_words)
	elseif type(line_or_words)=="table" then
		words=line_or_words
	else
		return false
	end
	local function Eat(list,pos)
		return table.remove(list,pos or 1)
	end
	-- To count
	local LoopCount = 0

	local NewID,OldID=nil

	found,param=isAnyKeyWord(words[1],{"NID","NewID"})
	if found then
		Eat(words)
		if not param then
			param=Eat(words)
		end
		NewID=tonumber(param)
	else
		Spring.Echo("Error: No NewID in AssignOrder!")
		return false
	end

	local Commands=ReadCommands(line_or_words,OldToNew)
	if Commands then
		Spring.GiveOrderArrayToUnitArray({NewID},Commands)
	else
		Spring.Echo("Error reading commands: \""..tostring(line_or_words).."\"")
	end

end

function ListUsedIDs()
	local UsedIDs={}
	for _,u in ipairs(Spring.GetAllUnits()) do
		for _,o in ipairs(Spring.GetCommandQueue(u) or {}) do
			if #o.params==1 then -- May count as ID a few params that aren't, but better more than not enough
				UsedIDs[o.params[1]]=u
			end
		end
	end
	return UsedIDs
end


function GetFullScript()
	if Spring.GetModOptions().PreviousGetModOptionsFunc then
		Spring.Echo("ModOptions already set to full!")
		return
	elseif not Spring.GetModOptions()["fullscript"] then
		--Spring.Echo("There is no \"fullscript\" tag in trimmed script!") -- normal for a normal script
		return
	elseif not VFS.FileExists(Spring.GetModOptions()["fullscript"]) then
		Spring.Echo("Full script file \""..Spring.GetModOptions()["fullscript"].."\" does not exist!")
		return
	end
	return VFS.LoadFile(Spring.GetModOptions()["fullscript"])
end

function SetModOptionsToFull(fullstartscript)
	if Spring.GetModOptions().PreviousGetModOptionsFunc then
		Spring.Echo("ModOptions already set to full!")
		return
	end
	if type(fullstartscript)~="string" then
		Spring.Echo("Requires start script string!")
		return
	end
	-- Parsing the full script
	local TDF = VFS.Include('maphelper/parse_tdf.lua')
	local scriptdata,msg = TDF.ParseText(fullstartscript) -- I wish I could have used TDF.ParseFile(Spring.GetModOptions()["fullscript"]) but synced cannot see files out of mod
	if not scriptdata then
		Spring.Echo("Failed to parse the full start script"..(msg and "with error:"..msg or "!"))
		Spring.Echo("\n\n<<Beging Dumping Parse-Failed Start Script>>\n\n")
		Spring.Echo(fullstartscript)
		Spring.Echo("\n\n<<End Dumping Parse-Failed Start Script>>\n\n")
		return
	end
	local gamedata=scriptdata.game
	if not gamedata then
		Spring.Echo("Missing gamedata section")
		return
	end
	if not gamedata.modoptions then
		Spring.Echo("Missing modoptions section")
		return
	end
	for key,value in pairs(gamedata.modoptions) do
		gamedata[key]=value
	end
	local FullModOptions={}
	local FullTeamModOptions={}
	for _,t in ipairs(Spring.GetTeamList()) do
		FullTeamModOptions[t]={}
	end
	for key,value in pairs(gamedata) do
		--Spring.Echo("[GAME]["..tostring(key).."]="..(string.len(tostring(value))<80 and tostring(value) or " "..string.len(tostring(value)).. " bytes long"))
		if type(value)=="string" then
			FullModOptions[key]=value
		elseif type(value)=="table" then
			local teamID=string.match(key,"team(%d+)")
			if teamID then
				local teamID=tonumber(teamID)
				if not FullTeamModOptions[teamID] then
					Spring.Echo("Full start script contains custom team mod option for unknown team "..teamID)
				else
					for k,v in pairs(value) do
						if type(v)=="string" then
							--Spring.Echo("[TEAM"..teamID.."]["..k.."]="..v)
							FullTeamModOptions[teamID][k]=v
						else
							Spring.Echo("Full start script contains custom team"..teamID.." mod option of unknown type: "..type(v))
						end
					end
				end
			end
		else
			Spring.Echo("Full start script contains mod option of unknown type: "..type(value))
		end
	end
	-- Add-overwrite the key/value from the true Spring.GetModOptions()
	for key,value in pairs(Spring.GetModOptions()) do
		FullTeamModOptions[key]=value
	end
	-- Add-overwrite the key/value from the true Spring.GetTeamInfo()
	local FullTeamInfo={}
	for _,t in ipairs(Spring.GetTeamList()) do
		--teamID,leader,isDead,isAiTeam,side,allyTeam,customTeamKeys,more1,more2,more3=Spring.GetTeamInfo(t)
		FullTeamInfo[t]={Spring.GetTeamInfo(t)}
		if type(FullTeamInfo[t][7])~="table" then
			Spring.Echo("The 7th return of GetTeamInfo is not a table!")
		else
			for key,value in pairs(FullTeamModOptions[t]) do
				if FullTeamInfo[t][7][key]==nil then
					FullTeamInfo[t][7][key]=value
				end
			end
		end
		FullTeamInfo[t][7].PreviousGetTeamInfoFunc=Spring.GetTeamInfo
	end
	FullModOptions.PreviousGetModOptionsFunc=Spring.GetModOptions
	FullTeamInfo.PreviousGetTeamInfoFunc=Spring.GetTeamInfo
	local function GetFullModOptions()
		return FullModOptions
	end
	local function GetFullTeamInfo(t)
		return unpack(FullTeamInfo[t])
	end
	Spring.GetModOptions=GetFullModOptions
	Spring.GetTeamInfo=GetFullTeamInfo
end


function SpawnFeature(line_or_words,suggested_team)

	local FormerID,fdid,x,y,z,team,rotation,health,resurrectProgress,heading
	local words={}
	if type(line_or_words)=="string" then
		words=GetWords(line_or_words)
	elseif type(line_or_words)=="table" then
		words=line_or_words
	else
		return false
	end

	local function Eat(list,pos)
		return table.remove(list,pos or 1)
	end
	-- To count
	local LoopCount = 0

	while(#words>0) do

		local found,param,fcofw,fcosw,iwc
		-- fcofw = first char of first word
		-- fcosw = first char of second word
		-- iwc = initial word count

		iwc=#words
		LoopCount=LoopCount+1

		-- Skip
		found,param=isAnyKeyWord(words[1],KeyWords_Skip)
		if found then
			Eat(words)
			if not param then
				if isNumeral(words[1]) then
					param=Eat(words)
				else
					param="1"
				end
			end
			for k=1,tonumber(param) do
				Eat(words)
			end
		end

		-- Identifier
		found,param=isAnyKeyWord(words[1],KeyWords_ID)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			FormerID=tonumber(param)
		end

		-- Team
		if not team then
			found,param=isAnyKeyWord(words[1],KeyWords_Team)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				team=tonumber(param)
			end
		end

		-- FeatureDefId
		if FeatureDefNames[words[1]] and FeatureDefNames[words[1]].id and not fdid then
			fdid=FeatureDefNames[words[1]].id
			table.remove(words,1)
		end

		-- Position
		if (not x) and (not z) then
			found,param=isAnyKeyWord(words[1],KeyWords_Position)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				x=tonumber(param)
				z=tonumber(Eat(words))
			end
		end

		-- Position without the keyword
		if (not x) and (not z) then
			fcofw,fcosw=string.lower(string.sub(words[1],1,1)),string.lower(string.sub(words[2],1,1))
			if isDigit(fcofw) and isDigit(fcosw) then
				x=tonumber(Eat(words))
				z=tonumber(Eat(words))
			end
		end

		-- Rotation
		if not rotation then
			found,param=isAnyKeyWord(words[1],KeyWords_Rotation)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				rotation=tonumber(param)
			end
		end

		-- Rotation without the keyword (only if after position and before UnitDefName)
		if x and z and (not fdid) and (not rotation) then
			fcofw=string.lower(string.sub(words[1],1,1))
			if isDigit(fcofw) then
				rotation=tonumber(Eat(words))
			end
		end

		-- Health
		if not health then
			found,param=isAnyKeyWord(words[1],KeyWords_Health)
			if found then
				Eat(words)
				if not param then
					param=Eat(words)
				end
				health=tonumber(param)
			end
		end

		if iwc==#words then -- No words eaten during that loop: we exit loop
			break
		end

	end

	team = team or suggested_team
	rotation = rotation or 0
	if rotation==0 or rotation==1 or rotation==2 or rotation==4 then
		rotation=rotation*90
	end
	heading=rotation*65536/360

	if fdid and x and z then
		--Spring.Echo("Spawning Initial values:")
		--Spring.Echo("Feature",FeatureDefs[fdid].name)
		--Spring.Echo("Position",x,z)
		--Spring.Echo("Team",team)
		--Spring.Echo("Rotation",rotation)
		--Spring.Echo("Heading",rotation)
		--Spring.Echo("Health",health)
		local y=Spring.GetGroundHeight(x,z)
		local NewID=Spring.CreateFeature(fdid,x,y,z,heading,team)
		if NewID then
			if health then
				Spring.SetFeatureHealth(NewID,(health and health/100 or 1)*FeatureDefs[fdid].maxHealth)
			end
			return words,NewID,FormerID
		else
			Spring.Echo("CreateFeature failed")
			return false
		end
	else
		Spring.Echo("Sorry, could not decode feature spawning")
		if #words>0 then
			Spring.Echo("Unused words:")
			for n,w in ipairs(words) do
				Spring.Echo(" word"..n.."=\""..w.."\"")
			end
		end
		return false
	end
end


function SpawnUnitList(UnitToSpawnList)
	local OldToNew={}
	local NewToOld={}
	local WordsLeftList={}
	for li,ls in ipairs(UnitToSpawnList) do
		local status,ret1,ret2,ret3=pcall(SpawnUnit,ls)
		if not status then
			Spring.Echo("SpawnUnit failed to decode \""..ls.."\"")
			Spring.Echo("The error was: "..ret1)
		else
			local NewID=ret2
			local OldID=ret3
			if NewID then
				table.insert(ret1,1,"NewID_"..NewID)
				if OldID then
					OldToNew[OldID]=NewID
					NewToOld[NewID]=OldID
				end
			end
		end
		table.insert(WordsLeftList,ret1 or {})
	end
	return {OldToNew=OldToNew,NewToOld=NewToOld,WordsLeftList=WordsLeftList}
end

SpawnTable=nil -- Keeps the old<->new unit ID conversion table, and the orders that are delayed to a few frames after unit creation

function AssignOrdersList(UnitsOrdersTables)
	local WordsLeftList={}
	for li,lw in ipairs(UnitsOrdersTables.WordsLeftList) do
		local status,ret1=pcall(AssignOrder,lw,UnitsOrdersTables.OldToNew)
		if not status then
			Spring.Echo("AssignOrder failed to decode:")
			for n,w in ipairs(lw) do
				Spring.Echo(" word"..n.."=\""..w.."\"")
			end
			Spring.Echo("The error was: "..ret1)
		end
	end
	return {}
end

function SpawnFeatureList(FeatureToSpawnList)
	for li,ls in ipairs(FeatureToSpawnList) do
		local status,ret1,ret2,ret3=pcall(SpawnFeature,ls)
		if not status then
			Spring.Echo("SpawnFeature failed to decode \""..ls.."\"")
			Spring.Echo("The error was: "..ret1)
		end
	end
end

function ReadTrigger(line_or_words)

	local Name,Teams,UnitCount,UnitTypes,Triggers,SelectionShape,Period,Constructed,Once,Action,Message=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil

	local words={}
	if type(line_or_words)=="string" then
		words=GetWords(line_or_words)
	elseif type(line_or_words)=="table" then
		words=line_or_words
	else
		return false
	end

	local function Eat(list,pos)
		return table.remove(list,pos or 1)
	end

	-- Catch any message at the end 
	for i=1,#words do
		if isAnyKeyWord(words[i],KeyWords_Echo) then
			Message=table.concat(words," ",i+1,#words)
			for j=#words,i,-1 do
				table.remove(words)
			end
			break
		end
	end

	-- To count
	local LoopCount = 0

	while(#words>0) do

		local found,param,fcofw,fcosw,iwc
		-- fcofw = first char of first word
		-- fcosw = first char of second word
		-- iwc = initial word count

		iwc=#words
		LoopCount=LoopCount+1

		-- Skip
		found,param=isAnyKeyWord(words[1],KeyWords_Skip)
		if found then
			Eat(words)
			if not param then
				if isNumeral(words[1]) then
					param=Eat(words)
				else
					param="1"
				end
			end
			for k=1,tonumber(param) do
				Eat(words)
			end
		end

		-- Name
		found,param=isAnyKeyWord(words[1],KeyWords_Name)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			Name=string.lower(param)
		end

		-- Period
		found,param=isAnyKeyWord(words[1],KeyWords_Period)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			Period=tonumber(param)
		end

		-- Team
		found,param=isAnyKeyWord(words[1],KeyWords_Team)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			Teams={tonumber(param)}
			while isNumeral(words[1]) do
				table.insert(Teams,tonumber(Eat(words)))
			end
		end

		-- InDisk
		found,param=isAnyKeyWord(words[1],KeyWords_InDisk)
		if found then
			if SelectionShape then
				Spring.Echo("Warning two selection shapes in same trigger!")
			end
			Eat(words)
			if not param then
				param=Eat(words)
			end
			local x,z,r=param,Eat(words),Eat(words)
			if isNumeral(x) and isNumeral(z) and isNumeral(r) then
				SelectionShape={Spring.GetUnitsInCylinder,tonumber(x),tonumber(z),tonumber(r)}
			else
				Spring.Echo("Bad parameters to InDisk: x=\""..tostring(x).."\" z=\""..tostring(z).."\" r=\""..tostring(r).."\"")
			end
		end

		-- InRect
		found,param=isAnyKeyWord(words[1],KeyWords_InRect)
		if found then
			if SelectionShape then
				Spring.Echo("Warning two selection shapes in same trigger!")
			end
			Eat(words)
			if not param then
				param=Eat(words)
			end
			local x1,z1,x2,z2=param,Eat(words),Eat(words),Eat(words)
			if isNumeral(x1) and isNumeral(z1) and isNumeral(x2) and isNumeral(z2) then
				SelectionShape={Spring.GetUnitsInRectangle,tonumber(x1),tonumber(z1),tonumber(x2),tonumber(z2)}
			else
				Spring.Echo("Bad parameters to InRect: x1=\""..tostring(x).."\" z1=\""..tostring(z).."\" x2=\""..tostring(z).."\" z2=\""..tostring(z).."\"")
			end
		end

		if isNumeral(words[1]) then
			if not UnitCount then
				UnitCount=tonumber(Eat(words))
			else
				Spring.Echo("Error unexpected number: "..Eat(words))
			end
		end

		-- Unit Types
		if UnitDefNames[string.lower(words[1] or "")] then
			if not UnitTypes then
				UnitTypes={}
			end
			table.insert(UnitTypes,UnitDefNames[string.lower(Eat(words))].id)
		end

		-- Constructed
		found,param=isAnyKeyWord(words[1],KeyWords_BuildProgress)
		if found then
			Eat(words)
			if not param and isNumeral(words[1]) then
				param=Eat(words)
			end
			Constructed=param and tonumber(param)/100 or 1
		end

		-- Trigger
		found,param=isAnyKeyWord(words[1],KeyWords_Trigger)
		if found then
			Eat(words)
			if not param then
				param=Eat(words)
			end
			if not Triggers then
				Triggers={string.lower(param)}
			else
				table.insert(Triggers,string.lower(param))
			end
		end

		-- Once
		found,param=isAnyKeyWord(words[1],KeyWords_Once)
		if found then
			Eat(words)
			if not param and isNumeral(words[1]) then
				param=Eat(words)
			end
			if (not param) or tonumber(param)~=0 then
				Once=true
			end
		end

		if iwc==#words then -- No words eaten during that loop: they must be actions!
			Action=ReadCommands(words,{})-- Second parameter is supposed to be OldToNew ID list
			break
		end

		--if iwc==#words then -- No words eaten during that loop: we exit loop
		--	if #words>0 then
		--		Spring.Echo("Unused words for trigger: "..table.concat(words," "))
		--	end
		--	break
		--end

	end

	-- Optimisation:
	-- GetUnitsInCylinder and GetUnitsInRectangle can take an optional argument teamID
	-- Use it if only one team, and then remove the redundant Teams field
	if Teams and SelectionShape and #Teams==1 then
		table.insert(SelectionShape,Teams[1])
		Teams=nil
	end

	if not Name then
		Spring.Echo("Error unnamed trigger!") -- Unlikely to happen, as name default to the trigger number
	else
		return {Name=Name, Period=Period, Teams=Teams, SelectionShape=SelectionShape, UnitCount=UnitCount, UnitTypes=UnitTypes, Constructed=Constructed, Triggers=Triggers, Once=Once, Action=Action, Message=Message}
	end

end

function SpawnTriggerList(TriggerToSpawnList)
	local TriggersTable={}
	for li,ls in ipairs(TriggerToSpawnList) do
		local status,ret=pcall(ReadTrigger,ls)
		if not status then
			Spring.Echo("ReadTrigger failed to decode \""..ls.."\"")
			Spring.Echo("The error was: "..ret)
		elseif type(ret)=="table" then
			table.insert(TriggersTable,ret)
		end
	end
	return TriggersTable
end

function HeightMapV1Func(m)
	local match=string.match
	local gmatch=string.gmatch
	local SetHeightMap=Spring.SetHeightMap
	local x=0
	local z=0
	if string.sub(m,1,1)=="\"" and string.sub(m,-1)=="\"" then
		m=string.sub(m,2,string.len(m)-1)
	end
	local m=match(m,"%[(.*)%]")
	if m then
		for l in gmatch(m,"%[(.-)%]") do
			if l then
				for r in gmatch(l..",","([^%,]*),") do
					if r then
						local h=match(r,"[%-%.%d]+")
						if h then
							SetHeightMap(x,z,tonumber(h))
						--else
						--	SetHeightMap(x,z,Spring.GetGroundOrigHeight(x,z))
						end
					end
					x=x+8
				end
			end
			z=z+8
			x=0
		end
	end
end

function SpawnHeightMap()
	if Spring.GetModOptions()["heightmapv1"] then
		local status,ret=pcall(Spring.SetHeightMapFunc,HeightMapV1Func,Spring.GetModOptions()["heightmapv1"])
		if not status then
			Spring.Echo("HeightMap restoration failed: "..tostring(ret))
		else
			Spring.Echo("HeightMap restored")
		end
	else
		--Spring.Echo("HeightMap tag not found!") -- normal for a normal script
	end
end


function SpawnAllUnits()
	--  Make list of already present units
	local PreviousUnits={}
	-- Mark to remove all units and remove all features if tags in modoption (not team specific)
	local RemoveAllUnits=((tonumber(Spring.GetModOptions()["removeunits"]) or 0)~=0)
	local RemoveAllFeatures=((tonumber(Spring.GetModOptions()["removefeatures"]) or 0)~=0)
	if RemoveAllUnits then
		for _,u in ipairs(Spring.GetAllUnits()) do
			table.insert(PreviousUnits,u)
		end
	end
	if RemoveAllFeatures then
		for _,f in ipairs(Spring.GetAllFeatures()) do
			Spring.DestroyFeature(f)
		end
	end
	local UnitList={}
	for _,t in ipairs(Spring.GetTeamList()) do
		local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(t)
		if CustomTeamOptions then
			-- Mark to remove all team units and remove all team features if tags in team specific modoption
			if (tonumber(CustomTeamOptions["removeunits"]) or 0)~=0 and not RemoveAllUnits then
				for _,u in ipairs(Spring.GetTeamUnits(t)) do
					table.insert(PreviousUnits,u)
				end
			end
			if (tonumber(CustomTeamOptions["removefeatures"]) or 0)~=0 and not RemoveAllFeatures then
				for _,f in ipairs(Spring.GetAllFeatures()) do
				if Spring.GetFeatureTeam(f)==t then
					Spring.DestroyFeature(f)
					end
				end
			end
			-- List units to spawn according to team specific modoption
			for key,value in pairs(CustomTeamOptions) do
				if string.len(key)>=2 and string.sub(key,1,1)=="u" then
					local ok=true
					for cn=2,string.len(key) do
						local c=string.sub(key,cn,cn)
						if c~="0" and c~="1" and c~="2" and c~="3" and c~="4" and c~="5" and c~="6" and c~="7" and c~="8" and c~="9" then
							ok=false
						end
					end
					if ok then
						if string.sub(value,1,1)=="\"" and string.sub(value,-1)=="\"" then
							value=string.sub(value,2,string.len(value)-1)
						end
						table.insert(UnitList,"ID -"..(1+#UnitList).." T"..t.." "..value)
					end
				end
			end
			if CustomTeamOptions["researched"] and GG.GrantInstantResearch then
				for _,rn in ipairs(GetWords(CustomTeamOptions["researched"],{","})) do
						GG.GrantInstantResearch(t,rn)
				end
			end
		end
	end
	-- Spawn all the units found in startscript
	SpawnTable=SpawnUnitList(UnitList)
	-- Remove old units
	for _,u in ipairs(PreviousUnits) do
		Spring.DestroyUnit(u,false,true,u)
	end
end

function SpawnAllFeatures()
	local FeatureList={}
	for _,t in ipairs(Spring.GetTeamList()) do
		local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(t)
		if CustomTeamOptions then
			-- List features to spawn according to team specific modoption
			for key,value in pairs(CustomTeamOptions) do
				if string.len(key)>=2 and string.sub(key,1,1)=="f" then
					local ok=true
					for cn=2,string.len(key) do
						local c=string.sub(key,cn,cn)
						if c~="0" and c~="1" and c~="2" and c~="3" and c~="4" and c~="5" and c~="6" and c~="7" and c~="8" and c~="9" then
							ok=false
						end
					end
					if ok then
						table.insert(FeatureList,"T"..t.." "..value)
					end
				end
			end
		end
	end
	-- Spawn all the features found in startscript
	SpawnFeatureList(FeatureList)
end

function PrintIdConversionTables()
	if SpawnTable then
		for old, new in pairs(SpawnTable.OldToNew) do
			if Spring.ValidUnitID(new) then
				Spring.Echo("Unit with previous ID "..old.." became "..new)
			else
				Spring.Echo("Unit with previous ID "..old.." became "..new.." INVALID ID!!!")
			end
		end
		for _,new in ipairs(Spring.GetAllUnits()) do
			if SpawnTable.NewToOld[new] then
				Spring.Echo("New unit "..new.." was previously "..SpawnTable.NewToOld[new])
			else
				Spring.Echo("New unit "..new.." reincaranation info broken.")
			end
		end
	else
		Spring.Echo("No SpawnTable!")
	end
end

function SpawnAllOrders()
	--PrintIdConversionTables()
	if SpawnTable then
		AssignOrdersList(SpawnTable)
	else
		Spring.Echo("Order Restoration skipped: No SpawnTable!")
	end
	SpawnTable=nil
end

function RemoveUnitFromSpawn(u)
	if SpawnTable then
		if SpawnTable.NewToOld[u] then
			Spring.Echo("Unit["..u.."], formerly ["..(SpawnTable.NewToOld[u] or "?").."], dead, removing its ID from NewToOld and OldToNew")
			SpawnTable.OldToNew[SpawnTable.NewToOld[u]]=nil
			SpawnTable.NewToOld[u]=nil
		end
		if SpawnTable.WordsLeftList then
			for wli=#SpawnTable.WordsLeftList,1,-1 do
				if type(SpawnTable.WordsLeftList[wli])=="table" and type(SpawnTable.WordsLeftList[wli][1])=="string" then
					if SpawnTable.WordsLeftList[wli][1]=="ID_"..u then
						table.remove(SpawnTable.WordsLeftList,wli)
						Spring.Echo("Unit["..u.."] dead, removing its words left")
					end
				end
			end
		end
	end
end

function SpawnResources()
	for _,team in ipairs(Spring.GetTeamList()) do
		local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(team)
		if CustomTeamOptions then
			if CustomTeamOptions["startmetal"] and tonumber(CustomTeamOptions["startmetal"]) then
				Spring.SetTeamResource(team,"m",tonumber(CustomTeamOptions["startmetal"]))
			end
			if CustomTeamOptions["startenergy"] and tonumber(CustomTeamOptions["startenergy"]) then
				Spring.SetTeamResource(team,"e",tonumber(CustomTeamOptions["startenergy"]))
			end
		end
	end
end

function SpawnAllTriggers()
	-- List triggers to spawn according to team specific modoption
	local TriggerList={}
	for key,value in pairs(Spring.GetModOptions()) do
		if string.len(key)>=8 and string.sub(key,1,7)=="trigger" then
			local ok=true
			for cn=8,string.len(key) do
				local c=string.sub(key,cn,cn)
				if c~="0" and c~="1" and c~="2" and c~="3" and c~="4" and c~="5" and c~="6" and c~="7" and c~="8" and c~="9" then
					ok=false
				end
			end
			if ok then
				if string.sub(value,1,1)=="\"" and string.sub(value,-1)=="\"" then
					value=string.sub(value,2,string.len(value)-1)
				end
				table.insert(TriggerList,1,"name AutoNamedTrigger"..key.." "..value)
			end
		end
	end
	GG.MissionTrigger.Equ=SpawnTriggerList(TriggerList)
	local TriggersFromNames={}
	for i,t in ipairs(GG.MissionTrigger.Equ) do
		TriggersFromNames[t.Name]=i
	end
	GG.MissionTrigger.FromNames=TriggersFromNames
end

-- It's not fast, I just wish it was:
local function FastAddLists(t1,t2)
	if #t1>#t2 then
		for _,e in ipairs(t2) do
			table.insert(t1,e)
		end
		return t1
	else
		for _,e in ipairs(t1) do
			table.insert(t2,e)
		end
		return t2
	end
end

function RefreshTriggers(frame)

	for i,t in pairs(GG.MissionTrigger.Equ) do
		if (not t.Period) or (frame%t.Period==0) then

			if t.Once and GG.MissionTrigger.States[i] then
				GG.MissionTrigger.Equ[i]=nil
				if Spring.IsCheatingEnabled() then
					Spring.Echo("Trigger["..i.."]=\""..(t.Name or "?").."\" removed!")
				end
			else

				local sel=true
				if t.SelectionShape then
					sel=t.SelectionShape[1](select(2,unpack(t.SelectionShape)))
					if t.Teams then
						for i,u in ipairs(sel) do
							local keep=false
							local ut=Spring.GetUnitTeam(u)
							for _,team in ipairs(t.Teams) do
								if team==ut then
									keep=true
								end
							end
							if not keep then
								table.remove(sel,i)
							end
						end
					end
					if t.UnitTypes then
						for i,u in ipairs(sel) do
							local keep=false
							local ud=Spring.GetUnitDefID(u)
							for _,udefid in ipairs(t.UnitTypes) do
								if udefid==ud then
									keep=true
								end
							end
							if not keep then
								table.remove(sel,i)
							end
						end
					end
				elseif t.Teams then
					if t.UnitTypes then
						sel={}
						for _,team in ipairs(t.Teams) do
							sel=FastAddLists(sel,Spring.GetTeamUnitsByDefs(team,t.UnitTypes))
						end
					else
						sel={}
						for _,team in ipairs(t.Teams) do
							sel=FastAddLists(sel,Spring.GetTeamUnits(team))
						end
					end
				elseif t.UnitTypes then
					sel={}
					for _,team in ipairs(Spring.GetTeamList()) do
						sel=FastAddLists(sel,Spring.GetTeamUnitsByDefs(team,t.UnitTypes))
					end
				else
					sel=Spring.GetAllUnits()
				end

				if sel and t.Constructed then
					local c=t.Constructed
					for i,u in ipairs(sel) do
						if select(5,Spring.GetUnitHealth(u))<c then
							table.remove(sel,i)
						end
					end
				end

				if t.Triggers then
					for _,tn in ipairs(t.Triggers) do
						if not GG.MissionTrigger.States[GG.MissionTrigger.FromNames[tn]] then
							sel={}
						end
					end
				end

				if type(sel)~="table" then
					Spring.Echo("Error: Something is wrong with Trigger["..i.."]=\""..(t.Name or "?").."\", sel is not a table!")
				elseif #sel>=(t.UnitCount or 1) then
					if not GG.MissionTrigger.States[i] then
						if Spring.IsCheatingEnabled() then
							Spring.Echo("Trigger["..i.."]=\""..(t.Name or "?").."\" activated!")
						end
						if t.Message then
							Spring.Echo("\255\96\255\255"..t.Message)
						end
					end
					if t.Action then
						Spring.GiveOrderArrayToUnitArray(sel,t.Action)
						--Spring.Echo("Trigger["..i.."]=\""..(t.Name or "?").."\" gave "..#t.Action.." orders to "..#sel.." units.")
					end
					GG.MissionTrigger.States[i]=true
				else
					if Spring.IsCheatingEnabled() and GG.MissionTrigger.States[i] then
						Spring.Echo("Trigger["..i.."]=\""..(t.Name or "?").."\" deactivated!")
					end
					GG.MissionTrigger.States[i]=false
				end

			end
		end
	end
end

function DisplayGetWords(str)
	Spring.Echo("Testing \""..str.."\"")
	local words=GetWords(str)
	for n,w in ipairs(words) do
		Spring.Echo(" word"..n.."=\""..w.."\"")
	end
end

function TestDisplayGetWords(str)
	DisplayGetWords("D'abord le cas normal")
	DisplayGetWords(" espaces	avant et après ")
	DisplayGetWords(" 	 ")
	DisplayGetWords("	")
	DisplayGetWords("")
end



function GenerateFromCurrentState(Abbreviated,Grid,OnlyStartScript,WithHeightMap)
	local WorksSoFar=true
	local script=nil

	local player_num=-1
	local TeamFromPlayer = {}
	for _,t in ipairs(Spring.GetTeamList()) do
		if t~=Spring.GetGaiaTeamID() then
			table.insert(TeamFromPlayer,t)
			if t==Spring.GetMyTeamID() then
				player_num=#TeamFromPlayer
			end
		end
	end


	if not FillModSpecific then
		Spring.Echo("Error, there is no FillModSpecific to call!!")
	else
		FillModSpecific()
	end

	script={}
	script.map = {InternalFileName=Game.mapName}
	script.players={}
	script.isSpeccing=Spring.GetSpectatingState() and 1 or 0
	script.ModOptions={}
	if ModSpecific and ModSpecific.MultiplayerModOptions then
		for _,mo in pairs(ModSpecific.MultiplayerModOptions) do
			script.ModOptions[mo.key]=Spring.GetModOptions()[mo.key] or mo.def
		end
	end
	script.ModOptions["ons"]=tonumber(Spring.GetModOptions()["ons"] or 0)
	script.ModOptions["sos"]=tonumber(Spring.GetModOptions()["sos"] or 0)
	script.ModOptions["colorwars"]= OnlyStartScript
				and (tonumber(Spring.GetModOptions()["colorwars"] or 0))
				or ((SYNCED and SYNCED.ColorWars and SYNCED.ColorWars.DoomsSecond) and ((SYNCED.ColorWars.DoomsSecond-Spring.GetGameSeconds())/60) or 0)
	script.ModOptions["preplaced"]=Spring.GetModOptions()["preplaced"]
	script.StartPosType=Game.startPosType
	script.EndCondition=Game.gameMode
	script.PlayerName=Spring.GetPlayerInfo(Spring.GetMyPlayerID())
	script.NbrPlayers=#TeamFromPlayer
	script.PlayerTeamNum=player_num-1 --- script.PlayerTeamNum is the number as in the script, starting at 0, while player_num is the one for when counting from 1

	script.ModOptions.missionscript=Spring.GetModOptions()["missionscript"]
	if script.ModOptions.missionscript then
		script.ModOptions.missiontitle="Reloaded Mission"
		script.ModOptions.missionbriefing="\""
			.."Using savegames during mission\\n"
			.."resets RegenAI and timers,\\n"
			.."disrupting the balance.\\n \\n"
			.."Please instead consider\\n"
			.."using the restart button.\""
	end

	-- Create all players / teams
	-- One player, either human or bot, per team
	-- If you dump a multiplayer game, teams of other player will get replaced by empty bot
	local UsedIDs=ListUsedIDs()
	for p=1, script.NbrPlayers do
		local teamNum,leader,isDead,isAiTeam,side,allyTeam,teamCustomOptions = Spring.GetTeamInfo(TeamFromPlayer[p])
		script.players[p]={}
		script.players[p].allyteam=allyTeam
		script.players[p].faction={InternalName=side}
		script.players[p].color={Spring.GetTeamOrigColor(TeamFromPlayer[p])}
		script.players[p].ExtraDoubleCustomKeys={}
		local spx,spy,spz=Spring.GetTeamStartPosition(TeamFromPlayer[p])
		if spx and spz then
			script.players[p].StartPosX=spx
			script.players[p].StartPosZ=spz
		end
		if OnlyStartScript then
			-- Nothing
		else
			local metal=Spring.GetTeamResources(TeamFromPlayer[p],"metal")
			if metal then
				table.insert(script.players[p].ExtraDoubleCustomKeys,{name="StartMetal",value=metal})
			end
			local energy=Spring.GetTeamResources(TeamFromPlayer[p],"energy")
			if energy then
				table.insert(script.players[p].ExtraDoubleCustomKeys,{name="StartEnergy",value=energy})
			end
			local bufferSize=Spring.GetTeamRulesParam(TeamFromPlayer[p],"bufferSize")-- Can't use GG.bufferSize[TeamFromPlayer[p]] because this code is run in unsynced gadget
			if type(bufferSize)=="number" and bufferSize~=0 then
				table.insert(script.players[p].ExtraDoubleCustomKeys,{name="StartBuffer",value=bufferSize})
			end
			if type(SYNCED.namedResearched)~="table" then
				--Spring.Echo("SYNCED.namedResearched is a "..type(SYNCED.namedResearched)..". Can't dump tech levels.")
			else
				local teamNamedResearched=SYNCED.namedResearched[TeamFromPlayer[p]]
				if type(teamNamedResearched)~="table" then
					Spring.Echo("SYNCED.namedResearched["..TeamFromPlayer[p]"..] is a "..type(teamNamedResearched)..". Can't dump tech levels.")
				else
					if not sipairs then
						Spring.Echo("sipairs not found. Can't dump tech levels.")
					else
						local researched={}
						for _,r in sipairs(teamNamedResearched) do
							table.insert(researched,r)
						end
						if #researched>=1 then
							table.insert(script.players[p].ExtraDoubleCustomKeys,{name="Researched",value=table.concat(researched,",")})
						end
					end
				end
			end
			table.insert(script.players[p].ExtraDoubleCustomKeys,{name="RemoveUnits",value="1"})
			table.insert(script.players[p].ExtraDoubleCustomKeys,{name="RemoveFeatures",value="1"})
		end
		-- Unspec dead single player
		if script.isSpeccing==1 and isDead and not isAiTeam then
			player_num=p
			script.PlayerTeamNum=player_num-1
			script.isSpeccing=0
		end
		if p==player_num and script.isSpeccing==0 then
			script.players[p].bot=nil -- Player is no bot
		else
			local GotLuaAI=Spring.GetTeamLuaAI(TeamFromPlayer[p])
			script.players[p].bot={
					ShortName=(GotLuaAI and string.len(GotLuaAI)>1) and GotLuaAI or "Kernel Panic AI",
					LongName="It's a Bot!",
					PathAndFileName=""}
			if not GotLuaAI or string.len(GotLuaAI)<2 then
				-- Restore 0.81.2.1 behavior of GetAIInfo
				local function GetOldAIInfo(team)
					local AIInfo={Spring.GetAIInfo(team)}
					if #AIInfo==6 then
						table.insert(AIInfo,1,team)
					end
					return unpack(AIInfo)
				end
				teamID,skirmishAIID,name,hostingPlayerID,shortName,version,options=GetOldAIInfo(TeamFromPlayer[p])
				if shortName and shortName~="UNKNOWN" then
					script.players[p].bot={
						ShortName=shortName,
						LongName=name,
						PathAndFileName=""}
				else
					if not FillModSpecific or not ModSpecific.BotsList or not ModSpecific.BotsList[1] then
						Spring.Echo("Error, cannot find a default bot name!! ModSpecific.BotsList bad!!")
					else
						script.players[p].bot=ModSpecific.BotsList[1]
						script.players[p].aioverride="Dummy"
					end
				end
			end
		end
		if teamCustomOptions["aioverride"] then
			script.players[p].aioverride=teamCustomOptions["aioverride"]
		end
		script.players[p].noons=teamCustomOptions["noons"] and teamCustomOptions["noons"]~="0"
		script.players[p].sos=(teamCustomOptions["som"] and teamCustomOptions["som"]~="0" and tonumber(teamCustomOptions["som"])) or (teamCustomOptions["sos"] and teamCustomOptions["sos"]~="0" and tonumber(teamCustomOptions["sos"]))
		if OnlyStartScript then
			--[[
			for key,value in pairs(teamCustomOptions) do
				if string.len(key)>=2 and (string.sub(key,1,1)=="u" or string.sub(key,1,1)=="f") then
					local ok=true
					for cn=2,string.len(key) do
						local c=string.sub(key,cn,cn)
						if c~="0" and c~="1" and c~="2" and c~="3" and c~="4" and c~="5" and c~="6" and c~="7" and c~="8" and c~="9" then
							ok=false
						end
					end
					if ok then
						table.insert(script.players[p].ExtraDoubleCustomKeys,{name=key,value=value})
					end
				end
			end
			]]--
		else
			-- List team units as team modoptions
			local status,msg_or_lst=pcall(MakeDumpedUnitList,Spring.GetTeamUnits(TeamFromPlayer[p]),UsedIDs,Abbreviated,Grid)
			if status then
				for n,s in ipairs(msg_or_lst) do
					table.insert(script.players[p].ExtraDoubleCustomKeys,{name="u"..n,value=s})
				end
			else
				Spring.Echo("MakeDumpedUnitList failed on Player"..p.." Team"..TeamFromPlayer[p])
				Spring.Echo("The error was: "..msg_or_lst)
				table.insert(script.players[p].ExtraDoubleCustomKeys,{name="UnitDumpError",value="\""..msg_or_lst.."\""})
				WorksSoFar=false
			end
			-- List team features as team modoptions
			local status,msg_or_lst=pcall(MakeDumpedFeatureList,TeamFromPlayer[p],Abbreviated,Grid)
			if status then
				for n,s in ipairs(msg_or_lst) do
					table.insert(script.players[p].ExtraDoubleCustomKeys,{name="f"..n,value=s})
				end
			else
				Spring.Echo("MakeDumpedFeatureList failed on Player"..p.." Team"..TeamFromPlayer[p])
				Spring.Echo("The error was: "..msg_or_lst)
				table.insert(script.players[p].ExtraDoubleCustomKeys,{name="FeatureDumpError",value="\""..msg_or_lst.."\""})
				WorksSoFar=false
			end
		end
	end

	for key,value in pairs(Spring.GetMapOptions()) do
		if script.MapOptions==nil then
			script.MapOptions={}
		end
		script.MapOptions[key]=value
	end

	if WithHeightMap and not OnlyStartScript then
		local status,ret=pcall(MakeDumpedHeightMap)
		if status then
			script.HeightMapV1=ret
		else
			Spring.Echo("Error while dumping heightmap: "..ret)
		end
	end
	
	script.description=Game.modShortName.." state dumped by \""..(widget or gadget):GetInfo().name.."\" "..((widget and "widget") or (gadget and "gadget") or "lua") .." version "..((widget or gadget):GetInfo().version or "?")
	return script,WorksSoFar
end





















