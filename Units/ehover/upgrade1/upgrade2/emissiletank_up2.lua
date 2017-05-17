-- UNITDEF -- EMISSILETANK_up2 --
--------------------------------------------------------------------------------

unitName = "emissiletank_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "Droplet Upgrade 2"

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
