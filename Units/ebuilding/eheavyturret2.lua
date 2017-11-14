-- UNITDEF -- EHEAVYTURRET2 --
--------------------------------------------------------------------------------

unitName = [[eheavyturret2]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Immolator]]

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