-- UNITDEF -- ZHATCH --
--------------------------------------------------------------------------------

unitName = [[zhatch]]

--------------------------------------------------------------------------------

metalMultiplier = 1

buildCostMetal = 50

humanName = [[Zaal Hatchery]]

objectName = [[zaal/zfactory_up2.s3o]]
script = [[zaal/zfactory.cob]]

--techprovided = [[tech1, tech0]]
armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zhive_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------