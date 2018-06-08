-- UNITDEF -- EMETALEXTRACTOR_up3 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up3]]

--------------------------------------------------------------------------------

metalMultiplier = 2

buildCostMetal = 300
energyUse = 0

primaryCEG = "custom:fusionreactionnucleargreen"

humanName = [[Metal Extractor Mk IV]]

objectName = [[emetalextractor2.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech3]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------