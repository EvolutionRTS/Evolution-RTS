-- UNITDEF -- XMETALEXTRACTOR --
--------------------------------------------------------------------------------

unitName = [[xmetalextractor]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 20
energyUse = 0

buildPic = "pattern/xmetalextractor.png"

humanName = [[Metal Extractor]]

objectName = [[faction/xmetalextractor.s3o]]
script = [[faction/xmetalextractor.cob]]

tech = [[tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/faction/xmetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------