-- UNITDEF -- EMETALEXTRACTOR_up2 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up2]]

--------------------------------------------------------------------------------

metalMultiplier = 4

buildCostMetal = 300
energyUse = 5

primaryCEG = "custom:fusionreactionnuclear-3color"

humanName = [[Metal Extractor Mk III]]

objectName = [[emetalextractor2_up2.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech2]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------