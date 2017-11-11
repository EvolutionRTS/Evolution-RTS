-- UNITDEF -- EHEAVYTURRET2_up1 --
--------------------------------------------------------------------------------

unitName = [[eturretheavyai]]

--------------------------------------------------------------------------------

buildCostMetal = 160

isUpgraded	= [[0]]

humanName = [[Immolator Mark AI]]

objectName = [[eheavyturret3.s3o]]
script = [[eheavyturret2.cob]]

tech = [[tech2]]
armortype = [[building]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/buildings/eheavyturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------