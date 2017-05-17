-- UNITDEF -- ERIOTTANK2_up1 --
--------------------------------------------------------------------------------

unitName = "eriottank2_up1"

--------------------------------------------------------------------------------
isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Spas Upgrade 1"

objectName = "eriottank3.s3o"
script = "eriottank3.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]


VFS.Include("units/ehover/basedefs/eriottank2_basedef.lua")

unitDef.weaponDefs = weaponDefs--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
