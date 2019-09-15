-- UNITDEF -- zespire4 --
--------------------------------------------------------------------------------

unitName = "zespire4"

--------------------------------------------------------------------------------
buildCostMetal = 200

supplygranted = 0
energyMake = 20

humanName = "Budding Energy Spire"

objectName = "zaal/zespire4.s3o"
script = "zaal/zespire1.cob"

armortype = [[building]]
tech = [[tech2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire1_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
