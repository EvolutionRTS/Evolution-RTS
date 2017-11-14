-- UNITDEF -- EMETALEXTRACTOR_up1 --
--------------------------------------------------------------------------------

unitName = [[emetalextractor_up1]]

--------------------------------------------------------------------------------

metalMultiplier = tonumber(Spring.GetModOptions().mexincomemultiplier) or 50 -- Make sure to change this default number in the luamex config options, mex unitdef, and in modoptions
metalMultiplier = metalMultiplier * 2.5
metalMultiplier = metalMultiplier * 0.01

buildCostMetal = 300
energyUse = 0

humanName = [[Metal Extractor Mk II]]

objectName = [[emetalextractor2.s3o]]
script = [[emetalextractor.cob]]

tech = [[tech2]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/buildings/emetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------