-- UNITDEF -- eallterrlight -- Recluse --
--------------------------------------------------------------------------------

unitName = "eallterrlight_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Recluse Mark III]]

objectName = "eallterrlight2.s3o"
script = "eallterrlight.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[2]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrlight_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
