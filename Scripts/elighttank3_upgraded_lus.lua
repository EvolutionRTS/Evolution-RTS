base, turret, barrel1, firepoint1, dirt, pdturret, pdbarrel1, pdfirepoint1 = piece('base', 'turret', 'barrel1', 'firepoint1', 'dirt', 'pdturret', 'pdbarrel1', 'pdfirepoint1')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, turret, barrel1})
end

common = include("headers/common_includes_lus.lua")

function script.setSFXoccupy(setSFXoccupy_argument)
	common.setSFXoccupy(setSFXoccupy_argument)
end

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
	Turn(pdturret, y_axis, 0, 5)
	Turn(pdbarrel1, x_axis, 0, 5)
end		

-------------------------------------------
-------------------------------------------

function script.AimFromWeapon1()
	--Spring.Echo("AimFromWeapon: FireWeapon")
	return turret
end

function script.QueryWeapon1()
	--Spring.Echo("QueryWeapon: FireWeapon")
	return firepoint1
end

function script.AimWeapon1(heading, pitch)
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

function script.FireWeapon1()
	--Spring.Echo("FireWeapon: FireWeapon")
	EmitSfx (firepoint1, 1024)
end

-------------------------------------------
-------------------------------------------

function script.AimFromWeapon2()
	--Spring.Echo("AimFromWeapon: FireWeapon")
	return pdturret
end

function script.QueryWeapon2()
	--Spring.Echo("QueryWeapon: FireWeapon")
	return pdfirepoint1
end

function script.AimWeapon2(heading, pitch)
	Signal(SIG_AIM_2)
	SetSignalMask(SIG_AIM_2)
	Turn(pdturret, y_axis, heading, 100)
	Turn(pdbarrel1, x_axis, -pitch, 100)
	WaitForTurn(pdturret, y_axis)
	WaitForTurn(pdbarrel1, x_axis)
	--StartThread(RestoreAfterDelay)
	--Spring.Echo("AimWeapon: FireWeapon")
	return true
end

function script.FireWeapon2()
	--Spring.Echo("FireWeapon: FireWeapon")
	common.CustomEmitter(pdfirepoint1, "factorysparks") -- Second argument is the piece name, third argument needs to be a string because it will be the name of the CEG effect used
end

-------------------------------------------
-------------------------------------------

function script.Killed()
		Explode(barrel1, SFX.EXPLODE_ON_HIT)
		Explode(turret, SFX.EXPLODE_ON_HIT)
		Explode(pdbarrel1, SFX.EXPLODE_ON_HIT)
		Explode(pdturret, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end