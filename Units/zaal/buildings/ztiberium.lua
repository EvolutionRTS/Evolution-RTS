-- UNITDEF -- ztiberium --
--------------------------------------------------------------------------------

unitName = "ztiberium"

--------------------------------------------------------------------------------
supplygranted = 10
storage = 25

humanName = "Tiberium Supply/Storage"

objectName = "zaal/ztiberium.s3o"
script = "zaal/ztiberium.cob"

armortype = [[building]]
tech = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/zaal/ztiberium_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
