-- UNITDEF -- EARTYTANK_saturation --
--------------------------------------------------------------------------------

unitName = "eartytank_saturation"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "HellFury"

objectName = "eartytank2.s3o"
script = "eartytank2.cob"

tech = [[tech2]]
armortype = [[light]]
supply = [[8]]

VFS.Include("units-configs-basedefs/basedefs/hover/eartytanksaturation_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
