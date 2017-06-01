-- UNITDEF -- EAMPHIBMEDTANK_up2 --
--------------------------------------------------------------------------------

unitName = "eamphibmedtank_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Razor Mark II]]

objectName = "eamphibmedtank2.s3o"
script = "eamphibmedtank_lus.lua"

tech = [[tech1]]
armortype = [[light]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibmedtank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
