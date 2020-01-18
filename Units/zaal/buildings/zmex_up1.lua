-- UNITDEF -- ZMEX_UP1 --
--------------------------------------------------------------------------------

unitName = [[zmex_up1]]

--------------------------------------------------------------------------------

metalMultiplier = 1.33

energyUse = 2

buildCostMetal = 100

primaryCEG = "custom:fusionreactionnuclear-2color"

humanName = [[Zaal Metal Extractor Mk II]]

objectName = [[zaal/zmex.s3o]]
script = [[zaal/zmex.cob]]

tech = [[tech1]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmex_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------