-- UNITDEF -- EARTYTANK_up2 --
--------------------------------------------------------------------------------

local unitName                   = "eartytank_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "ShadowFury Upgrade 2"

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
