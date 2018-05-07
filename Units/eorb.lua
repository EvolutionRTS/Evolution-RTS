--------------------------------------------------------------------------------

unitName = [[eorb]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[O.R.B. MK I]]

objectName = [[eorb4.s3o]]
script = [[eorb3.cob]]

workerTime = 1
buildDistance = 500

tech = [[tech0]]
armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/eorb_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------