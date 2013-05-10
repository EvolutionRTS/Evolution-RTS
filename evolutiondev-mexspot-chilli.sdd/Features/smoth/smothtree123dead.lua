-----------------------------------------------------------------------------
--  smothtree123dead
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "smothtree123dead",
   blocking       = true,
   category       = "Trees",
   damage            = 100,
   description       = "Tree Trunk",
   energy = 10,
-- energy            = 1,
   flammable         = 0,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/smoth/smothtree123dead.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
