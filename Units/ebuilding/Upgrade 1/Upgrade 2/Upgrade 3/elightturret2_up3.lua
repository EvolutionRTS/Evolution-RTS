-- UNITDEF -- ELIGHTTURRET2_up3 --
--------------------------------------------------------------------------------

unitName = [[elightturret2_up3]]

--------------------------------------------------------------------------------

buildCostMetal = 400

isUpgraded	= [[3]]

humanName = [[Lightning Rod Mark IV]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech1]]
armortype = [[building]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------