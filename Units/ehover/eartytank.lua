-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

unitName = "eartytank"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "ShadowFury"

objectName = "eartytank2.s3o"
script = "eartytank2.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[8]]

VFS.Include("units-configs-basedefs/basedefs/hover/eartytank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
