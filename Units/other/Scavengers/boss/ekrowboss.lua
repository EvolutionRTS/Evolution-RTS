-- UNITDEF -- EKROW --
--------------------------------------------------------------------------------

unitName = "ekrowboss"

--------------------------------------------------------------------------------

isUpgraded = [[boss]]

humanName = [[Mega Krow]]

objectName = "scavs/boss/ekrowboss.s3o"
script = "ekrow.cob"


tech = [[tech3]]
armortype = [[airarmored]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ekrow_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
