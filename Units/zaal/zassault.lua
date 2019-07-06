-- UNITDEF -- zassault --
--------------------------------------------------------------------------------

unitName = "zassault"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zassault.s3o"
script = "zaal/zassault.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zassault_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
