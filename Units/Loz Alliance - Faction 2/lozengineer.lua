-- UNITDEF -- lozengineer --
--------------------------------------------------------------------------------

unitName = "lozengineer"

--------------------------------------------------------------------------------

buildCostMetal = 80
buildDistance = 350

maxDamage = 500

humanName = [[Architect]]

objectName = [[f2engineer.s3o]]
script = [[f2engineer_lus.lua]]

armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/Faction 2/f2engineer_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
