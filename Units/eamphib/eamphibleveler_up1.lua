-- UNITDEF -- eamphibleveler_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibleveler_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Leveler Mark II]]

objectName = "eamphibleveler.s3o"
script = "eamphibleveler.cob"

tech = [[tech3]]
armortype = [[armored]]
--supply = [[30]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibleveler_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
