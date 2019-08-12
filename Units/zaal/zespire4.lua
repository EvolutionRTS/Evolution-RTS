-- UNITDEF -- zespire4 --
--------------------------------------------------------------------------------

unitName = "zespire4"

--------------------------------------------------------------------------------
supplygranted = 20
energyMake = 10

humanName = "Budding Energy Spire"

objectName = "zaal/zespire4.s3o"
script = "zaal/zespire4.bos"

armortype = [[building]]
tech = [[tech2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire4_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
