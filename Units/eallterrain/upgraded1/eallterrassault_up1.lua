-- UNITDEF -- eallterrassault -- Anvil --
--------------------------------------------------------------------------------

unitName = "eallterrassault_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Anvil Mark II]]

objectName = "eallterrassault.s3o"
script = "eallterrassault.cob"

tech = [[tech1]]
armortype = [[armored]]
supply = [[8]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrassault_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------