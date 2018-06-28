-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

unitName = "eairplant"

--------------------------------------------------------------------------------

buildCostMetal = 30
maxDamage = buildCostMetal * 12.5

humanName = [[Drone Factory]]

objectName = "eairplant3.s3o"
script = "eairplant3.cob"

airPlantBuildList = Shared.buildListAirPlant

VFS.Include("Units-Configs-Basedefs/basedefs/air/eairplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
