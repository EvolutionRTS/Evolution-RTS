-- UNITDEF -- eallterrlight -- Recluse --
--------------------------------------------------------------------------------

unitName = "eallterrlight_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Recluse Mark IV]]

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