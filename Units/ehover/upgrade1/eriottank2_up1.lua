-- UNITDEF -- ERIOTTANK2_up1 --
--------------------------------------------------------------------------------

local unitName                   = "eriottank2_up1"

--------------------------------------------------------------------------------
isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Spas Upgrade 1"

objectName = "eriottank3.s3o",
script = "eriottank3.cob",

local tech = [[tech1]]
local armortype = [[light]]
local supply = [[3]]


VFS.Include("units/ehover/basedefs/eriottank2_basedef.lua")

unitDef.weaponDefs               = weaponDefs--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
