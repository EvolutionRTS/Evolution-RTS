-----------------------------------------------------------------------------
-- SnowTree7
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "SnowTree7",
   blocking       = true,
   category       = "Vegitation",
   damage            = 120,
   description       = "Snowy Tree",
   energy = 10,
-- energy            = 400,
   flammable         = 0,
   footprintX        = 7,
   footprintZ        = 9,
   upright           = true,
   height            = "66",
   hitdensity        = "5",
   metal = 0,
--metal          = 10,
   object            = "features/lathan/SnowTree7.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

