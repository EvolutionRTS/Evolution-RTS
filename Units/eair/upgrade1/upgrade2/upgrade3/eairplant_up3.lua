-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

unitName = "eairplant_up3"

--------------------------------------------------------------------------------

buildCostMetal = 750
maxDamage = buildCostMetal * 12.5

humanName = [[VTOL Factory Upgrade 3]]

objectName = "eairplant3.s3o"
script = "eairplant3.cob"

airPlantBuildList = Shared.buildListAirPlant_up3

VFS.Include("Units-Configs-Basedefs/basedefs/air/eairplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
