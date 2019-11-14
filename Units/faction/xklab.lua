-- UNITDEF -- XKLAB --
--------------------------------------------------------------------------------

unitName = "xklab"

--------------------------------------------------------------------------------

buildCostMetal = 30
maxDamage = buildCostMetal * 12.5

humanName = "K-Bot Lab"
objectName = "faction/xklab.s3o"
script = "faction/xklab.cob"

hoverFactoryBuildList = Shared.buildListXKLab

VFS.Include("units-configs-basedefs/basedefs/faction/xklab_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
