-- UNITDEF -- EALLTERRSHIELD --
--------------------------------------------------------------------------------

local unitName                   = "eallterrshield"

--------------------------------------------------------------------------------

local power						 = [[10 power]]
local armortype					 = [[light]]
local supply					 = [[5]]

local shield1Power               = 1500
local shield1PowerRegen          = 15
local shield1PowerRegenEnergy    = shield1PowerRegen / 10


local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 28,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = false,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT NOTAIR RAID",
	corpse                       = "ammobox",

	-- Cloaking

	cancloak		             = true,
	cloakCost		             = 1,
	cloakCostMoving	             = 2,
	minCloakDistance             = 150,
	decloakOnFire	             = false,
	decloakSpherical             = true,
	initCloaked		             = true,
	-- Starting out cloaked will dramatically increase the initial cost, however, it is much more convenient from a micromanagement standpoint.
	-- End Cloaking

	description                  = [[Unit Type: Shield Emitter
Armortype: ]] ..armortype.. [[ 

Shield recharges at a rate of ]] .. shield1PowerRegen .. [[hp/s
Energy cost for regeneration: ]] .. shield1PowerRegenEnergy .. [[/s
Maximum shield power is ]] .. shield1Power ..[[hp
Shield can link with other shield units to increase charging and capacity
Generates a Cloaking Field

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "hugeExplosionGenericPurple",
	fireState			         = "0",
	footprintX                   = 5,
	footprintZ                   = 5,
	iconType                     = "support",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 500,
	maxVelocity                  = 3.5,
	maxReverseVelocity           = 2,
	turninplacespeedlimit        = 4,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "ALLTERRTANK5",
	moveState			         = "0",
	name                         = "Widow",
	noChaseCategory              = "VTOL",
	objectName                   = "eallterrshield.s3o",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "hugeExplosionGenericPurple",
	sightDistance                = 800,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "eallterrshield",
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
			def                  = "allterrshield",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = power,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------

local weaponDefs                 = {
	allterrshield                = {
		IsShield                 = true,
		Smartshield              = true,
		Exteriorshield           = true,
		Visibleshield            = true,
		Visibleshieldrepulse     = true,
		ShieldStartingPower      = 0,
		Shieldenergyuse          = 0,
		Shieldradius             = 300,
		Shieldpower              = shield1Power,
		Shieldpowerregen         = shield1PowerRegen,
		Shieldpowerregenenergy   = shield1PowerRegenEnergy,
		Shieldintercepttype      = 4,
		Shieldgoodcolor          = "0.0 0.2 1.0",
		Shieldbadcolor           = "1.0 0 0",
		Shieldalpha              = 0.3,
		ShieldRepulsor           = false,
		texture1		         = "shield4",
		visibleShieldHit         = true,
		visibleShieldHitFrames   = 50,
		weaponType               = [[Shield]],
		damage                   = {
			default              = 1,
		},
	},
}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
