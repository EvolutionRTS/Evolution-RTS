-- UNITDEF -- ZMEX_UP3 --
--------------------------------------------------------------------------------

unitName = [[zmex_up3]]

--------------------------------------------------------------------------------

metalMultiplier = 2

energyUse = 10

buildCostMetal = 200

primaryCEG = "custom:fusionreactionnuclear-4color"

humanName = [[Zaal Metal Extractor Mk IV]]

objectName = [[zaal/zmex.s3o]]
script = [[zaal/zmex.cob]]

tech = [[tech3]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmex_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------