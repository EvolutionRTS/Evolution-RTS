--------------------------------------------------------------------------------
-- These represent both the area of effect and the camerashake amount
local smallExplosion = 200
local smallExplosionImpulseFactor = 0
local mediumExplosion = 400
local mediumExplosionImpulseFactor = 0
local largeExplosion = 600
local largeExplosionImpulseFactor = 0
local hugeExplosion = 1000
local hugeExplosionImpulseFactor = 0


unitDeaths = {

	mediumScavengerExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericscavengerbuildingexplosion-medium-purple",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
}

return lowerkeys(unitDeaths)