-- UNITDEF -- zespire5 --
--------------------------------------------------------------------------------

unitName = "zespire5"

--------------------------------------------------------------------------------
buildCostMetal = 400

supplygranted = 0
energyMake = 40

humanName = "Mature Energy Spire"

objectName = "zaal/zespire5.s3o"
script = "zaal/zespire1.cob"

armortype = [[building]]
tech = [[tech3]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire1_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
