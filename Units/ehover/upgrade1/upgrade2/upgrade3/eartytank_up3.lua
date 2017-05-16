-- UNITDEF -- EARTYTANK_up3 --
--------------------------------------------------------------------------------

local unitName                   = "eartytank_up3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "ShadowFury Upgrade 3"

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
