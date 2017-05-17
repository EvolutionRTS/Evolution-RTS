-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

unitName = "eartytank"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "ShadowFury"

objectName = "eartytank2.s3o"
script = "eartytank2.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[8]]

VFS.Include("units/ehover/basedefs/eartytank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
