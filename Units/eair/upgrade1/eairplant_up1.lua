-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

unitName = "eairplant_up1"

--------------------------------------------------------------------------------

buildCostMetal = 270
maxDamage = buildCostMetal * 12.5

humanName = [[Drone Factory Mark II]]

objectName = "eairplant3.s3o"
script = "eairplant3.cob"

airPlantBuildList = Shared.buildListAirPlant_up1

VFS.Include("Units-Configs-Basedefs/basedefs/air/eairplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
