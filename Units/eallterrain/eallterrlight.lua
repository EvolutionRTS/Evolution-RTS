-- UNITDEF -- eallterrlight -- Recluse --
--------------------------------------------------------------------------------

unitName = "eallterrlight"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Recluse]]

objectName = "eallterrlight2.s3o"
script = "eallterrlight.cob"

tech = [[tech0]]
armortype = [[light]]
supply = [[2]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrlight_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------