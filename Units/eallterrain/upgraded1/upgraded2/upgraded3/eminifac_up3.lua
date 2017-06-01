-- UNITDEF -- EMINIFAC --
--------------------------------------------------------------------------------

unitName = "eminifac_up3"

--------------------------------------------------------------------------------

buildCostMetal = 750
maxDamage = buildCostMetal * 12.5

humanName = [[All-Terrain Strider Factory Mark IV]]

objectName = "eallterrfac2.s3o"
script = "eallterrfac2.cob"

AllTerrainFactoryBuildList = Shared.buildListAllTerrainFactory_up3

VFS.Include("units-configs-basedefs/basedefs/allterrain/eminifac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
