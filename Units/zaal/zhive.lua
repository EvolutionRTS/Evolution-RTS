-- UNITDEF -- ZHIVE --
--------------------------------------------------------------------------------

unitName = [[zhive]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 30
energyUse = 0

supplygranted = 40

primaryCEG = "custom:fusionreactionnuclear-1color"

humanName = [[Zaal Hive]]

objectName = [[zaal/zhive.s3o]]
script = [[zaal/zhive.cob]]

techprovided = [[1 hive]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------