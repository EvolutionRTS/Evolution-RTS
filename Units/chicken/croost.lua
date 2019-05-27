-- UNITDEF -- CROOST --
--------------------------------------------------------------------------------

unitName = [[croost]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 50
energyUse = 0

primaryCEG = "custom:fusionreactionnuclear-1color"

humanName = [[Chicken Roost]]

objectName = [[ChickenDefenseModels/roost.s3o]]
script = [[chickens/croost_lus.lua]]

tech = [[tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/chickens/croost_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------