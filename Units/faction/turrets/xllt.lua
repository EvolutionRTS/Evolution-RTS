-- UNITDEF -- xllt --
--------------------------------------------------------------------------------

unitName = [[xllt]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[LLT]]

objectName = [[faction/xllt.s3o]]
script = [[faction/xllt.cob]]

tech = [[tech0]]
armortype = [[building]]
--supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/faction/xllt_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------