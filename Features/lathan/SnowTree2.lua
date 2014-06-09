-----------------------------------------------------------------------------
-- SnowTree2
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "SnowTree2",
   blocking       = true,
   category       = "Vegitation",
   damage            = 120,
   description       = "Snowy Tree",
   energy = 10,
-- energy            = 400,
   flammable         = 0,
   footprintX        = 4,
   footprintZ        = 4,
   upright           = true,
   height            = "66",
   hitdensity        = "5",
   metal = 0,
--metal          = 10,
   object            = "features/lathan/SnowTree2.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

