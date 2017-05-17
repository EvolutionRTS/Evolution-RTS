-- UNITDEF -- EHEAVYTANK3_up2 --
--------------------------------------------------------------------------------

unitName = "eheavytank3_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "Crusher Upgrade 2"

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
