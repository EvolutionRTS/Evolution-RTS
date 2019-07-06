-- UNITDEF -- zairscout --
--------------------------------------------------------------------------------

unitName = "zairscout"

--------------------------------------------------------------------------------

humanName = [[Sparrow]]

objectName = "zaal/zairscout.s3o"
script = "zaal/zairscout.cob"

armortype = [[light]]

tech = [[tech0]]

supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zairscout_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
