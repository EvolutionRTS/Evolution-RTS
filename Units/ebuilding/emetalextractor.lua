-- UNITDEF -- EMETALEXTRACTOR --
--------------------------------------------------------------------------------

unitName = [[emetalextractor]]

--------------------------------------------------------------------------------

metalMultiplier = tonumber(Spring.GetModOptions().mexincomemultiplier) or 100 -- Make sure to change this default number in the luamex config options, mex unitdef, and in modoptions
metalMultiplier = metalMultiplier * 1
metalMultiplier = metalMultiplier * 0.01

buildCostMetal = 20
energyUse = 0

primaryCEG = "custom:fusionreactionnuclearorange"

humanName = [[Metal Extractor]]

objectName = [[emetalextractor2.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------