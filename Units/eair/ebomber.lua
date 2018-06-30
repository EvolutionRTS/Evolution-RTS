-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

unitName = "ebomber"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Kamper]]

objectName = "ebomber2.s3o"
script = "ebomber2.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[12]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ebomber_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
