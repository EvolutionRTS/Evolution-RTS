-- UNITDEF -- EAMPHIBARTY --
--------------------------------------------------------------------------------

local unitName                = "eamphibarty"

--------------------------------------------------------------------------------

local power						 = [[5 power]]
local armortype					 = [[light]]
local supply					 = [[5]]

local weapon1Damage              = 300
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                 = {

	--mobileunit 
	transportbyenemy          = false;

	--**


	acceleration              = 1,
	brakeRate                 = 0.2,
	buildCostEnergy           = 0,
	buildCostMetal            = 36,
	builder                   = false,
	buildTime                 = 5,
	canAttack                 = true,
	cancollect                = "1",
	canGuard                  = true,
	canMove                   = true,
	canPatrol                 = true,
	canstop                   = "1",
	category                  = "LIGHT AMPHIB SUPPORT",
	corpse                    = "ammobox",
	description               = [["Unit Type: Laser Support Artillery
Armortype: ]] ..armortype.. [[ 

300 Damage vs Buildings
75 Damage vs Light/Armored

Can fire while underwater

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
energyMake                    = 0,
energyStorage                 = 0,
energyUse                     = 0,
explodeAs                     = "largeExplosionGenericBlue",
footprintX                    = 4,
footprintZ                    = 4,
iconType                      = "assault",
idleAutoHeal                  = .5,
idleTime                      = 2200,
leaveTracks                   = false,
maxDamage                     = 300,
maxSlope                      = 28,
maxVelocity                   = 3,
maxReverseVelocity            = 1,
minWaterDepth                 = 10,
metalStorage                  = 0,
movementClass                 = "TANK4",
name                          = "Assimilator",
objectName                    = "eamphibarty2.s3o",
script			              = "eamphibarty2.cob",
radarDistance                 = 0,
repairable		              = false,
selfDestructAs                = "largeExplosionGenericBlue",
sightDistance                 = 1175,
SonarDistance                 = 1175,
stealth			              = true,
seismicSignature              = 2,
sonarStealth		          = false,
smoothAnim                    = true,
--  turnInPlace               = false,
--  turnInPlaceSpeedLimit     = 3.0,
turnInPlace                   = true,
turnRate                      = 5000,
--  turnrate                  = 300,
unitname                      = "eamphibarty",
workerTime                    = 0,
	sfxtypes                  = { 
	pieceExplosionGenerators  = { 
		"deathceg3", 
		"deathceg4", 
	}, 

	explosiongenerators       = {
	"custom:factorysparks",
	"custom:dirt",
	"custom:blacksmoke",
	},
},
sounds                        = {
	underattack               = "unitsunderattack1",
	ok                        = {
	"ack",
	},
	select                    = {
	"unitselect",
	},
},
weapons                       = {
	[1]                       = {
	def                       = "assimilatorbeamweapon",
	onlyTargetCategory        = "BUILDING",
	},
--[[
	[2]                       = {
	def                       = "TORP",
	},
]]--
},
customParams                  = {
	needed_cover              = 3,
	death_sounds              = "generic",
	RequireTech               = power,
	armortype                 = armortype,
	nofriendlyfire	          = "1",
	supply_cost               = supply,
	normalstex                = "unittextures/lego2skin_explorernormal.dds", 
	buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
	factionname	              = "outer_colonies",  
},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs              = {  
assimilatorbeamweapon         = {
	badTargetCategory         = [[ARMORED LIGHT]],
	AreaOfEffect              = weapon1AOE,
	avoidFeature              = false,
	avoidFriendly             = false,
	beamTime                  = 1.8,
	collideFeature            = false,
	collideFriendly           = false,
	rgbColor                  = "0 0 0.5",
	rgbColor2                 = "0.5 0.5 0.5",
	coreThickness             = 0.5,
	duration                  = 0.4,
	explosionGenerator        = "custom:genericshellexplosion-large-sparks-burn",
	energypershot             = energycosttofire,
	fallOffRate               = 0.1,
	fireStarter               = 50,
	interceptedByShieldType   = 4,
	largeBeamLaser            = true,
	laserflaresize 	          = 5,
	lineOfSight               = true,
	leadlimit			      = 20,
	minintensity              = 1,
	name                      = "Laser",
	range                     = 1175,
	reloadtime                = 9,
	WeaponType                = "BeamLaser",
	soundHit                  = "amphibartyshothit.wav",
	soundStart                = "laserbeam02.wav",
	soundTrigger              = true,
	texture1                  = "lightning",
	texture2                  = "laserend",
	thickness                 = 20,
	tolerance                 = 500,
	turret                    = true,
	weaponVelocity            = 1500,
	waterweapon		          = true,
	customparams              = {
	damagetype		          = "eamphibarty",  
	
	--Upgrades--
	upgradeClass		      = "groundweapons",
	}, 
	damage                    = {
	default                   = weapon1Damage,
	},
},
}
unitDef.weaponDefs            = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
