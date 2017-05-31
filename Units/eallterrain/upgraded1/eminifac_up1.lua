-- UNITDEF -- EMINIFAC --
--------------------------------------------------------------------------------

unitName = "eminifac_up1"

--------------------------------------------------------------------------------

buildCostMetal = 270
maxDamage = buildCostMetal * 12.5

humanName = [[All-Terrain Strider Factory]]

objectName = "eallterrfac2.s3o"
script = "eallterrfac2.cob"

AllTerrainFactoryBuildList = Shared.buildListAllTerrainFactory_up1

VFS.Include("units-configs-basedefs/basedefs/allterrain/eminifac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
