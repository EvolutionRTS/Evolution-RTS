-- UNITDEF -- ZLAIR --
--------------------------------------------------------------------------------

unitName = [[zlair]]

--------------------------------------------------------------------------------

metalMultiplier = 2

buildCostMetal = 150
energyUse = 0
energyMake = 10

supplygranted = 40

footprintX = 16
footprintZ = 16

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