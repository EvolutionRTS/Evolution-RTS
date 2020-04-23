-- UNITDEF -- EARTYTURRET --
--------------------------------------------------------------------------------

unitName = [[eartyturret]]	
	
isUpgraded = [[0]]

humanName = [[Lobster]]
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