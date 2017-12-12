-- UNITDEF -- EKROW --
--------------------------------------------------------------------------------

unitName = "ekrow"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Krow]]

objectName = "ekrow.s3o"
script = "ekrow.cob"


techprovided = [[-1 endbringer]]
tech = [[tech3, 1 endbringer]]
armortype = [[armored]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
