-- UNITDEF -- eamphibleveler --
--------------------------------------------------------------------------------

unitName = "eamphibleveler"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Leveler]]

objectName = "eamphibleveler.s3o"
script = "eamphibleveler.cob"

techprovided = [[-1 endbringer]]
tech = [[tech3, 1 endbringer]]
armortype = [[armored]]
--supply = [[30]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibleveler_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
