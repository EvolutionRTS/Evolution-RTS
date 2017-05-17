-- UNITDEF -- EHEAVYTANK3 --
--------------------------------------------------------------------------------

unitName = "eheavytank3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Crusher"

objectName = "eheavytank4.s3o"
script = "eheavytank4_lus.lua"

tech = [[tech2]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("units/ehover/basedefs/eheavytank3_basedef.lua")
	
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
