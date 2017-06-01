-- UNITDEF -- EBASEFACTORY_up2 --
--------------------------------------------------------------------------------

unitName                    = "ebasefactory_up2"

--------------------------------------------------------------------------------

buildCostMetal = 510
maxDamage = buildCostMetal * 12.5

humanName = [[Hover Factory Mark III]]
objectName = "ehoverfactory.s3o"
script = "ehoverfac.cob"

hoverFactoryBuildList = Shared.buildListHoverFactory_up2

VFS.Include("units-configs-basedefs/basedefs/hover/ebasefactory_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
