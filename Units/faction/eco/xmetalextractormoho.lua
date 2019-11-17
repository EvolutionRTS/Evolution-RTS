-- UNITDEF -- XMETALEXTRACTORMOHO --
--------------------------------------------------------------------------------

unitName = [[xmetalextractormoho]]

--------------------------------------------------------------------------------

metalMultiplier = 2

buildCostMetal = 300
energyUse = 10

buildPic = "pattern/xmetalextractormoho.png"

humanName = [[Metal Extractor]]

objectName = [[faction/xmetalextractormoho.s3o]]
script = [[faction/xmetalextractor.cob]]

tech = [[tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/faction/xmetalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------