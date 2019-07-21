-- UNITDEF -- ZHATCH --
--------------------------------------------------------------------------------

unitName = [[zhatch]]

--------------------------------------------------------------------------------

builder = false

metalMultiplier = 1

buildCostMetal = 30
energyUse = 0
energyMake = 5

metalStorage = 100
energyStorage = 100

supplygranted = 20

footprintX = 8
footprintZ = 8


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