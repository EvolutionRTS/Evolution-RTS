-- UNITDEF -- ELIGHTTANK3_up2 --
--------------------------------------------------------------------------------

local unitName                   = "elighttank3_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "Kite Upgrade 2"

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
