-- UNITDEF -- EKROW --
--------------------------------------------------------------------------------

unitName = "ekrow"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Krow]]

objectName = "ekrow.s3o"
script = "ekrow.cob"


tech = [[tech3]]
armortype = [[armored]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
