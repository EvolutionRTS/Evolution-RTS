-- UNITDEF -- EMINIFAC --
--------------------------------------------------------------------------------

unitName = "eminifac_up2"

--------------------------------------------------------------------------------

buildCostMetal = 30
maxDamage = buildCostMetal * 12.5

humanName = [[All-Terrain Strider Factory]]

objectName = "eallterrfac2.s3o"
script = "eallterrfac2.cob"

AllTerrainFactoryBuildList = Shared.buildListAllTerrainFactory_up2

VFS.Include("units-configs-basedefs/basedefs/allterrain/eminifac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
