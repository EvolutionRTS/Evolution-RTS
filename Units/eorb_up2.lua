--------------------------------------------------------------------------------

unitName = [[eorb_up2]]

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[O.R.B. MK III]]

objectName = [[eorb4.s3o]]
script = [[eorb3.cob]]

workerTime = 1.5
buildDistance = 700

tech = [[tech0]]
armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/eorb_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------