-- UNITDEF -- EGUNSHIP2 --
--------------------------------------------------------------------------------

local unitName                   = "egunship2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 50
local maxDamage					  = 375

local tech						 = [[tech2]]
local armortype					 = [[light]]
local supply					 = [[4]]

local weapon1Damage              = 150
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = false,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	buildTime                    = 2.5,
	canAttack                    = true,
	canDropFlare                 = false,
	canFly                       = true,
	canGuard                     = true,
	canLoopbackAttack            = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = true,
	category                     = "LIGHT VTOL",
	collide                      = true,
	corpse                       = "ammobox",
	cruiseAlt                    = 120,
	description                  = [[Unit Type: Gunship Tank Destroyer • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGenericRed",
	flareDelay                   = 0.1,
	flareDropVector              = "0 0 -1",
	flareefficieny               = "0.3",
	flareReload                  = 3,
	floater                      = true,
	footprintX                   = 4,
	footprintZ                   = 4,
	hoverAttack                  = true,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxDamage                    = maxDamage,
	maxSlope                     = 90,
	maxVelocity                  = 9,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	moverate1                    = "8",
	name                         = "Wildcat",
	objectName                   = "egunship3.s3o",
	script			             = "egunship3.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGenericRed",
	side                         = "CORE",
	sightDistance                = 800,
	smoothAnim                   = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:jethtrail",
			"custom:blacksmoke",
		},
	},
	sounds                       = {
		underattack              = "unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	weapons                      = {
		[1]                      = {
			def                  = "gunshipweapon",
			mainDir              = "0 0 1",
			maxAngleDif          = 180,
			BadTargetCategory    = "LIGHT BUILDING WALL",
			noChaseCategory      = "VTOL",
		},
	},
	customParams                 = {
		--    needed_cover       = 2,
		canareaattack            ="1",
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 

150 Damage vs Light/Armored
75 Damage vs Building

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {

	gunshipweapon             = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "missiletrailgunshiplesssmokey",
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = energycosttofire,
		edgeEffectiveness        = 0.1,
		fireStarter              = 70,
		tracks                   = true,
		impulseBoost             = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		model                    = "missilesmalllauncher.s3o",
		name                     = "Rockets",
		range                    = 420,
		reloadtime               = 1,
		weaponType		         = "MissileLauncher",
		waterweapon				 = true,
		smokeTrail               = false,
		soundHit                 = "bombhit.wav",
		soundHitWet				 = "subhit.wav",
		soundHitVolume	         = 10,
		soundStart               = "18395_inferno_rltx.wav",
		soundStartVolume         = 10,
		startVelocity            = 500,
		tolerance                = 8000,
		turnRate                 = 20000,
		turret                   = true,
		weaponAcceleration       = 500,
		flightTime               = 5,
		weaponVelocity           = 2000,
		customparams             = {
			damagetype		     = "egunship2",  
		},      
		damage                   = {
			default              = weapon1Damage,
		},
	},
}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
