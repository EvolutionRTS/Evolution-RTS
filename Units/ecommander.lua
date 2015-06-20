-- UNITDEF -- ECOMMANDER --
--------------------------------------------------------------------------------

local unitName                   = "ecommander"

--------------------------------------------------------------------------------

local armortype					 = [[light]]
local supplyGiven				 = [[35]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false; 

	--**

	acceleration                 = 0.2,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 500,
	buildDistance                = 1000,
	builder                      = true,
	buildTime                    = 2.5,
	capturable		             = false,
	CanAttack			         = true,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = true,
	CanRepair			         = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "NOTAIR SUPPORT LIGHT",
	description                  = [[Unit Type: Command Unit
Armortype: ]] ..armortype.. [[ 

1000 EMP Damage vs Light/Armored/Building

Gives ]] ..supplyGiven.. [[ Supply

There can only be one!]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "emp",
	fireState			         = "1",
	footprintX                   = 4,
	footprintZ                   = 4,
	hideDamage		             = true,
	iconType                     = "commander",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = 5000,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "COMMANDERTANK4",
	moveState			         = "0",
	name                         = "The Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	objectName                   = "ecommander4.s3o",
	script			             = "ecommander3.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "emp",
	showPlayerName	             = true,
	showNanoSpray                = false,
	sightDistance                = 500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	unitRestricted	             = 1,
	upright                      = false,
	workerTime                   = 1,
	capturespeed                 = 0.25,
	TerraformSpeed               = 100000,
	ReclaimSpeed                 = 0,
	-- 0.03125                   = 1 hp per second
	repairspeed                  = 0.15625,
	sfxtypes                     = {
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 
		
		explosiongenerators      = {
			"custom:nanoorb",
			"custom:dirt",
			"custom:blacksmoke",
		},
	},
	buildoptions                 = {
		"eminifac", --new
		"ebasefactory", --new
		"eamphibfac",
		"eairplant",
		"eexperimentalfac",
		"emetalextractor", --new
		"emaker", --new
		"esolar2", --new
		"emediumgen", --new
		"egeothermal", --new
		"efusion2", --new
		"estorage", --new
		"eradar2", --new
		"ejammer2", --new
		"ekmar",
		"elightturret2", --new
		"eheavyturret2", --new
		"eartyturret",
		"euwturret",
		"ecruisesilo",
		"eshieldgen",
		"esilo",
		"emine",
		"eorb",
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
			def                  = "emp",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		iscommander              = true,
		needed_cover             = 2,
		supply_granted            = supplyGiven,
		death_sounds             = "generic",
		cancollect               = "1",
		armortype                = armortype,
		nofriendlyfire	         = "1",
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",
		helptext                 = [[]],
	},
}

--------------------------------------------------------------------------------

local weaponDefs                 = {
	emp                          = {
		AreaOfEffect             = 500,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		explosionGenerator       = "custom:genericshellexplosion-large-blue-emp",
		tolerance                = 1000,
		energypershot            = 0,
		explosionScar		     = false,
		impulseFactor            = 0,
		name                     = "Emp Blast Weapon",
		paralyzer		         = true,
		paralyzetime	         = 5,
		range                    = 500,
		reloadtime               = 10,
		weaponType		         = "Cannon",
		soundhit                 = "emp.wav",
		size				     = 0,
		turret                   = true,
		weaponVelocity           = 10000,
		customparams             = {
			damagetype		     = "default",
			nofriendlyfire	     = 1,
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		},      
		damage                   = {
			default              = 1000,
		},
	},
}
unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
