--------------------------------------------------------------------------------

function widget:GetInfo()
   return {
      name      = "Unit Ranges",
      desc      = "Shows ranges of selected units",
      author    = "Niobium",
      date      = "Jan 14th, 2009",
      license   = "GNU GPL v2",
      layer     = 0,
      enabled   = true
   }
end

--------------------------------------------------------------------------------

local circleAlpha      = 0.35
local circleDivs      = 40 -- This is what spring uses

--------------------------------------------------------------------------------

local spGetSelUnitsSorted   = Spring.GetSelectedUnitsSorted
local spGetUnitViewPosition     = Spring.GetUnitViewPosition

local glColor            = gl.Color
local glLineWidth         = gl.LineWidth
local glDepthTest         = gl.DepthTest
local glDrawGroundCircle    = gl.DrawGroundCircle

--------------------------------------------------------------------------------

local uDefs         = UnitDefs
local wDefs         = WeaponDefs

local wepRanges      = {}
local buildRange   = {}

--------------------------------------------------------------------------------

function widget:Initialize()

   for uDefID, uDef in pairs(uDefs) do
      
      wepRanges[uDefID] = {}
      local weapons = uDef.weapons
      local entryIndex = 0
      for weaponIndex=1, #weapons do
         
         local weaponRange = wDefs[weapons[weaponIndex].weaponDef].range
         
         if (weaponRange > 16) then -- many 'fake' weapons have <= 16 range.
            entryIndex = entryIndex + 1
            wepRanges[uDefID][entryIndex] = weaponRange
         end
      end
   end
end

function widget:DrawWorld()

   -- OpenGL stuff
   glLineWidth(1.49)
   glDepthTest(true)
   
   -- Get selected units, sorted for efficiency
   local selUnits = spGetSelUnitsSorted()

   -- Set the color
   glColor(1.0, 0.3, 0.3, circleAlpha)
   
   -- Do the loop
   for uDefID, uIDs in ipairs(selUnits) do
      
      local uWepRanges = wepRanges[uDefID]
      if uWepRanges then
         
         for i = 1, #uIDs do
            
            local ux, uy, uz = spGetUnitViewPosition(uIDs[i])
            
            for r = 1, #uWepRanges do
               glDrawGroundCircle(ux, uy, uz, uWepRanges[r], circleDivs)
            end
         end
      end
   end
end

--------------------------------------------------------------------------------