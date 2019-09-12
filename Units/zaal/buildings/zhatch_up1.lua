-- UNITDEF -- ZLAIR --
--------------------------------------------------------------------------------

unitName = [[zhatch_up1]]

--------------------------------------------------------------------------------

builder = true

metalMultiplier = 1.5
buildSpeedModifier = 1.5

buildCostMetal = 400
energyUse = 0
energyMake = 0

metalStorage = 0
energyStorage = 0

supplygranted = 0

footprintX = 8
footprintZ = 8

yardMap = [[oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo]]

primaryCEG = "custom:fusionreactionnuclear-3color"

humanName = [[Zaal Lair]]

objectName = [[zaal/zhive.s3o]]
script = [[zaal/zhive.cob]]

techprovided = [[tech2, tech1, tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------