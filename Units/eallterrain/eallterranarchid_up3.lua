-- UNITDEF -- eallterranarchid -- Anarchid --
--------------------------------------------------------------------------------

unitName = "eallterranarchid_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Anarchid Mark IV]]

objectName = "eallterranarchid.s3o"
script = "eallterranarchid.cob"

tech = [[tech3]]
armortype = [[armored]]
--supply = [[35]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterranarchid_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------