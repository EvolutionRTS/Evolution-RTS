-- UNITDEF -- EMISSILETANK --
--------------------------------------------------------------------------------

unitName = "emissiletank"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Droplet"

objectName = "emissiletank2.s3o"
script = "emissiletank2.cob"

tech = [[tech2]]
armortype	= [[light]]
supply = [[14]]

VFS.Include("units-configs-basedefs/basedefs/hover/emissiletank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
