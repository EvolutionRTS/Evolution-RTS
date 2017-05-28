-- UNITDEF -- eallterrmed -- Basher --
--------------------------------------------------------------------------------

unitName = "eallterrmed"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Basher]]

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