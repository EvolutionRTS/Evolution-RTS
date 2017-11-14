-- UNITDEF -- elacerator_up1 --
--------------------------------------------------------------------------------

unitName = "elacerator_up1"

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = [[Lacerator Mark II]]

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
