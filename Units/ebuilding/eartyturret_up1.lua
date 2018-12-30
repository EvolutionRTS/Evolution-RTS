-- UNITDEF -- EARTYTURRET_up1 --
--------------------------------------------------------------------------------

unitName = [[eartyturret_up1]]	
	
isUpgraded = [[1]]

humanName = [[Lobster MK II]]
objectName = [[eartyturret.s3o]]
script = [[eartyturret.cob]]

tech = [[tech3]]
armortype = [[building]]

AreaOfEffect = 200

VFS.Include("units-configs-basedefs/basedefs/buildings/eartyturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------