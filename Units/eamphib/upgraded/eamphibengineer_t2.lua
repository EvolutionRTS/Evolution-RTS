-- UNITDEF -- EAMPHIBENGINEER_t2 --
--------------------------------------------------------------------------------

local unitName                   = "eamphibengineer_t2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 35
local maxDamage					  = 600 * 1.20

local armortype					 = [[light]]
--local supply					 = [[2]]

if Spring.GetModOptions().luamex ~= "enabled" then
	buildList = { [[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],
	}
end
if Spring.GetModOptions().luamex == "enabled" and Spring.GetModOptions().luamex_mapextractors == "disabled" then
	buildList = { 
		[[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[emetalextractor]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],
	}
end
if Spring.GetModOptions().luamex == "enabled" and Spring.GetModOptions().luamex_mapextractors == "enabled" then
	buildList = { 
		[[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[emetalextractor2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],
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
	buildDistance                = 800,
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
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "LIGHT AMPHIB SUPPORT",
	description                  = [[Builds Units]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "engineer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = maxDamage,
	maxSlope                     = 28,
	maxVelocity                  = 4,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "TANK4",
	moveState			         = "2",
	name                         = "The Developer Upgraded",
	objectName                   = "eamphibengineer2.s3o",
	script	                     = "eamphibengineer2.cob",
	radarDistance                = 0,
	radarDistanceJam             = 20,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = true,
	side                         = "ARM",
	sightDistance                = 500,
--	SonarDistance                = 500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 4,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 1020,
	unitname                     = unitName,
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
		helptext				 = [[Armortype: ]] .. armortype,
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
