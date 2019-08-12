-- UNITDEF -- zarm --
--------------------------------------------------------------------------------

unitName = "zarm"

--------------------------------------------------------------------------------

buildDistance = 65000

humanName = "Arm"

objectName = "zaal/zarm.s3o"
script = "zaal/zarm_lus.lua"

armortype = [[building]]
techprovided = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zarm_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
