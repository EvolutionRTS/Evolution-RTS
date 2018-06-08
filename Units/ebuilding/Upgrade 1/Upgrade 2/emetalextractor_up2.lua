-- UNITDEF -- EMETALEXTRACTOR_up2 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up2]]

--------------------------------------------------------------------------------

metalMultiplier = 1.66

buildCostMetal = 200
energyUse = 0

primaryCEG = "custom:fusionreactionnuclearpurple"

humanName = [[Metal Extractor Mk III]]

objectName = [[emetalextractor2.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech2]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------