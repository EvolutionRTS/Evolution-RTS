-- UNITDEF -- ELIGHTTURRET2 --
--------------------------------------------------------------------------------

unitName = [[elightturret2]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Pincushion]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech0]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------