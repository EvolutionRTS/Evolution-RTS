-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

unitName = "ebomber_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Kamper v2.0]]

objectName = "ebomber2.s3o"
script = "ebomber2.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[5]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ebomber_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
