-- UNITDEF -- EARTYTURRET_up3 --
--------------------------------------------------------------------------------

unitName = [[eartyturret_up3]]	
	
isUpgraded = [[3]]

humanName = [[Lobster MK IV]]
objectName = [[eartyturret.s3o]]
script = [[eartyturret.cob]]

tech = [[tech3]]
armortype = [[building]]

AreaOfEffect = 600

VFS.Include("units-configs-basedefs/basedefs/buildings/eartyturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------