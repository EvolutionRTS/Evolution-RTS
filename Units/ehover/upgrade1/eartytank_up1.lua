-- UNITDEF -- EARTYTANK_up1 --
--------------------------------------------------------------------------------

local unitName                   = "eartytank_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "ShadowFury Upgrade 1"

objectName = "eartytank2.s3o"
script = "eartytank2.cob"

local tech						 = [[tech1]]
local armortype					 = [[light]]
local supply					 = [[8]]

VFS.Include("units/ehover/basedefs/eartytank_basedef.lua")

unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
