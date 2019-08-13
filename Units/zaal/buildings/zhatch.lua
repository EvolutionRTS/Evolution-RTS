-- UNITDEF -- ZHATCH --
--------------------------------------------------------------------------------

unitName = [[zhatch]]

--------------------------------------------------------------------------------

builder = true

buildSpeedModifier = 1

metalMultiplier = 1

buildCostMetal = 90
energyUse = 0
energyMake = 0

metalStorage = 50
energyStorage = 50

supplygranted = 0

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