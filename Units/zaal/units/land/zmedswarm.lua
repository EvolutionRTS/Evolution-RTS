-- UNITDEF -- zmedswarm --
--------------------------------------------------------------------------------

unitName = "zmedswarm"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Roach"

objectName = "zaal/zmedswarm.s3o"
script = "zaal/zmedswarm.cob"

tech = [[tech2]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zmedswarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
