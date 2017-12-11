-- UNITDEF -- EKROW_up2 --
--------------------------------------------------------------------------------

unitName = "ekrow_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Krow MK III]]

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
