-- UNITDEF -- ztiberium --
--------------------------------------------------------------------------------

unitName = "ztiberium"

--------------------------------------------------------------------------------
supplygranted = 25
storage = 50

humanName = "Tiberium Supply/Storage"

objectName = "zaal/ztiberium_small.s3o"
script = "zaal/ztiberium.cob"

armortype = [[building]]
tech = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/zaal/ztiberium_basedef.lua")
	
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
