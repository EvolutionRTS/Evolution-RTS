-- UNITDEF -- zmedswarm --
--------------------------------------------------------------------------------

unitName = "zmedswarm"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zmedswarm.s3o"
script = "zaal/zmedswarm.cob"

tech = [[6 hive]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmedswarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
