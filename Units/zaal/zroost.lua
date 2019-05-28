-- UNITDEF -- ZROOST --
--------------------------------------------------------------------------------

unitName = [[zroost]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 50
energyUse = 0

primaryCEG = "custom:fusionreactionnuclear-1color"

humanName = [[Zaal Roost]]

objectName = [[zaal/zroost.s3o]]
script = [[zaal/zroost_lus.lua]]

techprovided = [[1 roost]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zroost_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------