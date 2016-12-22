-- UNITDEF -- EALLTERRSHIELD_t2 --
--------------------------------------------------------------------------------

local unitName                   = "eallterrshield_t2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 28
local maxDamage					  = 500 * 1.20

local tech						 = [[tech1]]
local armortype					 = [[light]]
local supply					 = [[5]]

local shield1Power               = 1500 * 1.20
local shield1PowerRegen          = 15 * 1.20
local shield1PowerRegenEnergy    = shield1PowerRegen / 10


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
	cloakCost		             = 0,
	cloakCostMoving	             = 1,
	minCloakDistance             = 150,
	decloakOnFire	             = false,
	decloakSpherical             = true,
	initCloaked		             = true,
	-- Starting out cloaked will dramatically increase the initial cost, however, it is much more convenient from a micromanagement standpoint.
	-- End Cloaking

	description                  = [[Shield/Cloak Field Emitter • Uses +]] .. supply .. [[ Supply]],
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
	maxDamage                    = maxDamage,
	maxVelocity                  = 3.5,
	maxReverseVelocity           = 2,
	turninplacespeedlimit        = 4,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "ALLTERRTANK5",
	moveState			         = "0",
	name                         = "Widow Upgraded",
	noChaseCategory              = "VTOL",
	objectName                   = "eallterrshield.s3o",
	script	                     = "eallterrshield.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "hugeExplosionGenericPurple",
	sightDistance                = 800,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = unitName,
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
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 

Shield recharges at a rate of ]] .. shield1PowerRegen .. [[hp/s
Energy cost for regeneration: ]] .. shield1PowerRegenEnergy .. [[/s
Maximum shield power is ]] .. shield1Power ..[[hp
Shield can link with other shield units to increase charging and capacity
Generates a Cloaking Field]],
		
		area_cloak = 1, -- Can this unit emit a cloaking field?
		area_cloak_upkeep = 5, -- How much energy does it cost to maintain the cloaking field?
		area_cloak_radius = 150, -- How large is the cloaking field?
		--area_cloak_grow_rate = 200, -- When the cloaking field is turned on, how fast does the field expand to it's full size?
		--area_cloak_shrink_rate = 200, -- When the cloaking field is turned off, how fast does the field shrink to nothingness?
		area_cloak_decloak_distance = 150, -- How close does something have to be in order to decloak a unit within a cloaking shield?
		area_cloak_init = true, -- Start up the cloak shield the moment the unit is built?
		area_cloak_draw = true, -- No idea what this does
		area_cloak_self = true, -- Does the cloak shield cloak the unit emitting it?
	},
}


--------------------------------------------------------------------------------

local weaponDefs                 = {
	allterrshield                = {
		
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
		
		texture1		         = "shield4",
		
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
