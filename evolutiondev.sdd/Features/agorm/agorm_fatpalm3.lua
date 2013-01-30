-----------------------------------------------------------------------------
--  agorm_fatpalm3
-----------------------------------------------------------------------------
local featureDef  =  {
   name           = "agorm_fatpalm3",
   blocking       = true,
   category       = "vegitation",
   damage            = 5000,
   description       = "short palm",
   energy = 10,
-- energy            = 1,
   flammable         = true,
   footprintX        = 1,
   footprintZ        = 1,
   upright           = true,
   height            = "36",
   hitdensity        = "5",

   object            = "features/agorm/palmfat3.s3o",
   reclaimable       = true,
   autoreclaimable      = true,  
   world          = "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
