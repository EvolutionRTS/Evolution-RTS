--------------------------------------------------------------------------------

local unitName                   = "croost"

--------------------------------------------------------------------------------

local unitDef                    = {
	acceleration = 0,
	activatewhenbuilt = true,
	-- autoheal = 1.8,
	bmcode = "0",
	brakerate = 0,
	buildcostenergy = 1,
	buildcostmetal = 500,
	builddistance = 500,
	builder = true,
	buildpic = "chicken_unitpics/roost.png",
	buildtime = 1,
	category = "BIO BUILDING",
	collisionvolumeoffsets = "0 0 0",
	collisionvolumescales = "56 11 56",
	collisionvolumetype = "box",
	description = "Spawns Chicken",
	explodeas = "ROOST_DEATH",
	footprintx = 2,
	footprintz = 2,
	icontype = "energy",
	-- idleautoheal = 10,
	idletime = 90,
	isairbase = true,
	levelground = false,
	mass = 165.75,
	maxdamage = 1800,
	maxvelocity = 0,
	name = "Roost",
	noautofire = false,
	objectname = "ChickenDefenseModels/roost.s3o",
	script = "chickens/croost.lua",
	radardistance = 900,
	seismicsignature = 4,
	selfdestructas = "ROOST_DEATH",
	side = "ARM",
	sightdistance = 450,
	smoothanim = true,
	tedclass = "ENERGY",
	turnrate = 0,
	unitname = "roost",
	upright = false,
	waterline = 0,
	workertime = 0.25,
	yardmap = "ooooooooo",

	buildoptions = Shared.buildListChicken,
	
	sfxtypes = {
		explosiongenerators = {
			[1] = "custom:dirt",
		},
	},
	customparams = {
		unittype = "building",
		--metal_extractor = 1,
		--area_mex_def = "croost",
		armortype = "building",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 9,
	BuildingGroundDecalSizeY      = 9,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------