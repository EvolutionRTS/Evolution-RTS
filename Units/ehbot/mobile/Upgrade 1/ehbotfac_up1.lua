-- UNITDEF -- EHBOTFAC_up1 --
--------------------------------------------------------------------------------

unitName = "ehbotfac_up1"

--------------------------------------------------------------------------------

buildCostMetal = 270
maxDamage = buildCostMetal * 12.5

humanName = [[H-Bot Factory MK II]]

objectName = "ehbotfac.s3o"
script = "ehbotfac.cob"

hbotFactoryBuildList = Shared.buildListHbotFactory_up1

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotfac_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------