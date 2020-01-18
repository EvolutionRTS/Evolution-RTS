-- UNITDEF -- ZMEX_UP2 --
--------------------------------------------------------------------------------

unitName = [[zmex_up2]]

--------------------------------------------------------------------------------

metalMultiplier = 1.66

energyUse = 5

buildCostMetal = 150

primaryCEG = "custom:fusionreactionnuclear-3color"

humanName = [[Zaal Metal Extractor Mk III]]

objectName = [[zaal/zmex.s3o]]
script = [[zaal/zmex.cob]]

tech = [[tech2]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmex_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------