-- UNITDEF -- EHEAVYTURRET2_up2 --
--------------------------------------------------------------------------------

unitName = [[eheavyturret2_up2]]

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[Immolator Mark III]]

objectName = [[eheavyturret3.s3o]]
script = [[eheavyturret2.cob]]

tech = [[tech2]]
armortype = [[building]]
--supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/buildings/eheavyturret2_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------