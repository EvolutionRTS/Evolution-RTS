-- UNITDEF -- EMISSILETANK_up3 --
--------------------------------------------------------------------------------

unitName                   = "emissiletank_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Droplet Upgrade 3"

objectName = "emissiletank2.s3o"
script = "emissiletank2.cob"
tech = [[tech2]]
armortype	= [[light]]
supply = [[14]]

VFS.Include("units/ehover/basedefs/emissiletank_basedef.lua")

unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
