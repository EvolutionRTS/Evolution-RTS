-- UNITDEF -- ZHATCH_UP1 --
--------------------------------------------------------------------------------

unitName = [[zhatch_up1]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 150

humanName = [[Zaal Lair]]

objectName = [[zaal/zfactory_up1.s3o]]
script = [[zaal/zfactory.cob]]

techprovided = [[tech2, tech1, tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })