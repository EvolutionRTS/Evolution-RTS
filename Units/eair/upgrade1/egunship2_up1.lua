-- UNITDEF -- EGUNSHIP --
--------------------------------------------------------------------------------

unitName = "egunship2_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Wildkat Mark II]]

objectName = "egunship3.s3o"
script = "egunship3.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[4]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/egunship2_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
