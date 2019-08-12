-- UNITDEF -- zespire1 --
--------------------------------------------------------------------------------

unitName = "zespire1"

--------------------------------------------------------------------------------
supplygranted = 10
energyMake = 5

humanName = "Basic Energy Spire"

objectName = "zaal/zespire1.s3o"
script = "zaal/zespire1.cob"

armortype = [[building]]
tech = [[tech1]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire1_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
