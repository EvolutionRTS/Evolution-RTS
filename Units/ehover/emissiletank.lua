-- UNITDEF -- EMISSILETANK --
--------------------------------------------------------------------------------

unitName = "emissiletank"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Droplet"

objectName = "emissiletank2.s3o"
script = "emissiletank2.cob"

tech = [[tech2]]
armortype	= [[light]]
supply = [[14]]

VFS.Include("units/ehover/basedefs/emissiletank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
