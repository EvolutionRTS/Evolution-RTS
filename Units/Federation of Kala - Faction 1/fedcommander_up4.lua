-- UNITDEF -- fedcommander_up4 --
--------------------------------------------------------------------------------

unitName = [[fedcommander_up4]]

--------------------------------------------------------------------------------

humanname = [[Federation of Kala BattleMech Command Unit]]
buildpicture = [[ecommander.png]]

armortype = [[armored]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, tech2, tech3, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 20000
maxvelocity = 3
workertime = 5

movementclass = [[COMMANDERTANK6]]

objectname = [[ecommander4-battle-large.s3o]]
script = [[ecommander4-battle.cob]]

footprintx = 6
footprintz = 6

buildlist = Shared.buildListFed

weapon1 = [[heavybeamweapon]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------