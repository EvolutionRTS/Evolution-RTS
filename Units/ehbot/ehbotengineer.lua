-- UNITDEF -- EHBOTENGINEER --
--------------------------------------------------------------------------------

local unitName                   = "ehbotengineer"

--------------------------------------------------------------------------------

local buildCostMetal			 = 40
local maxDamage					 = 400
local buildDistance				 = 800

local armortype					 = [[light]]
--local supply					 = [[2]]

if Spring.GetModOptions().luamex ~= "enabled" then
	buildList = { [[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],
	}
end
if Spring.GetModOptions().luamex == "enabled" then
	buildList = { 
		[[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],[[emetalextractor]],
	}
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.24,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	buildDistance                = buildDistance,
	builder                      = true,
	buildTime                    = 5,
	CanAttack			         = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	canRestore					 = false,
	cancollect                   = "1",
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "LIGHT NOTAIR SUPPORT",
	description                  = [[Builds Units]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	footprintX                   = 6,
	footprintZ                   = 6,
	iconType                     = "engineer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = maxDamage,
	maxSlope                     = 26,
	maxVelocity                  = 4.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "HOVERHBOT6",
	moveState			         = "2",
	name                         = "The Lifter",
	objectName                   = "ehbotengineer2.s3o",
	script			             = "ehbotengineer_lus.lua",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = false,
	side                         = "ARM",
	sightDistance                = 500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 1020,
	unitname                     = unitName,
	upright                      = true,
	workerTime                   = 1,
	capturespeed                 = 1,
	TerraformSpeed               = 100000,
	ReclaimSpeed                 = 0,
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
	buildoptions                 = buildList,
	sounds                       = {
		underattack              = "unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	customParams                 = {
		area_mex_def			 = "emetalextractor",
		canbetransported 		 = "true",
		needed_cover             = 1,
		death_sounds             = "generic",
		dronespawner             = "1",
		armortype                = armortype,
--		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext                 = [[Armortype: ]] .. armortype .. [[ 

Moving an Engineer in proximity to a Energy Core will spawn a small gunship drone from that core.]],
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
