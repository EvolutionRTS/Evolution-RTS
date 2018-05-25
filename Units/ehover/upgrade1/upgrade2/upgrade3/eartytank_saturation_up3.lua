-- UNITDEF -- EARTYTANK_saturation_up3 --
--------------------------------------------------------------------------------

unitName = "eartytank_saturation_up3"

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = "HellFury MK IV"

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
