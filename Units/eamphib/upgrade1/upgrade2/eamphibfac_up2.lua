-- UNITDEF -- EAMPHIBFAC_up2 --
--------------------------------------------------------------------------------

unitName = "eamphibfac_up2"

--------------------------------------------------------------------------------

buildCostMetal = 510
maxDamage = buildCostMetal * 12.5

humanName = [[Amphibious Tank Factory Mark III]]

objectName = "eamphibfac2.s3o"
script = "eamphibfac2.cob"

amphibFactoryBuildList = Shared.buildListAmphibFactory_up2

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibfac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
