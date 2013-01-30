-----------------------------------------------------------------------------
--  cluster2_dead
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "cluster3_dead",
   blocking       = true,
   category       = "Trees",
   damage            = 4000,
   description       = "Dead palm trees",
   energy = 10,
-- energy            = 10,
   flammable         = 0,
   footprintX        = 6,
   footprintZ        = 6,
   upright           = true,
   height            = "36",
   hitdensity        = "5",
   metal          = 10,
   object            = "features/smoth/cluster3_dead.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
