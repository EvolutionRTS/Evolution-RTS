-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- because I don't want to deal with a conflict
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "CustomUnitShaders neutralizer",
    desc      = "allows to override the engine unit shader",
    author    = "jK",
    date      = "2008,2009,2010",
    license   = "GNU GPL, v2 or later",
    layer     = 1,
    enabled   = true  --  loaded by default?
  }
end
