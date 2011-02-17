-----------------------------------------------------------------------------
--  smothtree3
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "smothtree3",
   blocking       = true,
   category       = "Trees",
   damage            = 100,
   description       = "Tree",
   energy            = 1,
   featuredead       = "smothdeadtree1",  
   flammable         = 0,
   footprintX        = 2,
   footprintZ        = 2,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/smoth/smothtree3.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
