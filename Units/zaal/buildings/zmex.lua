-- UNITDEF -- ZMEX --
--------------------------------------------------------------------------------

unitName = [[zmex]]

--------------------------------------------------------------------------------

metalMultiplier = 1

energyUse = 0

buildCostMetal = 50

yardMap = [[oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo]]

primaryCEG = "custom:fusionreactionnuclear-1color"

humanName = [[Zaal Metal Extractor]]

objectName = [[zaal/zmex.s3o]]
script = [[zaal/zmex.cob]]

tech = [[tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmex_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------