-----------------------------------------------------------------------------
-- SnowTree1
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "SnowTree1",
   blocking       = true,
   category       = "Vegitation",
   damage            = 120,
   description       = "Snowy Tree",
   energy = 10,
-- energy            = 400,
   flammable         = 0,
   footprintX        = 2,
   footprintZ        = 2,
   upright           = true,
   height            = "66",
   hitdensity        = "5",
   metal = 0,
--metal          = 10,
   object            = "features/lathan/SnowTree1.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

