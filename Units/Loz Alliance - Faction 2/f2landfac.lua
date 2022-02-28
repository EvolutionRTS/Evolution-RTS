-- UNITDEF -- f2landfac --
--------------------------------------------------------------------------------

unitName = "f2landfac"

--------------------------------------------------------------------------------

buildCostMetal = 60
maxDamage = buildCostMetal * 12.5

humanName = [[Land Factory]]

objectName = "ehoverfactory.s3o"
script = "ehoverfac.cob"

hoverFactoryBuildList = Shared.buildListf2landfac

VFS.Include("units-configs-basedefs/basedefs/hover/ebasefactory_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
