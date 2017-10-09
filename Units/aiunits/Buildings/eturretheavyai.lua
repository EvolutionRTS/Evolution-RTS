-- UNITDEF -- EHEAVYTURRET2_up1 --
--------------------------------------------------------------------------------

unitName = [[eturretheavyai]]

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = [[Immolator Mark]]

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