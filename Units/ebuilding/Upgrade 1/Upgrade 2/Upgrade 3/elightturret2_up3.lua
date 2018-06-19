-- UNITDEF -- ELIGHTTURRET2_up3 --
--------------------------------------------------------------------------------

unitName = [[elightturret2_up3]]

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[Pincushion Mark IV]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech3]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------