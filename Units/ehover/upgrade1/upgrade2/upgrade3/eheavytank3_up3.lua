-- UNITDEF -- EHEAVYTANK3_up3 --
--------------------------------------------------------------------------------

unitName = "eheavytank3_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "Crusher Upgrade 3"

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
