-- UNITDEF -- EMETALEXTRACTOR_up3 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up3]]

--------------------------------------------------------------------------------

metalMultiplier = 8

buildCostMetal = 600
energyUse = 50

primaryCEG = "custom:fusionreactionnuclear-4color"

humanName = [[Metal Extractor Mk IV]]

objectName = [[emetalextractor2_up3.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech3]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------