-- UNITDEF -- eallterranarchid -- Anarchid --
--------------------------------------------------------------------------------

unitName = "eallterranarchid"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Anarchid]]

objectName = "eallterranarchid.s3o"
script = "eallterranarchid.cob"

tech = [[tech3]]
armortype = [[armored]]
supply = [[12]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterranarchid_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------