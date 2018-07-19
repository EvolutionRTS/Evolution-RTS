-- UNITDEF -- ELIGHTTURRET2_up1 --
--------------------------------------------------------------------------------

unitName = [[eturretlightai]]

--------------------------------------------------------------------------------

buildCostMetal = 100

isUpgraded	= [[0]]

humanName = [[Lightning Rod Mark AI]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech0]]
armortype = [[building]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------