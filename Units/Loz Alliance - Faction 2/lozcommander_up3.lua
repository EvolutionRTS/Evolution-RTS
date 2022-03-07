-- UNITDEF -- lozcommander_up3 --
--------------------------------------------------------------------------------

unitName = [[lozcommander_up3]]

--------------------------------------------------------------------------------

humanname = [[Loz Alliance Command Unit]]
buildpicture = [[lozcommander.png]]

armortype = [[armored]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, tech2, tech3, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 15000
maxvelocity = 3
workertime = 4

movementclass = [[COMMANDERTANK4]]

objectname = [[lozcommandtank.s3o]]
script = [[lozcommandtank.cob]]

footprintx = 4
footprintz = 4

buildlist = Shared.buildListLoz

weapon1 = [[machinegun_up3]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------