-- UNITDEF -- eallterrmed -- Basher --
--------------------------------------------------------------------------------

unitName = "eallterrmed_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Basher Mark IV]]

objectName = "eallterrmed2.s3o"
script = "eallterrmed.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[4]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrmed_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------