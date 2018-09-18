-- UNITDEF -- ELASERBATTERY --
--------------------------------------------------------------------------------

unitName = [[elaserbattery]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Aegis]]

objectName = [[elaserbattery.s3o]]
script = [[elaserbattery.cob]]

tech = [[tech1]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elaserbattery_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------