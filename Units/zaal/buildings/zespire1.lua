-- UNITDEF -- zespire1 --
--------------------------------------------------------------------------------

unitName = "zespire1"

--------------------------------------------------------------------------------
buildCostMetal = 50

supplygranted = 0
energyMake = 10

humanName = "Basic Energy Spire"

objectName = "zaal/zespire1.s3o"
script = "zaal/zespire1.cob"

armortype = [[building]]
tech = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire1_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
