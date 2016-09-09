local moveDefs = {

   TANK1 = {
      footprintx=1,
      footprintz=1,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=0,
      depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   HOVERTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   NORMALTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=26,
      badwaterslope=26,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   
   TANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.5,
         quadraticCoeff = 0.1,
         linearCoeff    = 0.1, -- deprecates "depthMod"
         constantCoeff  = 1,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   HOVERTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   
   HOVERHBOT3 = {
      footprintx=3,
      footprintz=3,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 0,
         maxScale       = 1.5,
         quadraticCoeff = 0.1,
         linearCoeff    = 0.1, -- deprecates "depthMod"
         constantCoeff  = 1,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=2,
	  heatmapping=false,
   },

   TANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   
   ALLTERRTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=90,
      maxwaterdepth=10,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.5,
         quadraticCoeff = 0.1,
         linearCoeff    = 0.1, -- deprecates "depthMod"
         constantCoeff  = 1,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   HOVERTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   TANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   ALLTERRTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      maxwaterdepth=10,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
    UBOAT4 = {
      footprintx = 4,
      footprintz = 4,
      maxslope=60,
      minwaterdepth = 30,
      crushstrength = 20,
      subMarine = 1,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },

   HOVERTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   
    ALLTERRTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=90,
      maxwaterdepth=10,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   TANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   HOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=26,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   ORBHOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=26,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   ALLTERRTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=90,
      maxwaterdepth=10,
      crushstrength=20,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   COMMANDERTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      crushstrength=20,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   EXPERIMENTALTANK10 = {
      footprintx=12,
      footprintz=12,
      maxslope=28,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=100,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   HOVERTANKEXPERIMENTAL9 = {
      footprintx=9,
      footprintz=9,
      maxslope=26,
      maxwaterdepth=20,
      crushstrength=100,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
   EXPERIMENTALTANK12 = {
      footprintx=12,
      footprintz=12,
      maxslope=90,
      maxwaterdepth=80,
      crushstrength=100,
	  depthModParams = {
         minHeight      = 0,
         maxHeight      = 5000,
         maxScale       = 1.1,
         quadraticCoeff = 0.3,
         linearCoeff    = 0.3, -- deprecates "depthMod"
         constantCoeff  = 0.3,
       },
	  minwaterdepth=10,
	  heatmod=0.5,
	  slopemod=4,
	  heatmapping=false,
   },
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- convert from map format to the expected array format

local moveDefsArray = {}
local i = 1
for k,v in pairs(moveDefs) do
	moveDefsArray[i] = v
	v.name = k
	i = i + 1
end


return moveDefsArray

