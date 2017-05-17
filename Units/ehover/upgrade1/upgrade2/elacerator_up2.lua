-- UNITDEF -- elacerator_up2 --
--------------------------------------------------------------------------------

unitName = "elacerator_up2"

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = "Lacerator Upgrade 2"

objectName = "elacerator.s3o"
script = "elacerator.cob"

tech						 = [[tech3]]
armortype					 = [[armored]]
supply					 = [[8]]

VFS.Include("units-configs-basedefs/basedefs/hover/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
