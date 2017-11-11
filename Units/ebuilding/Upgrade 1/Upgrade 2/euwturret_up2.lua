-- UNITDEF -- EUWTURRET_up2 --
--------------------------------------------------------------------------------

unitName = [[euwturret_up2]]

--------------------------------------------------------------------------------

buildCostMetal = 120

isUpgraded	= [[2]]

humanName = [[Rooter Mark III]]

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