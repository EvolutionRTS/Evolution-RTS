-- UNITDEF -- ELIGHTTANK3_up1 --
--------------------------------------------------------------------------------

unitName = "elighttank3_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Kite Upgrade 1"

objectName = "elighttank4.s3o"
script = "elighttank3_lus.lua"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units/ehover/basedefs/elighttank3_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
