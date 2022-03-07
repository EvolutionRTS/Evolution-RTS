-- UNITDEF -- lozcommander_up4 --
--------------------------------------------------------------------------------

unitName = [[lozcommander_up4]]

--------------------------------------------------------------------------------

humanname = [[Loz Alliance BattleMech Command Unit]]
buildpicture = [[lozcommander.png]]

armortype = [[armored]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, tech2, tech3, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 20000
maxvelocity = 3
workertime = 5

movementclass = [[COMMANDERTANK6]]

objectname = [[lozcommandtank-battle.s3o]]
script = [[lozcommandtank.cob]]

footprintx = 6
footprintz = 6

buildlist = Shared.buildListLoz

weapon1 = [[heavybeamweapon]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------