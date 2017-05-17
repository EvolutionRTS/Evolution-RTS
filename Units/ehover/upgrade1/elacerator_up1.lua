-- UNITDEF -- elacerator_up1 --
--------------------------------------------------------------------------------

unitName                   = "elacerator_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Lacerator Upgrade 1"

objectName = "elacerator.s3o"
script = "elacerator.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[8]]

VFS.Include("units/ehover/basedefs/elacerator_basedef.lua")

unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
