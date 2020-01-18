-- UNITDEF -- ztumor --
--------------------------------------------------------------------------------

unitName = "ztumor"

--------------------------------------------------------------------------------

buildDistance = 1500

humanName = "Tumor"

objectName = "zaal/ztumor.s3o"
script = "zaal/ztumor_lus.lua"

armortype = [[building]]
--techprovided = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/zaal/ztumor_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
