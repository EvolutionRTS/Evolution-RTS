-- UNITDEF -- zairbomber --
--------------------------------------------------------------------------------

unitName = "zairbomber"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Koyote]]

objectName = "zaal/zairbomber.s3o"
script = "zaal/zairbomber.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zairbomber_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
