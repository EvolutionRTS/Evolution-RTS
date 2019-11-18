-- UNITDEF -- xrocketturret --
--------------------------------------------------------------------------------

unitName = [[xrocketturret]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[Rocket Turret]]

objectName = [[faction/xrocketturret.s3o]]
script = [[faction/xrocketturret.cob]]

tech = [[tech0]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/faction/xrocketturret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------