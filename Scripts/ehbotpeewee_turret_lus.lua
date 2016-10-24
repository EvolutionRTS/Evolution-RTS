base, turret, barrel1, firepoint1, firepoint2, dirt = piece('base', 'turret', 'barrel1', 'firepoint1', 'firepoint2', 'dirt')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, turret, barrel1})
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

local function RestoreAfterDelay()
	Sleep(2000)
	Turn(turret, y_axis, 0, 5)
	Turn(barrel1, x_axis, 0, 5)
end		

function script.AimFromWeapon(weaponID)
	--Spring.Echo("AimFromWeapon: FireWeapon")
	return turret
end

local firepoints = {firepoint1, firepoint2}
local currentFirepoint = 1

function script.QueryWeapon(weaponID)
	return firepoints[currentFirepoint]
end

function script.FireWeapon(weaponID)
	currentFirepoint = 3 - currentFirepoint
	EmitSfx (firepoints[currentFirepoint], 1024)
end

function script.AimWeapon(weaponID, heading, pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	Turn(turret, y_axis, heading, 100)
	Turn(barrel1, x_axis, -pitch, 100)
	WaitForTurn(turret, y_axis)
	WaitForTurn(barrel1, x_axis)
	StartThread(RestoreAfterDelay)
	--Spring.Echo("AimWeapon: FireWeapon")
	return true
end

function script.Killed()
		Explode(barrel1, SFX.EXPLODE_ON_HIT)
		Explode(turret, SFX.EXPLODE_ON_HIT)
		Explode(base, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end