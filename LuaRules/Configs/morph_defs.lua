--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local devolution = (-1 > 0)


local morphDefs = {

  -- Constructors

  esubplane = {
    into = 'esubmarine',
    tech = 0,
    time = 0,
  },
  esubmarine = {
    into = 'esubplane',
    tech = 0,
    time = 0,
  },
}

--
-- Here's an example of why active configuration
-- scripts are better then static TDF files...
--

--
-- devolution, babe  (useful for testing)
--
if (devolution) then
  local devoDefs = {}
  for src,data in pairs(morphDefs) do
    devoDefs[data.into] = { into = src, time = 10, metal = 1, energy = 1 }
  end
  for src,data in pairs(devoDefs) do
    morphDefs[src] = data
  end
end


return morphDefs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
