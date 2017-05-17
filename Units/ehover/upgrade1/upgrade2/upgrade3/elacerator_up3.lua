-- UNITDEF -- elacerator_up3 --
--------------------------------------------------------------------------------

unitName = "elacerator_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "Lacerator Upgrade 3"

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
