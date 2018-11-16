-- UNITDEF -- eallterrshield -- Widow --
--------------------------------------------------------------------------------

unitName = "eallterrshield_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Widow Mark II]]

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
