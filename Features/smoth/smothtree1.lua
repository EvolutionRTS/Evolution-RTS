-----------------------------------------------------------------------------
--  smothtree1
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "smothtree1",
   blocking       = true,
   category       = "Trees",
   damage            = 100,
   description       = "Tree",
   energy = 10,
-- energy            = 1,
   featuredead       = "smothdeadtree1",  
   flammable         = 0,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/smoth/smothtree1.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
