-----------------------------------------------------------------------------
--  Cactus5
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "Cactus5",
   blocking       = false,
   category       = "Vegitation",
   damage            = 500,
   description       = "Cactus",
   energy = 10,
-- energy            = 50,
   flammable         = 0,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",
   metal = 0,
--metal          = 10,
   object            = "features/lathan/Cactus5.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

