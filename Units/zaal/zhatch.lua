-- UNITDEF -- ZHATCH --
--------------------------------------------------------------------------------

unitName = [[zhatch]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 30
energyUse = 0
energyMake = 0

supplygranted = 20

footprintX = 16
footprintZ = 16

yardMap = [[oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo]]

primaryCEG = "custom:fusionreactionnuclear-2color"

humanName = [[Zaal Hatchery]]

objectName = [[zaal/zhive.s3o]]
script = [[zaal/zhive.cob]]

techprovided = [[tech1, tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------