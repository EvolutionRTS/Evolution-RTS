-- UNITDEF -- EBASEFACTORY_up3 --
--------------------------------------------------------------------------------

unitName                    = "ebasefactory_up3"

--------------------------------------------------------------------------------

buildCostMetal = 750
maxDamage = buildCostMetal * 12.5

humanName = "Hover Factory Mark III"
objectName = "ehoverfactory.s3o"
script = "ehoverfac.cob"

hoverFactoryBuildList = Shared.buildListHoverFactory_up3

VFS.Include("units-configs-basedefs/basedefs/hover/ebasefactory_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
