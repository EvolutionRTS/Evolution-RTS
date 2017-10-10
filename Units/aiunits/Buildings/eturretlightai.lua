-- UNITDEF -- ELIGHTTURRET2_up1 --
--------------------------------------------------------------------------------

unitName = [[eturretlightai]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Lightning Rod]]

objectName = [[elightturret3.s3o]]
script = [[elightturret2.cob]]

tech = [[tech1]]
armortype = [[building]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/buildings/elightturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------