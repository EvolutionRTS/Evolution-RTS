return {
	chickenf2 = {
		acceleration = 1,
		airhoverfactor = 0,
		attackrunlength = 32,
		bmcode = "1",
		brakerate = 0.4,
		buildcostenergy = 1,
		buildcostmetal = 50,
		builder = false,
		buildpic = "chicken_unitpics/chickenf2.png",
		buildtime = 1,
		canattack = true,
		canfly = true,
		canguard = true,
		canland = true,
		canmove = true,
		canpatrol = true,
		canstop = "1",
		cansubmerge = true,
		category = "BIO VTOL", --VTOL MOBILE WEAPON NOTSUB NOTSHIP NOTHOVER ALL",
		collide = false,
		collisionvolumeoffsets = "0 8 -2",
		collisionvolumescales = "70 14 48",
		collisionvolumetype = "box",
		corpse = "chicken_egg",
		cruisealt = 325,
		defaultmissiontype = "Standby",
		description = "Flying Chicken Scout",
		explodeas = "TALON_DEATH",
		footprintx = 3,
		footprintz = 3,
		hidedamage = 1,
		icontype = "chickenf",
		idleautoheal = 15,
		idletime = 900,
		maneuverleashlength = "20000",
		mass = 227.5,
		maxdamage = 1800,
		maxvelocity = 4.6,
		moverate1 = "32",
		name = "Buzzard",
		noautofire = false,
		nochasecategory = "VTOL",
		objectname = "ChickenDefenseModels/chickenf1.s3o",
		script = "ChickenDefenseScripts/chickenf2.cob",
		seismicsignature = 0,
		selfdestructas = "TALON_DEATH",
		side = "THUNDERBIRDS",
		sightdistance = 1400,
		smoothanim = true,
		steeringmode = "2",
		tedclass = "VTOL",
		turninplace = true,
		turnrate = 5000,
		unitname = "chickenf2",
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
		weapondefs = {
			weapon = {
				interceptedByShieldType   = 4,
				accuracy = 300,
				areaofeffect = 200,
				avoidfeature = false,
				avoidfriendly = false,
				burst = 1,
				burstrate = 1,
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0,
				explosiongenerator = "",
				impulseboost = 1,
				impulsefactor = 1,
				interceptedbyshieldtype = 0,
				model = "ChickenDefenseModels/chickeneggred.s3o",
				mygravity = 0.5,
				name = "GooBombs",
				noselfdamage = true,
				range = 800,
				reloadtime = 30,
				soundhit = "ChickenDefenseSounds/junohit2edit",
				sprayangle = 400,
				weapontype = "AircraftBomb",
				damage = {
					default = 250,
				},
			},
		},
		weapons = {
			[1] = {
				def = "WEAPON",
			},
		},
	},
}
