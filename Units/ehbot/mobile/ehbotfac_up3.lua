-- UNITDEF -- EHBOTFAC_up3 --
--------------------------------------------------------------------------------

unitName = "ehbotfac_up3"

--------------------------------------------------------------------------------

buildCostMetal = 750
maxDamage = buildCostMetal * 12.5

humanName = [[H-Bot Factory MK IV]]

objectName = "ehbotfac.s3o"
script = "ehbotfac.cob"

hbotFactoryBuildList = Shared.buildListHbotFactory_up3

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotfac_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------