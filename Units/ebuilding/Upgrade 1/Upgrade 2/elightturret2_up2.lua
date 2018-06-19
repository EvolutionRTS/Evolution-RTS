-- UNITDEF -- ELIGHTTURRET2_up2 --
--------------------------------------------------------------------------------

unitName = [[elightturret2_up2]]

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[Pincushion Mark III]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech2]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------