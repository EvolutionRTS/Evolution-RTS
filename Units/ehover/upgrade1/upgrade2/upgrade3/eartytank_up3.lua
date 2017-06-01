-- UNITDEF -- EARTYTANK_up3 --
--------------------------------------------------------------------------------

unitName = "eartytank_up3"

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[ShadowFury Mark IV]]

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
