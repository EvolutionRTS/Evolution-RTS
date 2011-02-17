function gadget:GetInfo()
	return {
		name = "Feature spread command",
		desc = "Feature spread command",
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
local CMD_SET_fSpreadCMD	= 458234
	
local featureplacers = { [UnitDefNames.goldtree.id] = true,}

local fSpreadCMD= {
	id      = CMD_SET_fSpreadCMD,
	name	= "fspread",
	tooltip	= "Feature spread",
	type	= CMDTYPE.ICON_MODE,
	params	= { '0', 'No cluster', 'Small cluster', 'Large cluster'}
}

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if featureplacers[unitDefID] then
		InsertUnitCmdDesc(unitID, 500, fSpreadCMD)
	end
end
	
function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
	if featureplacers[unitDefID] then
		if (cmdID == CMD_SET_fSpreadCMD) then 
		
		local cmdDescID = FindUnitCmdDesc(unitID, CMD_SET_fSpreadCMD)
		Spring.Echo("cmdparams[1]=" .. tostring(cmdParams[1]))

		fSpreadCMD.params[1] = cmdParams[1]
		EditUnitCmdDesc(unitID, cmdDescID, fSpreadCMD)
		fSpreadCMD.params[1] = 1
		end
	end
return true
end


