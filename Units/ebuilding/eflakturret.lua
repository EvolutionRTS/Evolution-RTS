-- UNITDEF -- EFLAKTURRET --
--------------------------------------------------------------------------------

unitName = [[eflakturret]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Fortifier]]

objectName = [[eflakturret.s3o]]
script = [[eflakturret.cob]]

tech = [[tech2]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/buildings/eflakturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------