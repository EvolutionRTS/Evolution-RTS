-- UNITDEF -- elacerator --
--------------------------------------------------------------------------------

unitName = "elacerator"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Lacerator"

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
