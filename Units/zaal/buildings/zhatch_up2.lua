-- UNITDEF -- ZHATCH_UP2 --
--------------------------------------------------------------------------------

unitName = [[zhatch_up2]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 300

humanName = [[Zaal Hive]]

objectName = [[zaal/zfactory_up2.s3o]]
script = [[zaal/zfactory.cob]]

techprovided = [[tech3, tech2, tech1, tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------