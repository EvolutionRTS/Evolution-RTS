-- UNITDEF -- elacerator_up2 --
--------------------------------------------------------------------------------

unitName = "elacerator_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "Lacerator Upgrade 2"

objectName = "elacerator.s3o"
script = "elacerator.cob"

tech						 = [[tech3]]
armortype					 = [[armored]]
supply					 = [[8]]

VFS.Include("units/ehover/basedefs/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
