-- UNITDEF -- EARTYTURRET_up2 --
--------------------------------------------------------------------------------

unitName = [[eartyturret_up2]]	
	
isUpgraded = [[2]]

humanName = [[Lobster MK III]]
objectName = [[eartyturret.s3o]]
script = [[eartyturret.cob]]

tech = [[tech3]]
armortype = [[building]]

AreaOfEffect = 400

VFS.Include("units-configs-basedefs/basedefs/buildings/eartyturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------