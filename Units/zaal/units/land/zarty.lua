-- UNITDEF -- zarty --
--------------------------------------------------------------------------------

unitName = "zarty"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Lurker"

objectName = "zaal/zarty.s3o"
script = "zaal/zarty.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zarty_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
