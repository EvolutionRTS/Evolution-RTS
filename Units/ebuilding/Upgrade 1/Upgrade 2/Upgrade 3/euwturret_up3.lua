-- UNITDEF -- EUWTURRET_up3 --
--------------------------------------------------------------------------------

unitName = [[euwturret_up3]]

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[Rooter Mark IV]]

objectName = [[euwturret.s3o]]
script = [[euwturret.cob]]

tech = [[tech1]]
armortype = [[building]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/buildings/euwturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------