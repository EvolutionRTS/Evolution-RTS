-- UNITDEF -- EMETALEXTRACTOR_up3 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up3]]

--------------------------------------------------------------------------------

metalMultiplier = tonumber(Spring.GetModOptions().mexincomemultiplier) or 50 -- Make sure to change this default number in the luamex config options, mex unitdef, and in modoptions
metalMultiplier = metalMultiplier * 4
metalMultiplier = metalMultiplier * 0.01

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