-- UNITDEF -- eallterrshield -- Widow --
--------------------------------------------------------------------------------

unitName = "eallterrshield"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Widow]]

objectName = "eallterrshield.s3o"
script = "eallterrshield.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[5]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrshield_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------