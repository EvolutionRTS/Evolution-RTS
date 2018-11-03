-- UNITDEF -- eallterrheavy -- Sledge --
--------------------------------------------------------------------------------

unitName = "eallterrheavy_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Sledge Mark III]]

objectName = "eallterrheavy2.s3o"
script = "eallterrheavy.cob"

tech = [[tech2]]
armortype = [[armored]]
supply = [[6]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrheavy_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
