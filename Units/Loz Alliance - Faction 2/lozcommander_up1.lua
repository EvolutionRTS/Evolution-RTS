-- UNITDEF -- lozcommander_up1 --
--------------------------------------------------------------------------------

unitName = [[lozcommander_up1]]

--------------------------------------------------------------------------------

humanname = [[Loz Alliance Command Unit]]
buildpicture = [[lozcommander.png]]

armortype = [[light]]
supplygiven = [[0]]
techprovided = [[tech0, tech1, -overseer]]
techrequired = [[0 overseer]]

maxdamage = 5000
maxvelocity = 3
workertime = 2

movementclass = [[COMMANDERTANK4]]

objectname = [[lozcommandtank.s3o]]
script = [[lozcommandtank.cob]]

footprintx = 4
footprintz = 4

buildlist = Shared.buildListLoz

weapon1 = [[machinegun_up1]]

VFS.Include("units-configs-basedefs/basedefs/commander_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------