base = piece('base')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, turret, barrel1})
	StartThread(BuildFX)
	building = false
end

common = include("headers/common_includes_lus.lua")	

local nanoPoints = {}

nanoPoints[i] = piece("base")

Spring.SetUnitNanoPieces(unitID, nanoPoints)

function script.StartBuilding(heading, pitch)
    -- TODO: This is where you would add your unpack / point towards animation
    SetUnitValue(COB.INBUILDSTANCE, true)
	building = true
end
function script.StopBuilding()
    -- TODO: This is where you would add your pack-up animation
    SetUnitValue(COB.INBUILDSTANCE, false)
	building = false
end

function script.Killed()
		Explode(base, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end