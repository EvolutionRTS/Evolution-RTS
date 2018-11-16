-- UNITDEF -- elacerator_up1 --
--------------------------------------------------------------------------------

unitName = "elacerator_up1"

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = [[Lacerator Mark II]]

objectName = "elacerator.s3o"
script = "elacerator.cob"

tech = [[tech3]]
armortype = [[armored]]
--supply = [[25]]

VFS.Include("units-configs-basedefs/basedefs/hover/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
