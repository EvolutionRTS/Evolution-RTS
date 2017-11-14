-- UNITDEF -- EAMPHIBMEDTANK_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibmedtank_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Razor Mark II]]

objectName = "eamphibmedtank2.s3o"
script = "eamphibmedtank_lus.lua"

tech = [[tech2]]
armortype = [[light]]
supply = [[4]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibmedtank_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
