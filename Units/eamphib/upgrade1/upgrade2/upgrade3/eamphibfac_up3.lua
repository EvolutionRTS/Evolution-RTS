-- UNITDEF -- EAMPHIBFAC_up3 --
--------------------------------------------------------------------------------

unitName = "eamphibfac_up3"

--------------------------------------------------------------------------------

buildCostMetal = 750
maxDamage = buildCostMetal * 12.5

humanName = [[Amphibious Tank Factory Upgrade 3]]

objectName = "eamphibfac2.s3o"
script = "eamphibfac2.cob"

amphibFactoryBuildList = Shared.buildListAmphibFactory_up3

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibfac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
