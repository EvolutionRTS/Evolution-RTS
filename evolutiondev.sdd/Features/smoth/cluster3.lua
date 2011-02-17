-----------------------------------------------------------------------------
--  cluster3_dead
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "cluster3",
   blocking       = true,
   category       = "Trees",
   damage            = 4000,
   description       = "Palm trees",
   energy            = 10,
   flammable         = 0,
   featuredead       = "cluster3_dead",      
   footprintX        = 6,
   footprintZ        = 6,
   upright           = true,
   height            = "36",
   hitdensity        = "5",
   metal          = 10,
   object            = "features/smoth/cluster3.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
