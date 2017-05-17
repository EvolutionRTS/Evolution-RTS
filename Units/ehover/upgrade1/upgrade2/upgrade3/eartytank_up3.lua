-- UNITDEF -- EARTYTANK_up3 --
--------------------------------------------------------------------------------

unitName = "eartytank_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "ShadowFury Upgrade 3"

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
