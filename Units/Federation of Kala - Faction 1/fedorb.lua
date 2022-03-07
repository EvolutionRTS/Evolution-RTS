--------------------------------------------------------------------------------

unitName = [[fedorb]]

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = [[O.R.B.]]

objectName = [[eorb4.s3o]]
script = [[eorb3.cob]]

workerTime = 1
buildDistance = 350

tech = [[tech0]]
armortype = [[light]]

buildlist = Shared.fedOrb

VFS.Include("units-configs-basedefs/basedefs/eorb_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------