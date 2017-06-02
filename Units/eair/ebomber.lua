-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

unitName = "ebomber"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Kamper]]

objectName = "ebomber2.s3o"
script = "ebomber2.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[5]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ebomber_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
