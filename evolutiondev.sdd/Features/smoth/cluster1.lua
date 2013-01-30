-----------------------------------------------------------------------------
--  cluster1
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "cluster1",
   blocking       = true,
   category       = "Trees",
   damage            = 4000,
   description       = "palm trees",
   energy = 10,
-- energy            = 10,
   flammable         = 0,
   featuredead       = "cluster1_dead",   
   footprintX        = 2,
   footprintZ        = 2,
   upright           = true,
   height            = "36",
   hitdensity        = "5",
   metal          = 10,
   object            = "features/smoth/cluster1.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
