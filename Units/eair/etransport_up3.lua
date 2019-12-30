-- UNITDEF -- ETRANSPORT --
--------------------------------------------------------------------------------

unitName = "etransport_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Kharter Mark IV]]

objectName = "etransport2-small.s3o"
script = "etransport2.cob"


--tech = [[tech1]]
armortype = [[airarmored]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/air/etransport_basedef.lua")

-- unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
