-- UNITDEF -- EUWTURRET_up1 --
--------------------------------------------------------------------------------

unitName = [[euwturret_up1]]

--------------------------------------------------------------------------------

buildCostMetal = 80

isUpgraded	= [[1]]

humanName = [[Rooter Mark II]]

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