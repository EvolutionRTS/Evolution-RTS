-- UNITDEF -- ZSKIRMISHER --
--------------------------------------------------------------------------------

unitName = "zskirmisher"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Ravager"

objectName = "zaal/zskirmisher.s3o"
script = "zaal/zskirmisher.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[6]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zskirmisher_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
