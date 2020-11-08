Spring.Echo("[Scavengers] Config initialized")

adder = 300
multiplier = 0.5
-- Config for Scavengers Survival AI

scavconfig = {
	difficulty = {
		easy = 1,
		medium = 2,
		hard = 3,
		brutal = 5,
	},
	unitnamesuffix = "_scav",
	messenger = true, -- BYAR specific thing, don't enable otherwise (or get gui_messages.lua from BYAR)
	modules = {
		buildingSpawnerModule 			= true, --building spawner spawns random blueprints around map
		constructorControllerModule 	= true, --constructor controller is for units that build blueprints
		factoryControllerModule 		= true, --factory controller is to give orders to factories
		unitSpawnerModule 				= true, --spawns units
		startBoxProtection				= true, --spawns turrets around the startboxes (if you are using startboxes) and damages units inside of it
		reinforcementsModule			= true, --reinforcements adds beacon capturing and friendly drops
		stockpilers						= false, --stockpilers adds controller for units with stockpile mechanic
		nukes							= true, --nukes gives orders to nuke units
	},
	
	scoreConfig = {
		-- set to 0 to disable
		scorePerMetal 					= 1, 	-- thisvalue*metalproduction
		scorePerEnergy 					= 1,	-- thisvalue*energyproduction
		scorePerSecond 					= 1,	-- thisvalue*secondspassed
		scorePerOwnedUnit				= 1,	-- thisvalue*countofunits
		-----------------------------------------
		baseScorePerKill 				= 1, -- How much score EVERY KILL and CAPTURE adds
			-- Additional score for specific unit types, use -baseScorePerKill(default 1) to make it have no effect on score, use values lower than baseScorePerKill to reduce score
			scorePerKilledBuilding 			= 4,
			scorePerKilledConstructor 		= 99,
			scorePerKilledSpawner 			= 49,
			scorePerCapturedSpawner 		= -51, -- this doesn't care about baseScorePerKill 
	},
	
	timers = {
		-- globalScore values
		T0start								= 1,
		T1start								= 150+adder*multiplier,
		T1low								= 300+adder*multiplier,
		T1med								= 450+adder*multiplier,
		T1high								= 600+adder*multiplier,
		T1top								= 750+adder*multiplier,
		T2start								= 900+adder*multiplier,
		T2low								= 1050+adder*multiplier,
		T2med								= 1200+adder*multiplier,
		T2high								= 1350+adder*multiplier,
		T2top								= 1500+adder*multiplier,
		T3start								= 1750+adder*multiplier,
		T3low								= 2000+adder*multiplier,
		T3med								= 2250+adder*multiplier,
		T3high								= 2500+adder*multiplier,
		T3top								= 2750+adder*multiplier,
		T4start								= 3000+adder*multiplier,
		T4low								= 3250+adder*multiplier,
		T4med								= 3500+adder*multiplier,
		T4high								= 3750+adder*multiplier,
		T4top								= 4000+adder*multiplier,
		BossFight							= 4001+adder*multiplier,
		-- don't delete
		NoRadar								= 1200, --Under this score beacons don't spawn in radar covered area. Above this score they can spawn in radar but not in LoS.
	},
	other = {
		heighttolerance						= 30, -- higher = allow higher height diffrences
		noheightchecksforwater				= true,
	}
}


-- Modules configs
buildingSpawnerModuleConfig = {
	spawnchance 						= 90,
}

unitSpawnerModuleConfig = {
	bossFightEnabled					= true,
	FinalBossUnit						= true,
		FinalBossHealth						= 250000, -- this*teamcount*difficulty
		FinalBossMinionsPassive				= 3000, -- this/(teamcount*difficulty), how often does boss spawn minions passively, frames.
		FinalBossMinionsActive				= 150, -- this/(teamcount*difficulty), how often does boss spawn minions when taking damage, frames.
	BossWaveTimeLeft					= 300,
	aircraftchance 						= 8, -- higher number = lower chance
	globalscoreperoneunit 				= 200,
	spawnchance							= 120,
	beaconspawnchance					= 120,
	minimumspawnbeacons					= 2,
	landmultiplier 						= 0.75,
	airmultiplier 						= 2,
	seamultiplier 						= 0.2,
	chanceforaircraftonsea				= 2, -- higher number = lower chance

	t0multiplier						= 1.5,
	t1multiplier						= 1.25,
	t2multiplier						= 1,
	t3multiplier						= 0.75,
	t4multiplier						= 0.1,
}

constructorControllerModuleConfig = {
	constructortimerstart				= 120, -- ammount of seconds it skips from constructortimer for the first spawn (make first spawn earlier - this timer starts on timer-Timer1)
	constructortimer 					= 220, -- time in seconds between commander/constructor spawns
	constructortimerreductionframes		= 36000,
	minimumconstructors					= 5,
	useresurrectors						= false,
		searesurrectors					= false,
	useconstructors						= true,
	usecollectors						= false,
}

unitControllerModuleConfig = {
	minimumrangeforfight				= 650,
}

spawnProtectionConfig = {
	spread				= 192,
}


-- Functions which you can configure
function CountScavConstructors()
	return UDC(GaiaTeamID, UDN.ecommander.id) + UDC(GaiaTeamID, UDN.ecommanderbattle.id)
end

function UpdateTierChances(n)
	-- Must be 100 in total
	if globalScore > scavconfig.timers.T4top then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 10
		TierSpawnChances.T3 = 30
		TierSpawnChances.T4 = 60
	elseif globalScore > scavconfig.timers.T4high then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 20
		TierSpawnChances.T3 = 50
		TierSpawnChances.T4 = 30
	elseif globalScore > scavconfig.timers.T4med then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 30
		TierSpawnChances.T3 = 50
		TierSpawnChances.T4 = 20
	elseif globalScore > scavconfig.timers.T4low then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 40
		TierSpawnChances.T3 = 50
		TierSpawnChances.T4 = 10
	elseif globalScore > scavconfig.timers.T4start then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 40
		TierSpawnChances.T3 = 55
		TierSpawnChances.T4 = 5
	elseif globalScore > scavconfig.timers.T3top then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 20
		TierSpawnChances.T3 = 70
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T3high then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 50
		TierSpawnChances.T3 = 40
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T3med then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 60
		TierSpawnChances.T3 = 30
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T3low then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 65
		TierSpawnChances.T3 = 25
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T3start then
		TierSpawnChances.T0 = 0
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 70
		TierSpawnChances.T3 = 10
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T2top then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 80
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T2high then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 30
		TierSpawnChances.T2 = 60
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T2med then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 40
		TierSpawnChances.T2 = 50
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T2low then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 60
		TierSpawnChances.T2 = 30
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T2start then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 70
		TierSpawnChances.T2 = 20
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T1top then
		TierSpawnChances.T0 = 10
		TierSpawnChances.T1 = 90
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T1high then
		TierSpawnChances.T0 = 40
		TierSpawnChances.T1 = 60
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T1med then
		TierSpawnChances.T0 = 60
		TierSpawnChances.T1 = 40
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T1low then
		TierSpawnChances.T0 = 80
		TierSpawnChances.T1 = 20
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	elseif globalScore > scavconfig.timers.T1start then
		TierSpawnChances.T0 = 90
		TierSpawnChances.T1 = 10
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	else
		TierSpawnChances.T0 = 100
		TierSpawnChances.T1 = 0
		TierSpawnChances.T2 = 0
		TierSpawnChances.T3 = 0
		TierSpawnChances.T4 = 0
	end
end