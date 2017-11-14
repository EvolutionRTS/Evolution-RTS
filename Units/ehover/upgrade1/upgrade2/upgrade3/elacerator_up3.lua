-- UNITDEF -- elacerator_up3 --
--------------------------------------------------------------------------------

unitName = "elacerator_up3"

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[Lacerator Mark IV]]

objectName = "elacerator.s3o"
script = "elacerator.cob"

techprovided = [[-1 endbringer]]
tech = [[tech3, 1 endbringer]]
armortype = [[armored]]
--supply = [[25]]

VFS.Include("units-configs-basedefs/basedefs/hover/elacerator_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
