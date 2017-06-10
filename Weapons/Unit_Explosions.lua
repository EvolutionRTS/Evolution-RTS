--------------------------------------------------------------------------------
-- These represent both the area of effect and the camerashake amount
local smallExplosion = 200
local smallExplosionImpulseFactor = 0
local mediumExplosion = 400
local mediumExplosionImpulseFactor = 0
local largeExplosion = 600
local largeExplosionImpulseFactor = 0
local hugeExplosion = 1000
local hugeExplosionImpulseFactor = 0

unitDeaths = {

--BUILDING DEATHS--

--Orange

	smallBuildingExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--blue

	smallBuildingExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-blue",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-blue",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-blue",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-Blue",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--blue-emp

	smallBuildingExplosionGenericBlueEMP = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-blue-emp",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericBlueEMP = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-blue-emp",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericBlueEMP = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-blue-emp",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericBlueEMP = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-Blue-emp",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--green

	smallBuildingExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-green",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-green",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-green",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-green",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},

--purple

	smallBuildingExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-purple",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-purple",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-purple",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-purple",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--red

	smallBuildingExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-red",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-red",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-red",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-red",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--white

	smallBuildingExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericbuildingexplosion-small-white",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumBuildingExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericbuildingexplosion-medium-white",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeBuildingExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-large-white",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},

	hugeBuildingExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericbuildingexplosion-huge-white",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	
--UNIT DEATHS--

--Orange

	smallExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGeneric = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--Blue

	smallExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small-blue",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium-blue",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large-blue",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGenericBlue = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge-blue",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--Green

	smallExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small-green",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium-green",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large-green",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGenericGreen = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge-green",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
--Purple

	smallExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small-purple",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium-purple",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large-purple",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGenericPurple = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge-purple",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	
--Red

	smallExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small-red",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium-red",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large-red",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGenericRed = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge-red",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	
--White

	smallExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = smallExplosionImpulseFactor,
		AreaOfEffect=smallExplosion,
		explosiongenerator="custom:genericunitexplosion-small-white",
		cameraShake=smallExplosion,
		damage = {
			default            = 0,
		},
	},

	mediumExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = mediumExplosionImpulseFactor,
		AreaOfEffect=mediumExplosion,
		explosiongenerator="custom:genericunitexplosion-medium-white",
		cameraShake=mediumExplosion,
		damage = {
			default            = 0,
		},
	},
	
	largeExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = largeExplosionImpulseFactor,
		AreaOfEffect=largeExplosion,
		explosiongenerator="custom:genericunitexplosion-large-white",
		cameraShake=largeExplosion,
		damage = {
			default            = 0,
		},
	},
	
	hugeExplosionGenericWhite = {
		weaponType		   = "Cannon",
		impulseFactor      = hugeExplosionImpulseFactor,
		AreaOfEffect=hugeExplosion,
		explosiongenerator="custom:genericunitexplosion-huge-white",
		cameraShake=hugeExplosion,
		damage = {
			default            = 0,
		},
	},



-- Old and busted
SMALL_BUILDING = {
   name = "Small building",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode2.wav",
   soundhit="explosions/explode2.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_SMALL",
   cameraShake=200,
    damage = {
      default            = 0,
    },
  },

MEDIUM_BUILDING = {
   name="Medium building",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode4.wav",
   soundhit="explosions/explode4.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_MEDIUM",
   cameraShake=400,
    damage = {
      default            = 0,
    },
  },

LARGE_BUILDING = {

   name="Large building",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode1.wav",
   soundhit="explosions/explode1.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION",
   cameraShake=600,
    damage = {
      default            = 0,
    },
  },

ESTOR_BUILDING = {
   name="Small building",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode4.wav",
   soundhit="explosions/explode4.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_SMALL",
   cameraShake=100,
    damage = {
      default            = 0,
    },
  },

