-- UNITDEF -- f1landfac --
--------------------------------------------------------------------------------

unitName = "f1landfac"

--------------------------------------------------------------------------------

buildCostMetal = 60
maxDamage = buildCostMetal * 12.5

humanName = [[Land Factory]]

objectName = "eallterrfac2.s3o"
script = "eallterrfac2.cob"

AllTerrainFactoryBuildList = Shared.buildListf1landfac

VFS.Include("units-configs-basedefs/basedefs/allterrain/eminifac_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
