--------------------------------------------------------------------------------

unitName = [[eorb_up3]]

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[O.R.B. MK IV]]

objectName = [[eorb4.s3o]]
script = [[eorb3.cob]]

workerTime = 2
buildDistance = 800

tech = [[tech0]]
armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/eorb_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------