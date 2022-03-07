-- UNITDEF -- fedcommander_up2 --
--------------------------------------------------------------------------------

unitName = [[fedcommander_up2]]

--------------------------------------------------------------------------------

humanname = [[Federation of Kala Command Unit]]
buildpicture = [[ecommander.png]]

armortype = [[armored]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, tech2, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 10000
maxvelocity = 3
workertime = 3

movementclass = [[COMMANDERTANK4]]

objectname = [[ecommander4-battle.s3o]]
script = [[ecommander4-battle.cob]]

footprintx = 4
footprintz = 4

buildlist = Shared.buildListFed

weapon1 = [[machinegun_up2]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------