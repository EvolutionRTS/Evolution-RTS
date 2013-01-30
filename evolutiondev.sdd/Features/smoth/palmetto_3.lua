-----------------------------------------------------------------------------
--  palmetto_3
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "palmetto_3",
   blocking       = false,
   category       = "Trees",
   damage            = 4000,
   description       = "palmetto",
   energy = 10,
-- energy            = 10,
   flammable         = 0,
   footprintX        = 2,
   footprintZ        = 2,
   height            = "36",
   hitdensity        = "5",
   metal          = 10,
   object            = "features/smoth/palmetto_3.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
