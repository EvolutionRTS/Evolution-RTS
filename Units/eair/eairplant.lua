-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

unitName = "eairplant"

--------------------------------------------------------------------------------

buildCostMetal = 60
maxDamage = buildCostMetal * 12.5

humanName = [[VTOL Factory]]

objectName = "eairplant3.s3o"
script = "eairplant3.cob"

airPlantBuildList = Shared.buildListAirPlant

VFS.Include("Units-Configs-Basedefs/basedefs/air/eairplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
