-- UNITDEF -- EHEAVYTURRET2_up1 --
--------------------------------------------------------------------------------

unitName = [[eheavyturret2_up1]]

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = [[Immolator Mark II]]

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