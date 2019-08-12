-- UNITDEF -- zpyro --
--------------------------------------------------------------------------------

unitName = "zpyro"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Trike"

objectName = "zaal/zpyro.s3o"
script = "zaal/zpyro.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zpyro_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
