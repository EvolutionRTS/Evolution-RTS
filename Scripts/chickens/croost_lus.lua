base, emit, arm, launcher = piece('base', 'emit', 'arm', 'launcher')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base})
	StartThread(BuildFX)
	building = false
	Move(base, y_axis, -1, 50)
end

common = include("headers/common_includes_lus.lua")

function BuildFX()
	while(building == true) do
		EmitSfx (emit, 1024)
		Sleep(550)
	end
end

function RestoreAfterDelay()
	if building == false then
		Sleep(2000)
		Turn(emit, y_axis, 0, 5)
	end
end		

local nanoPoints = piece("emit")

Spring.SetUnitNanoPieces(nanoPoints)

function script.StartBuilding(heading, pitch)
    -- TODO: This is where you would add your unpack / point towards animation
	Turn(emit, y_axis, heading, 100)
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
		Explode(base, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end