-- UNITDEF -- ELIGHTTANK3_up1 --
--------------------------------------------------------------------------------

local unitName                   = "elighttank3_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Kite Upgrade 1"

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
