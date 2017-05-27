-- UNITDEF -- eallterrshield -- Widow --
--------------------------------------------------------------------------------

unitName = "eallterrshield_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

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