-- UNITDEF -- EHEAVYTANK3_up1 --
--------------------------------------------------------------------------------

unitName = "eheavytank3_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Crusher Upgrade 1"

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
