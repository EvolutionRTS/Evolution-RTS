-- UNITDEF -- EKROW_up1 --
--------------------------------------------------------------------------------

unitName = "ekrow_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Krow MK II]]

objectName = "ekrow.s3o"
script = "ekrow.cob"


tech = [[tech3]]
armortype = [[airlight]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
