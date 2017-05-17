-- UNITDEF -- EBASEFACTORY_up1 --
--------------------------------------------------------------------------------

unitName                    = "ebasefactory_up1"

--------------------------------------------------------------------------------

buildCostMetal = 430
maxDamage = buildCostMetal * 12.5

humanName = "Hover Factory Upgrade 1"
objectName = "ehoverfactory.s3o"
script = "ehoverfac.cob"

hoverFactoryBuildList = Shared.buildListHoverFactory_up1

VFS.Include("units/ehover/basedefs/ebasefactory_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
