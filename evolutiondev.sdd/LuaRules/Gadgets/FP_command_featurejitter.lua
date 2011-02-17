function gadget:GetInfo()
	return {
		name = "Feature jitter command",
		desc = "Feature jitter command",
		author = "smoth",
		date = "2009-06-30",
		license = "Public Domain",
		layer = 20, --must be greater than 10 (specialability.lua's layer)
		enabled = true
	}
end

if (not gadgetHandler:IsSyncedCode()) then
	return
end

local EditUnitCmdDesc		= Spring.EditUnitCmdDesc
local FindUnitCmdDesc		= Spring.FindUnitCmdDesc
local GetFeatureTeam		= Spring.GetFeatureTeam
local InsertUnitCmdDesc		= Spring.InsertUnitCmdDesc
local CMD_SET_fJitterCMD	= 458235
	
local featureplacers = { [UnitDefNames.goldtree.id] = true,}

local fJitterCMD = {
	id      = CMD_SET_fJitterCMD,
	name	= "fjitter",
	tooltip	= "Feature spread jitter",
	type	= CMDTYPE.ICON_MODE,
	params	= { '0', '__0%', '_20%', '_40%', '_60%', '_80%', '100%',}
}

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if featureplacers[unitDefID] then
		InsertUnitCmdDesc(unitID, 500, fJitterCMD )
	end
end
	
function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
	if featureplacers[unitDefID] then
		if (cmdID == CMD_SET_fJitterCMD) then 
		
		local cmdDescID = FindUnitCmdDesc(unitID, CMD_SET_fJitterCMD)
		Spring.Echo("cmdparams[1]=" .. tostring(cmdParams[1]))

		fJitterCMD .params[1] = cmdParams[1]
		EditUnitCmdDesc(unitID, cmdDescID, fJitterCMD )
		fJitterCMD .params[1] = 1
		end
	end
return true
end


