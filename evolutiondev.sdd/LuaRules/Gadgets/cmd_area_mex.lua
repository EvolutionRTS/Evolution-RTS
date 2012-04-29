

function gadget:GetInfo()
  return {
    name      = "Area Mex (gadget)",
    desc      = "Adds a command to cap mexes in an area.",
    author    = "Google Frog",
    date      = "June 22, 2010",
    license   = "GNU GPL, v2 or later",
	handler   = true,
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

local spInsertUnitCmdDesc 	= Spring.InsertUnitCmdDesc
local spGiveOrderToUnit		= Spring.GiveOrderToUnit
local spGetUnitPosition		= Spring.GetUnitPosition

local sqrt = math.sqrt
local tasort = table.sort
local taremove = table.remove

local CMD_AREA_MEX = 35792

include "LuaRules/Gadgets/mex_spot_finder.lua"

local mexCmdDesc = {
  id      = CMD_AREA_MEX,
  type    = CMDTYPE.ICON_AREA,
  name    = 'Mex',
  cursor  = 'areamex_cursor', 
  action  = 'areamex',
  tooltip = 'Builds Metal Extractors in the area',
  texture = 'bitmaps/ui/buttons/cmd_area_mex.png',
}

Spring.AssignMouseCursor("areamex_cursor", "areamex_def", true)

local mexBuildCommandID = -UnitDefNames["emetalextractor"].id

local mexSpot = {}

local recentTeamOrder = {}

local function disSQ(x1,z1,x2,z2)
	local dis = (x1-x2)*(x1-x2)+(z1-z2)*(z1-z2)
	return dis
end

function gadget:AllowCommand(unitID, unitDefID, teamID,cmdID, cmdParams, cmdOptions)

  if (cmdID == CMD_AREA_MEX) then
		
		-- give previous order to con as speedup
		if recentTeamOrder[teamID] then
			local data = recentTeamOrder[teamID]
			local recentParams = data.params
			if recentParams[1] == cmdParams[1] and recentParams[2] == cmdParams[2] and recentParams[3] == cmdParams[3] and recentParams[4] == cmdParams[4] then
				if not cmdOptions.shift then 
					spGiveOrderToUnit(unitID, CMD.STOP, {} , CMD.OPT_RIGHT )
				end
				for i = 1, data.mex.count do
					spGiveOrderToUnit(unitID, mexBuildCommandID, {data.mex[i].x,0,data.mex[i].z} , {"shift"})
				end
				return false
			end
		end
		local cx, cy, cz, cr = cmdParams[1], cmdParams[2], cmdParams[3], cmdParams[4]
		
		local xmin = cx-cr
		local xmax = cx+cr
		local zmin = cz-cr
		local zmax = cz+cr
		
		local commands = {count = 0}
		local orderedCommands = {count = 0}
		
		local ux,_,uz = spGetUnitPosition(unitID)
	
		for i = 1, mexSpot.count do		
			if (disSQ(cx,cz,mexSpot[i].x,mexSpot[i].z) < cr^2) then -- circle area, slower
				commands[commands.count+1] = {x = mexSpot[i].x, z = mexSpot[i].z, d = disSQ(ux,uz,mexSpot[i].x,mexSpot[i].z)}
				commands.count = commands.count+1
			end
		end
	
		while commands.count > 0 do
			tasort(commands, function(a,b) return a.d < b.d end)
			orderedCommands[orderedCommands.count+1] = commands[1]
			orderedCommands.count = orderedCommands.count+1
			comx = commands[1].x
			comz = commands[1].z
			taremove(commands, 1)
			commands.count = commands.count-1
			for i = 1, commands.count do		
				commands[i].d = disSQ(comx,comz,commands[i].x,commands[i].z)
			end
		end
		
		recentTeamOrder[teamID] = {
			params = {cmdParams[1],cmdParams[2],cmdParams[3],cmdParams[4]},
			mex = {count = 0},
		}
		
		if not cmdOptions.shift then 
			spGiveOrderToUnit(unitID, CMD.STOP, {} , CMD.OPT_RIGHT )
		end
		for i = 1, orderedCommands.count do
			spGiveOrderToUnit(unitID, mexBuildCommandID, {orderedCommands[i].x,0,orderedCommands[i].z} , {"shift"})
			recentTeamOrder[teamID].mex[recentTeamOrder[teamID].mex.count+1] = {x = orderedCommands[i].x, z = orderedCommands[i].z}
			recentTeamOrder[teamID].mex.count = recentTeamOrder[teamID].mex.count+1
		end

		return false
	end
	return true -- allowed
end

function gadget:UnitCreated(unitID, unitDefID)
	local ud = UnitDefs[unitDefID]
	if ud.isBuilder and not ud.isFactory then
		spInsertUnitCmdDesc(unitID, mexCmdDesc)
	end
end

function gadget:Initialize()
	Spring.SendCommands({
		"unbindkeyset o",
	})
    Spring.SendCommands("bind o areamex")
	mexSpot = GetMetalMap()
	if not mexSpot then
		Spring.Echo("Mex spot detection failed")
		gadgetHandler:RemoveGadget()
		return 
	end
end

