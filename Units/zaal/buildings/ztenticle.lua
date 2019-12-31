-- UNITDEF -- ztenticle --
--------------------------------------------------------------------------------

unitName = "ztenticle"

--------------------------------------------------------------------------------

buildDistance = 65000
buildCostMetal = 40

humanName = "Tenticle"

objectName = "zaal/ztenticle.s3o"
script = "zaal/ztenticle_lus.lua"

armortype = [[building]]

VFS.Include("units-configs-basedefs/basedefs/zaal/ztenticle_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
