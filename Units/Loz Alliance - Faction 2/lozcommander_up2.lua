-- UNITDEF -- lozcommander_up2 --
--------------------------------------------------------------------------------

unitName = [[lozcommander_up2]]

--------------------------------------------------------------------------------

humanname = [[Loz Alliance Command Unit]]
buildpicture = [[lozcommander.png]]

armortype = [[armored]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, tech2, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 10000
maxvelocity = 3
workertime = 3

movementclass = [[COMMANDERTANK4]]

objectname = [[lozcommandtank.s3o]]
script = [[lozcommandtank.cob]]

footprintx = 4
footprintz = 4

buildlist = Shared.buildListLoz

weapon1 = [[machinegun_up2]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------