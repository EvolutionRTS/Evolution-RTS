-----------------------------------------------------------------------------
-- SnowTree4
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "SnowTree4",
   blocking       = true,
   category       = "Vegitation",
   damage            = 120,
   description       = "Snowy Tree",
   energy            = 400,
   flammable         = 0,
   footprintX        = 7,
   footprintZ        = 5,
   upright           = true,
   height            = "66",
   hitdensity        = "5",
   metal          = 10,
   object            = "features/lathan/SnowTree4.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

