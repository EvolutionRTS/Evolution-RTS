-- UNITDEF -- eallterranarchid -- Anarchid --
--------------------------------------------------------------------------------

unitName = "eallterranarchidboss"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Mega Anarchid]]

objectName = "scavs/boss/eallterranarchidboss.s3o"
script = "eallterranarchid.cob"

tech = [[tech3]]
armortype = [[armored]]
--supply = [[35]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterranarchid_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------