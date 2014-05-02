base, turret, barrel1, firepoint1, dirt = piece('base', 'turret', 'barrel1', 'firepoint1', 'dirt')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()

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
end		

function script.AimFromWeapon(weaponID)
	--Spring.Echo("AimFromWeapon: FireWeapon")
	return turret
end

function script.QueryWeapon(weaponID)
	--Spring.Echo("QueryWeapon: FireWeapon")
	return firepoint1
end

function script.AimWeapon(weaponID, heading, pitch)
	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)
	Turn(turret, y_axis, heading, 20)
	Turn(barrel1, x_axis, pitch, 20)
	WaitForTurn(turret, y_axis)
	WaitForTurn(barrel1, x_axis)
	StartThread(RestoreAfterDelay)
	--Spring.Echo("AimWeapon: FireWeapon")
	return true
end

function script.FireWeapon(weaponID)
	--Spring.Echo("FireWeapon: FireWeapon")
	EmitSfx (firepoint1, 1024)
end


local random = math.random

function SmokeUnit(smokePieces)
	local n = #smokePieces
	while (GetUnitValue(COB.BUILD_PERCENT_LEFT) ~= 0) do
		Sleep(1000)
	end
	while true do
		local health = GetUnitValue(COB.HEALTH)
		if (health <= 66) then -- only smoke if less then 2/3rd health left
			EmitSfx(smokePieces[random(1,n)], 1026)
		end
		Sleep(20*health + 200)
	end
end

function script.Killed()
		Explode(barrel1, SFX.EXPLODE_ON_HIT)
		Explode(turret, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end