SMALL_UNIT = {

   name="Small tank",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode2.wav",
   soundhit="explosions/explode2.wav",
   cameraShake=100,

   explosiongenerator="custom:SMALL_UNIT_Expl",
    damage = {
      default            = 0,
    },
  },


MEDIUM_UNIT = {

   name="Medium Unit",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode4.wav",
   soundhit="explosions/explode4.wav",
   explosiongenerator="custom:MED_UNIT_Expl",
   cameraShake=200,
    damage = {
      default            = 0,
    },
  },



BIG_UNIT = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode3.wav",
   soundhit="explosions/explode3.wav",
   explosiongenerator="custom:BIG_UNIT_Expl",
   cameraShake=300,
    damage = {
      default            = 0,
    },
  },

CONSTRUCTOR = {

   name="con",
   weaponType		   = "Cannon",
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=500,
   soundstart="explosions/explode5.wav",
   soundhit="explosions/explode5.wav",
   cameraShake=100,

   explosiongenerator="custom:greencannonimpact",
    damage = {
      default            = -100,
    },
  },

ebombblast = {

   name="hoverbomb",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=556,
   soundstart="unitexplodemedium.wav",
   soundhit="unitexplodemedium.wav",
   explosiongenerator="custom:CRAWL_SUICIDE_Expl",
   customparams = {
	  damagetype		= "default",
	  nofriendlyfire	= "1",	  
    },  

    damage = {
      default            = 1000,
    },
  },

krabblast = {

   name="krabblast",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="unitexplodemedium.wav",
   soundhit="unitexplodemedium.wav",
   explosiongenerator="custom:KRABDEATH",
   cameraShake=500,
   customparams = {
	  damagetype		= "default",  
    },  

    damage = {
      default            = 0,
    },
  },
  
  
MEXPOP2 = {
   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   
   turret=1,
   range=500,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode5.wav",
   soundhit="explosions/explode5.wav",
   
   impulsefactor=0,
   explosiongenerator="custom:NUKE",
   

    damage = {
      default            = 0,
    },
  },

PYRO_BLAST = {

   name="Pyro Blast",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="unitexplodesmall.wav",
   soundhit="unitexplodesmall.wav",
   explosiongenerator="custom:PYRO_UNIT_Expl",
   cameraShake=100,

    damage = {
      default            = 0,
    },
  },

FUSIONPOP = {

   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode3.wav",
   soundhit="explosions/explode3.wav",
   cameraShake=400,

   explosiongenerator="custom:POWERPLANT_EXPLOSION_BIG",
   customparams = {
	  damagetype		= "default",  
    },  

    damage = {
      default            = 0,
    },
  },
POWERPLANTPOP = {

   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=600,
   AreaOfEffect=0,
   soundstart="explosions/explode3.wav",
   soundhit="explosions/explode3.wav",
   cameraShake=200,

   explosiongenerator="custom:POWERPLANT_EXPLOSION",
   customparams = {
	  damagetype		= "default",  
    },  

    damage = {
      default            = 0,
    },
  },
  
GEOPOP = {

   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=500,
   AreaOfEffect=0,
   soundstart="explosions/explode3.wav",
   soundhit="explosions/explode3.wav",
   cameraShake=300,

   explosiongenerator="custom:POWERPLANT_EXPLOSION_MEDIUM",
   customparams = {
	  damagetype		= "default",  
    },  

    damage = {
      default            = 0,
    },
  },

HUGE_UNITEX = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=550,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode1.wav",
   soundhit="explosions/explode1.wav",
   explosiongenerator="custom:HUGE_UNIT_Expl",
   cameraShake=500,

    damage = {
      default            = 0,
    },
  },


HUGE_UNIT = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   
   turret=1,
   impulseFactor      = 0,
   range=550,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=0,
   soundstart="explosions/explode1.wav",
   soundhit="explosions/explode1.wav",
   explosiongenerator="custom:HUGE_UNIT_Expl",
   cameraShake=500,

    damage = {
      default            = 0,
    },
  },
}

return lowerkeys(unitDeaths)
