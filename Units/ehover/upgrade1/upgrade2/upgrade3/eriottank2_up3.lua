-- UNITDEF -- ERIOTTANK2_up3 --
--------------------------------------------------------------------------------

local unitName                   = "eriottank2_up3"

--------------------------------------------------------------------------------
isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= true

humanName = "Spas Upgrade 3"

objectName = "eriottank3.s3o",
script = "eriottank3.cob",

local tech = [[tech1]]
local armortype = [[light]]
local supply = [[3]]


VFS.Include("units/ehover/basedefs/eriottank2_basedef.lua")

unitDef.weaponDefs               = weaponDefs--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
