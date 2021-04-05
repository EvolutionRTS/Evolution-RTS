-- UNITDEF -- EHBOTFAC --
--------------------------------------------------------------------------------

unitName = "ehbotfac"

--------------------------------------------------------------------------------

buildCostMetal = 60
maxDamage = buildCostMetal * 12.5

humanName = [[H-Bot Factory]]

objectName = "ehbotfac.s3o"
script = "ehbotfac.cob"

hbotFactoryBuildList = Shared.buildListHbotFactory

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotfac_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------