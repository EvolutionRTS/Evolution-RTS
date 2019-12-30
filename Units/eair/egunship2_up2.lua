-- UNITDEF -- EGUNSHIP --
--------------------------------------------------------------------------------

unitName = "egunship2_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Wildkat Mark III]]

objectName = "egunship3-small.s3o"
script = "egunship3.cob"


tech = [[tech2]]
armortype = [[airlight]]
supply = [[4]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/egunship2_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
