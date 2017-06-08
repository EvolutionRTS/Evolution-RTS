-- UNITDEF -- EHBOTFAC_up2 --
--------------------------------------------------------------------------------

unitName = "ehbotfac_up2"

--------------------------------------------------------------------------------

buildCostMetal = 270
maxDamage = buildCostMetal * 12.5

humanName = [[H-Bot Factory MK III]]

objectName = "ehbotfac.s3o"
script = "ehbotfac.cob"

hbotFactoryBuildList = Shared.buildListHbotFactory_up2

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotfac_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------