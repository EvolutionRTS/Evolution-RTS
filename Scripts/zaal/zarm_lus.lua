base, point1 = piece('base', 'point1')
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
		--EmitSfx (point1, 1024)
		Sleep(550)
	end
end

function RestoreAfterDelay()
	if building == false then
		Sleep(2000)
		Turn(point1, y_axis, 0, 5)
	end
end

-------------------------------------------
-------------------------------------------

function script.AimFromWeapon1()
	--Spring.Echo("AimFromWeapon: FireWeapon")
	return point1
end

function script.QueryWeapon1()
	--Spring.Echo("QueryWeapon: FireWeapon")
	return point1
end


function script.AimWeapon1(heading, pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	--Spring.Echo("AimWeapon: FireWeapon")
	return true
end

function script.FireWeapon1()
	--Spring.Echo("FireWeapon: FireWeapon")
	--EmitSfx (point1, 1024)
end
		
-------------------------------------------
-------------------------------------------
		
local nanoPoints = piece("point1")

Spring.SetUnitNanoPieces(nanoPoints)

function script.StartBuilding(heading, pitch)
    -- TODO: This is where you would add your unpack / point towards animation
	Turn(point1, y_axis, heading, 100)
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
		--Explode(base, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end