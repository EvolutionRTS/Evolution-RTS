return {
	chicken_dodo1 = {
		acceleration = 6,
		activatewhenbuilt = true,
		autoheal = 50,
		bmcode = "1",
		brakerate = 0.2,
		buildcostenergy = 1,
		buildcostmetal = 128,
		builder = false,
		buildtime = 1,
		buildpic = "chicken_unitpics/chicken_dodo1.png",
		canguard = true,
		canhover = "1",
		canmove = true,
		canpatrol = true,
		canstop = "1",
		category = "BIO",
		collide = false,
		collisionvolumeoffsets = "0 -1 0",
		collisionvolumescales = "10 14 22",
		collisionvolumetype = "box",
		corpse = "chicken_egg",
		defaultmissiontype = "Standby",
		description = "Chicken Bomb",
		explodeas = "DODO_DEATH1",
		floater = false,
		footprintx = 1,
		footprintz = 1,
		hidedamage = 1,
		icontype = "chicken",
		kamikaze = true,
		kamikazedistance = 40,
		leavetracks = true,
		maneuverleashlength = "640",
		mass = 5000,
		maxdamage = 200,
		maxslope = 18,
		maxvelocity = 7,
		maxwaterdepth = 0,
		movementclass = "CHICKENHOVERDODO",
		name = "Dodo",
		noautofire = false,
		nochasecategory = "VTOL SINK HOVER",
		objectname = "ChickenDefenseModels/chicken_dodo.s3o",
		script = "ChickenDefenseScripts/chicken_dodo1.cob",
		seismicsignature = 2,
		selfdestructas = "DODO_DEATH1",
		selfdestructcountdown = 0,
		side = "THUNDERBIRDS",
		sightdistance = 36,
		smoothanim = true,
		stealth = 1,
		steeringmode = "2",
		tedclass = "KBOT",
		trackoffset = 1,
		trackstrength = 6,
		trackstretch = 1,
		tracktype = "ChickenTrack",
		trackwidth = 10,
		turninplace = true,
		turnrate = 5000,
		unitname = "chicken_dodo1",
		upright = false,
		waterline = 1,
		workertime = 0,
		featuredefs = {
			dead = {},
			heap = {},
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:blood_spray",
				[2] = "custom:blood_explode",
				[3] = "custom:dirt",
			},
		},
	},
}
