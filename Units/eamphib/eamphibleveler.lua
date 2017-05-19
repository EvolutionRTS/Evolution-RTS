-- UNITDEF -- eamphibleveler --
--------------------------------------------------------------------------------

unitName = "eamphibleveler"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Leveler]]

objectName = "eamphibleveler.s3o"
script = "eamphibleveler.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[10]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibleveler_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
