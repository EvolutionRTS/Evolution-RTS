-----------------------------------------------------------------------------
--  agorm_palm1
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "agorm_palm1",
   blocking       = true,
   category       = "vegitation",
   damage            = 100,
   description       = "palmtree",
   energy = 10,
-- energy            = 1,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/agorm/palm1.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
