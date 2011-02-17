function gadget:GetInfo()
	return {
		name = "Feature rotate random toggle",
		desc = "Feature rotate random toggle",
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
local GetUnitCmdDesc		= Spring.GetUnitCmdDescs

local GetFeatureTeam		= Spring.GetFeatureTeam
local InsertUnitCmdDesc		= Spring.InsertUnitCmdDesc
local CMD_SET_fRotRandCMD	= 458236
	
local featureplacers = { [UnitDefNames.goldtree.id] = true,}
local featureplacer
local spawnerList = {}

local fRotRandCMD= {
	id      = CMD_SET_fRotRandCMD,
	name	= "frotrand",
	tooltip	= "Feature spread",
	type	= CMDTYPE.ICON_MODE,
	params	= { '0', 'No rotate', 'Rotate random'}
}

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if featureplacers[unitDefID] then
		InsertUnitCmdDesc(unitID, 500, fRotRandCMD)
	end
	
	if ( unitDefID and UnitDefNames.goldtree.id == unitDefID ) then
		 featureplacer = unitID
	end

end
	
function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
	if featureplacers[unitDefID] then
		if (cmdID == CMD_SET_fRotRandCMD) then 
		
		local cmdDescID = FindUnitCmdDesc(unitID, CMD_SET_fRotRandCMD)
		Spring.Echo("cmdparams[1]=" .. tostring(cmdParams[1]))

		fRotRandCMD.params[1] = cmdParams[1]
		EditUnitCmdDesc(unitID, cmdDescID, fRotRandCMD)
		fRotRandCMD.params[1] = 1
		end
	end
return true
end

function gadget:FeatureCreated(featureID, allyTeam)
	if ( featureplacer ) then
	local CMDID = FindUnitCmdDesc(featureplacer,CMD_SET_fRotRandCMD)
	
		if ( tonumber(GetUnitCmdDesc(featureplacer, CMDID)[1].params[1]) >0)then
			if (featureID) then
				local FID	= Spring.GetFeatureDefID(featureID)
				local x,y,z	= Spring.GetFeaturePosition(featureID )
				Spring.Echo(FeatureDefs[FID].customParams, FeatureDefs[FID].customParams.randomrotate, FeatureDefs[FID].customparams, "hjkhjk")
				if ( FeatureDefs[FID].customParams.randomrotate ) then
					Spring.SetFeatureDirection(featureID, math.random(-1,1), 1, math.random(-1,1))
				end
			end
		end
	end
end