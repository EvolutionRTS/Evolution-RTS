-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

unitName = "eairplant_up2"

--------------------------------------------------------------------------------

buildCostMetal = 510
maxDamage = buildCostMetal * 12.5

humanName = [[VTOL Factory Mark II]]

objectName = "eairplant3.s3o"
script = "eairplant3.cob"

airPlantBuildList = Shared.buildListAirPlant_up2

VFS.Include("Units-Configs-Basedefs/basedefs/air/eairplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
