-- UNITDEF -- EHEAVYTANK3_up2 --
--------------------------------------------------------------------------------

unitName = "eheavytank3_up2"

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[Crusher Mark III]]

objectName = "eheavytank4.s3o"
script = "eheavytank4_lus.lua"

tech = [[tech2]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/hover/eheavytank3_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
