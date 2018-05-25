-- UNITDEF -- EARTYTANK_saturation_up1 --
--------------------------------------------------------------------------------

unitName = "eartytank_saturation_up1"

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = "HellFury MK II"

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
