-- UNITDEF -- zairscout --
--------------------------------------------------------------------------------

unitName = "zairscout"

--------------------------------------------------------------------------------

humanName = [[Sparrow]]

objectName = "zaal/zairscout.s3o"
script = "zaal/zairscout.cob"

armortype = [[airlight]]

tech = [[tech1]]

supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zairscout_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
