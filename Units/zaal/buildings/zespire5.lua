-- UNITDEF -- zespire5 --
--------------------------------------------------------------------------------

unitName = "zespire5"

--------------------------------------------------------------------------------
supplygranted = 0
energyMake = 20

humanName = "Mature Energy Spire"

objectName = "zaal/zespire5.s3o"
script = "zaal/zespire5.cob"

armortype = [[building]]
tech = [[tech3]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zespire5_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
