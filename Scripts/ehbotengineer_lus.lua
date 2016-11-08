base, turret, nanos, nanopoint1, nanopoint2, dirt, backpack, exhaust1, exhaust2 = piece('base', 'turret', 'nanos', 'nanopoint1', 'nanopoint2', 'dirt', 'backpack', 'exhaust1', 'exhaust2')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, turret, barrel1})
	StartThread(doYouEvenLift)
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

function doYouEvenLift()
	common.HbotLift()
end

function thrust()
	common.DirtTrail()
end

function BuildFX()
	while(building == true) do
		EmitSfx (nanopoint1, 1024)
		EmitSfx (nanopoint2, 1024)
		Sleep(550)
	end
end

function RestoreAfterDelay()
	if building == false then
		Sleep(2000)
		Turn(base, y_axis, 0, 5)
	end
end		

local nanoPoints = {}
-- FIXME: this example has 2 nano pieces to alternate between
for i = 1, 2 do 
     -- FIXME: the pieces are named nanoPiece1 and nanoPiece2 in the model
    nanoPoints[i] = piece("nanopoint" .. i)
end
Spring.SetUnitNanoPieces(unitID, nanoPoints)

function script.StartBuilding(heading, pitch)
    -- TODO: This is where you would add your unpack / point towards animation
	Turn(base, y_axis, heading, 100)
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
		Explode(nanos, SFX.EXPLODE_ON_HIT)
		Explode(turret, SFX.EXPLODE_ON_HIT)
		Explode(base, SFX.EXPLODE_ON_HIT)
		Explode(backpack, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end