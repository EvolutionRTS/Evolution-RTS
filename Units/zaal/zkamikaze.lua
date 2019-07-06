-- UNITDEF -- zkamikaze --
--------------------------------------------------------------------------------

unitName = "zkamikaze"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zkamikaze.s3o"
script = "zaal/zkamikaze.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zkamikaze_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
