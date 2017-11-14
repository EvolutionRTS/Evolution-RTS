-- UNITDEF -- EHEAVYTURRET2_up3 --
--------------------------------------------------------------------------------

unitName = [[eheavyturret2_up3]]

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[Immolator Mark IV]]

objectName = [[eheavyturret3.s3o]]
script = [[eheavyturret2.cob]]

tech = [[tech2]]
armortype = [[building]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/buildings/eheavyturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------