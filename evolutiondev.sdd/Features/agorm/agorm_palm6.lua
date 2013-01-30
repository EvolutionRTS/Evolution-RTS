-----------------------------------------------------------------------------
--  agorm_palm6
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "agorm_palm6",
   blocking       = true,
   category       = "vegitation",
   damage            = 100,
   description       = "palm tree",
   energy = 10,
-- energy            = 1,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/agorm/palm6.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
