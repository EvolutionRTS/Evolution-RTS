-- UNITDEF -- EKROW_up2 --
--------------------------------------------------------------------------------

unitName = "ekrow_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Krow MK III]]

objectName = "ekrow.s3o"
script = "ekrow.cob"


tech = [[tech3]]
armortype = [[airlight]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
