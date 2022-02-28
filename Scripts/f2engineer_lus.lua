base, spinner, nano1, dirt = piece('base', 'spinner', 'nano1', 'dirt')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, spinner})
	StartThread(BuildFX)
	building = false
end

common = include("headers/common_includes_lus.lua")

function script.StartMoving()
   isMoving = true
   	StartThread(thrust)
end

function script.StopMoving()
   isMoving = false
end   

function thrust()
	common.DirtTrail()
end

function BuildFX()
	while(building == true) do
		EmitSfx (nano1, 1024)
		Sleep(550)
	end
end

function RestoreAfterDelay()
	if building == false then
		Sleep(2000)
		Turn(base, y_axis, 0, 5)
	end
end		

local nanoPoints = {nano1}

Spring.SetUnitNanoPieces(unitID, nanoPoints)

function script.StartBuilding(heading, pitch)
    -- TODO: This is where you would add your unpack / point towards animation
    SetUnitValue(COB.INBUILDSTANCE, true)
	building = true
	StartThread(BuildFX)
end

function script.StopBuilding()
    -- TODO: This is where you would add your pack-up animation
    SetUnitValue(COB.INBUILDSTANCE, false)
	building = false
	StartThread(RestoreAfterDelay)
end

function script.Killed()
		Explode(spinner, SFX.EXPLODE_ON_HIT)
		Explode(base, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end