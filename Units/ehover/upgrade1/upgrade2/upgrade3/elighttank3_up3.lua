-- UNITDEF -- ELIGHTTANK3_up3 --
--------------------------------------------------------------------------------

local unitName                   = "elighttank3_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "Kite Upgrade 3"

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
