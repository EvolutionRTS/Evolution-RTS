--------------------------------------------------------------------------------

unitDeaths = {

SMALL_BUILDING = {
   name = "Small building",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=205,
   soundstart="explode2.wav",
   soundhit="explode2.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_SMALL",
   cameraShake=200,
    damage = {
      default            = 0,
    },
  },

MEDIUM_BUILDING = {
   name="Medium building",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=325,
   soundstart="explode4.wav",
   soundhit="explode4.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_MEDIUM",
   cameraShake=400,
    damage = {
      default            = 0,
    },
  },

LARGE_BUILDING = {

   name="Large building",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=400,
   soundstart="explode1.wav",
   soundhit="explode1.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION",
   cameraShake=600,
    damage = {
      default            = 0,
    },
  },

ESTOR_BUILDING = {
   name="Small building",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=420,
   soundstart="explode4.wav",
   soundhit="explode4.wav",
   explosiongenerator="custom:FACTORY_EXPLOSION_SMALL",
   cameraShake=100,
    damage = {
      default            = 0,
    },
  },

SMALL_UNIT = {

   name="Small tank",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=75,
   soundstart="explode2.wav",
   soundhit="explode2.wav",
   cameraShake=100,

   explosiongenerator="custom:SMALL_UNIT_Expl",
    damage = {
      default            = 0,
    },
  },


MEDIUM_UNIT = {

   name="Medium Unit",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=95,
   soundstart="explode4.wav",
   soundhit="explode4.wav",
   explosiongenerator="custom:MED_UNIT_Expl",
   cameraShake=200,
    damage = {
      default            = 0,
    },
  },



BIG_UNIT = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=110,
   soundstart="explode3.wav",
   soundhit="explode3.wav",
   explosiongenerator="custom:BIG_UNIT_Expl",
   cameraShake=300,
    damage = {
      default            = 0,
    },
  },

CONSTRUCTOR = {

   name="con",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=500,
   soundstart="explode5.wav",
   soundhit="explode5.wav",
   cameraShake=100,

   explosiongenerator="custom:greencannonimpact",
    damage = {
      default            = -100,
    },
  },

ebombblast = {

   name="hoverbomb",
   weaponType		   = "Cannon",
   ballistic=1,
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
	  damagetype		= "Explosive",
	  nofriendlyfire	= "1",	  
    },  

    damage = {
      default            = 1000,
    },
  },

krabblast = {

   name="krabblast",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=556,
   soundstart="unitexplodemedium.wav",
   soundhit="unitexplodemedium.wav",
   explosiongenerator="custom:KRABDEATH",
   cameraShake=500,
   customparams = {
	  damagetype		= "Explosive",  
    },  

    damage = {
      default            = 250,
    },
  },
  
  
MEXPOP2 = {
   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   range=500,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=1500,
   soundstart="explode5.wav",
   soundhit="explode5.wav",
   impulse=0,
   impulsefactor=0,
   explosiongenerator="custom:NUKE",
   

    damage = {
      default            = 50,
    },
  },

PYRO_BLAST = {

   name="Pyro Blast",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=128,
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
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=516,
   soundstart="explode3.wav",
   soundhit="explode3.wav",
   cameraShake=400,

   explosiongenerator="custom:POWERPLANT_EXPLOSION_BIG",
   customparams = {
	  damagetype		= "explosive",  
    },  

    damage = {
      default            = 0,
    },
  },
POWERPLANTPOP = {

   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=600,
   AreaOfEffect=516,
   soundstart="explode3.wav",
   soundhit="explode3.wav",
   cameraShake=200,

   explosiongenerator="custom:POWERPLANT_EXPLOSION",
   customparams = {
	  damagetype		= "explosive",  
    },  

    damage = {
      default            = 0,
    },
  },
  
GEOPOP = {

   name="Atomic Blast Weapon",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=500,
   AreaOfEffect=516,
   soundstart="explode3.wav",
   soundhit="explode3.wav",
   cameraShake=300,

   explosiongenerator="custom:POWERPLANT_EXPLOSION_MEDIUM",
   customparams = {
	  damagetype		= "explosive",  
    },  

    damage = {
      default            = 0,
    },
  },

HUGE_UNITEX = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=550,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=110,
   soundstart="explode1.wav",
   soundhit="explode1.wav",
   explosiongenerator="custom:HUGE_UNIT_Expl",
   cameraShake=500,

    damage = {
      default            = 0,
    },
  },


HUGE_UNIT = {

   name="Big Kbot",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=550,
   reloadtime=3.6,
   weaponvelocity=250,
   AreaOfEffect=110,
   soundstart="explode1.wav",
   soundhit="explode1.wav",
   explosiongenerator="custom:HUGE_UNIT_Expl",
   cameraShake=500,

    damage = {
      default            = 0,
    },
  },
}

return lowerkeys(unitDeaths)
