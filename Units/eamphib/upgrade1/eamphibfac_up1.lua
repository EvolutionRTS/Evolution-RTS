-- UNITDEF -- EAMPHIBFAC_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibfac_up1"

--------------------------------------------------------------------------------

buildCostMetal = 270
maxDamage = buildCostMetal * 12.5

humanName = [[Amphibious Tank Factory Mark II]]

objectName = "eamphibfac2.s3o"
script = "eamphibfac2.cob"

amphibFactoryBuildList = Shared.buildListAmphibFactory_up1

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibfac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
