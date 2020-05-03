-- UNITDEF -- zconstructor --
--------------------------------------------------------------------------------

unitName = "zconstructor"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

buildDistance = 300

humanName = "Worker Drone"

objectName = "zaal/zkamikaze.s3o"
script = "zaal/zconstructor.cob"

armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zconstructor_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
