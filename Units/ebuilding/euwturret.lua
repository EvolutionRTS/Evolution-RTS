-- UNITDEF -- EUWTURRET --
--------------------------------------------------------------------------------

unitName = [[euwturret]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Rooter]]

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