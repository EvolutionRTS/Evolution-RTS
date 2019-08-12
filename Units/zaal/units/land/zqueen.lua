-- UNITDEF -- zqueen --
--------------------------------------------------------------------------------

unitName = "zqueen"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Queen"

objectName = "zaal/zqueen.s3o"
script = "zaal/zqueen.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zqueen_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
