-- UNITDEF -- eallterrassault -- Anvil --
--------------------------------------------------------------------------------

unitName = "eallterrassault"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Anvil]]

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