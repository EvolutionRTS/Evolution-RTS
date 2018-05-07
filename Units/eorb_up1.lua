--------------------------------------------------------------------------------

unitName = [[eorb_up1]]

--------------------------------------------------------------------------------

isUpgraded	= [[1]]

humanName = [[O.R.B. MK II]]

objectName = [[eorb4.s3o]]
script = [[eorb3.cob]]

workerTime = 1.33
buildDistance = 600

tech = [[tech0]]
armortype = [[light]]

VFS.Include("units-configs-basedefs/basedefs/eorb_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------