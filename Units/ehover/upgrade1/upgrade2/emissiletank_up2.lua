-- UNITDEF -- EMISSILETANK_up2 --
--------------------------------------------------------------------------------

local unitName                   = "emissiletank_up2"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= true
isUpgraded3	= false

humanName = "Droplet Upgrade 2"

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
