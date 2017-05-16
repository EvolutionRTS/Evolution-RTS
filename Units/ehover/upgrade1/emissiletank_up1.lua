-- UNITDEF -- EMISSILETANK_up1 --
--------------------------------------------------------------------------------

local unitName                   = "emissiletank_up1"

--------------------------------------------------------------------------------

isUpgraded	= true
isUpgraded2	= false
isUpgraded3	= false

humanName = "Droplet Upgrade 1"

objectName = "emissiletank2.s3o",
script = "emissiletank2.cob",

local tech = [[tech2]]
local armortype	= [[light]]
local supply = [[14]]

VFS.Include("units/ehover/basedefs/emissiletank_basedef.lua")

unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
