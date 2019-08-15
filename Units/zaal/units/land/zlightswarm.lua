-- UNITDEF -- zlightswarm --
--------------------------------------------------------------------------------

unitName = "zlightswarm"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "ZaalLing"

objectName = "zaal/zlightswarm.s3o"
script = "zaal/zlightswarm.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zlightswarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
