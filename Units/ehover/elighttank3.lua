-- UNITDEF -- ELIGHTTANK3 --
--------------------------------------------------------------------------------

local unitName                   = "elighttank3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Kite"

objectName = "elighttank4.s3o"
script = "elighttank3_lus.lua"

local tech						 = [[tech1]]
local armortype					 = [[light]]
local supply					 = [[3]]

VFS.Include("units/ehover/basedefs/elighttank3_basedef.lua")

unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
