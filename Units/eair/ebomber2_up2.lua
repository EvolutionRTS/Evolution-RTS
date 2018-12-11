-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

unitName = "ebomber_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Kamper Mark III]]

objectName = "ebomber2-small.s3o"
script = "ebomber2.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[5]]

VFS.Include("Units-Configs-Basedefs/basedefs/air/ebomber_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
