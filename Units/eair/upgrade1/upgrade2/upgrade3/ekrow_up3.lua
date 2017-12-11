-- UNITDEF -- EKROW_up3 --
--------------------------------------------------------------------------------

unitName = "ekrow_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Krow MK IV]]

objectName = "ekrow.s3o"
script = "ekrow.cob"


techprovided = [[-1 endbringer]]
tech = [[tech3, 1 endbringer]]
armortype = [[light]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
