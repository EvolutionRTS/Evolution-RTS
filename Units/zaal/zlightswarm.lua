-- UNITDEF -- zlightswarm --
--------------------------------------------------------------------------------

unitName = "zlightswarm"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zlightswarm.s3o"
script = "zaal/zlightswarm.cob"

tech = [[hive]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zlightswarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
