-- UNITDEF -- zlightswarm --
--------------------------------------------------------------------------------

unitName = "zlightswarm"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zlightswarm.s3o"
script = "zaal/zlightswarm.cob"

tech = [[tech0]]
armortype = [[light]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zlightswarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
