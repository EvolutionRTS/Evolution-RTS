-- UNITDEF -- elacerator_up2 --
--------------------------------------------------------------------------------

unitName = "elacerator_up2"

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[Lacerator Mark III]]

objectName = "elacerator.s3o"
script = "elacerator.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[25]]

VFS.Include("units-configs-basedefs/basedefs/hover/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
