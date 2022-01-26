-- UNITDEF -- EMETALEXTRACTOR_up1 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up1]]

--------------------------------------------------------------------------------

metalMultiplier = 2

buildCostMetal = 150
energyUse = 2

primaryCEG = "custom:fusionreactionnuclear-2color"

humanName = [[Metal Extractor Mk II]]

objectName = [[emetalextractor2_up1.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech1]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------