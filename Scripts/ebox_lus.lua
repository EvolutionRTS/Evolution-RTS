base, forwarddome, reardome, rearleftwing, frontleftwing, frontrightwing, rearrightwing, dirt = piece('base', 'forwarddome', 'reardome', 'rearleftwing', 'frontleftwing', 'frontrightwing', 'rearrightwing', 'dirt')
local SIG_AIM = {}

-- state variables
isMoving = "isMoving"
terrainType = "terrainType"

function script.Create()
	StartThread(common.SmokeUnit, {base, turret, barrel1})
	building = false
	Move(base, y_axis, 5, 200)
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

function script.Killed()
		Explode(forwarddome, SFX.EXPLODE_ON_HIT)
		Explode(reardome, SFX.EXPLODE_ON_HIT)
		Explode(rearleftwing, SFX.EXPLODE_ON_HIT)
		Explode(frontleftwing, SFX.EXPLODE_ON_HIT)
		Explode(frontrightwing, SFX.EXPLODE_ON_HIT)
		Explode(rearrightwing, SFX.EXPLODE_ON_HIT)
		return 1   -- spawn ARMSTUMP_DEAD corpse / This is the equivalent of corpsetype = 1; in bos
end