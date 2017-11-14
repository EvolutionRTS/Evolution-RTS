-- UNITDEF -- eallterranarchid -- Anarchid --
--------------------------------------------------------------------------------

unitName = "eallterranarchid_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Anarchid Mark II]]

objectName = "eallterranarchid.s3o"
script = "eallterranarchid.cob"

techprovided = [[-1 endbringer]]
tech = [[tech3, 1 endbringer]]
armortype = [[armored]]
--supply = [[35]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterranarchid_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
