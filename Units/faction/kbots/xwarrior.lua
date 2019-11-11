-- UNITDEF -- xwarrior --
--------------------------------------------------------------------------------

unitName = "xwarrior"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Warrior]]

objectName = "faction/xwarrior.s3o"
script = "faction/xwarrior.cob"

tech = [[tech1]]
armortype = [[armored]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xwarrior_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
