-- UNITDEF -- EALLTERRMED --
--------------------------------------------------------------------------------

local unitName                   = "eallterrmed"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 44
local maxDamage					  = 500

local tech						 = [[tech2]]
local armortype					 = [[armored]]
local supply					 = [[4]]

local weapon1Damage              = 200
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "ARMORED NOTAIR SKIRMISHER",
	corpse                       = "ammobox",

	-- Cloaking

	cancloak		             = true,
	cloakCost		             = 0,
	cloakCostMoving	             = 1,
	minCloakDistance             = 70,
	decloakOnFire	             = true,
	decloakSpherical             = true,
	initCloaked		             = false,
	
	-- End Cloaking

	description                  = [[Unit Type: Light Tank Destroyer • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericPurple",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 180,
	maxVelocity                  = 3.5,
	maxReverseVelocity           = 1,
	turninplacespeedlimit        = 4,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	mobilestandorders            = "1",
	movementClass                = "ALLTERRTANK4",
	name                         = "Basher",
	noChaseCategory              = "VTOL",
	objectName                   = "eallterrmed2.s3o",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericPurple",
	sightDistance                = 600,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "eallterrmed",
	upright			             = false,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:gdhcannon",
			"custom:dirtsmall",
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
			def                  = "mediumtankcannon",
			onlyTargetCategory   = "BIO LIGHT ARMORED BUILDING",
			badTargetCategory    = "BUILDING LIGHT WALL",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 2,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	mediumtankcannon             = {
		
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 0.1,
		
		coreThickness            = 0.5,
		--	cegTag               = "mediumcannonweapon3",
		duration                 = 0.1,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion",
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		
		minintensity             = "1",
		name                     = "Laser",
		range                    = 600,
		reloadtime               = 1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "medallterrweapon.wav",
		soundHit                 = "mediumcannonhit.wav",
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 9,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "eallterrmed",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
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
