-- UNITDEF -- ZSKIRMISHER --
--------------------------------------------------------------------------------

unitName = "zskirmisher"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Ravager"

objectName = "zaal/zskirmisher.s3o"
script = "zaal/zskirmisher.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zskirmisher_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
