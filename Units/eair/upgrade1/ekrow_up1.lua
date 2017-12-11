-- UNITDEF -- EKROW_up1 --
--------------------------------------------------------------------------------

unitName = "ekrow_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Krow MK II]]

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
