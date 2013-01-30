-----------------------------------------------------------------------------
--  Cactus6
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "Cactus6",
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
   metal          = 10,
   object            = "features/lathan/Cactus6.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

