-- UNITDEF -- eallterranarchid -- Anarchid --
--------------------------------------------------------------------------------

unitName = "eallterranarchid_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Anarchid Mark III]]

objectName = "eallterranarchid.s3o"
script = "eallterranarchid.cob"

tech = [[tech3]]
armortype = [[armored]]
---supply = [[35]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterranarchid_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
