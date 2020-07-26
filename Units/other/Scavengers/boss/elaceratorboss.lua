-- UNITDEF -- elacerator --
--------------------------------------------------------------------------------

unitName = "elaceratorboss"

--------------------------------------------------------------------------------

isUpgraded	= [[boss]]

humanName = "Mega Lacerator"

objectName = "scavs/boss/elaceratorboss.s3o"
script = "elacerator.cob"

tech = [[tech3]]
armortype = [[armored]]
--supply  = [[25]]

VFS.Include("units-configs-basedefs/basedefs/hover/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
