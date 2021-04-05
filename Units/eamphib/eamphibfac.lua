-- UNITDEF -- EAMPHIBFAC --
--------------------------------------------------------------------------------

unitName = "eamphibfac"

--------------------------------------------------------------------------------

buildCostMetal = 60
maxDamage = buildCostMetal * 12.5

humanName = [[Amphibious Tank Factory]]

objectName = "eamphibfac2.s3o"
script = "eamphibfac2.cob"

amphibFactoryBuildList = Shared.buildListAmphibFactory

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibfac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
