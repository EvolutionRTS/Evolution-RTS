function gadget:GetInfo()
  return {
    name      = "NoFpsMode",
    desc      = "Block direct control (FPS) for really all units",
    author    = "jK",
    date      = "Feb 2012",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

function gadget:AllowDirectUnitControl()	
	return false
end