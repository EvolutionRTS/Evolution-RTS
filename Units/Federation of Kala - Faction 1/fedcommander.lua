-- UNITDEF -- fedcommander --
--------------------------------------------------------------------------------

unitName = [[fedcommander]]

--------------------------------------------------------------------------------

humanname = [[Federation of Kala Command Unit]]
buildpicture = [[ecommander.png]]

armortype = [[light]]
supplygiven = [[0]]
techprovided = [[tech0, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 2000
maxvelocity = 3
workertime = 1

movementclass = [[COMMANDERTANK4]]

objectname = [[ecommander4-battle.s3o]]
script = [[ecommander4-battle.cob]]

footprintx = 4
footprintz = 4

buildlist = Shared.buildListFed

weapon1 = [[machinegun]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------