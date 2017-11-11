if Spring.GetModOptions and Spring.GetModOptions().heatmapping ~= nil then
	local useHeatMapping = Spring.GetModOptions().heatmapping
	if useHeatMapping ~= "enabled" then
		heatmapping = true
	end
	
	local unitHeat = Spring.GetModOptions().unitheat * 0.001
	
else
	heatmapping = false
	unitHeat = 0.025
end

local moveDefs = {

   TANK1 = {
      footprintx=1,
      footprintz=1,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   HOVERTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   NORMALTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   
   TANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   HOVERTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
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
	  heatmod=unitHeat,
	  slopemod=2,
	  heatmapping=heatmapping,
   },
   
   HOVERHBOT4 = {
      footprintx=4,
      footprintz=4,
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
	  heatmod=unitHeat,
	  slopemod=2,
	  heatmapping=heatmapping,
   },
   
   HOVERHBOT5 = {
      footprintx=5,
      footprintz=5,
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
	  heatmod=unitHeat,
	  slopemod=2,
	  heatmapping=heatmapping,
   },
   
   HOVERHBOT6 = {
      footprintx=6,
      footprintz=6,
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
	  heatmod=unitHeat,
	  slopemod=2,
	  heatmapping=heatmapping,
   },

   TANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   
   ALLTERRTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=90,
      maxwaterdepth=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   HOVERTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   TANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   ALLTERRTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      maxwaterdepth=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },

   HOVERTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   
    ALLTERRTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=90,
      maxwaterdepth=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   TANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   HOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   ORBHOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   ALLTERRTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=90,
      maxwaterdepth=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
	
   },
   COMMANDERTANKAI4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
      crushstrength=20,
      maxwaterdepth=10,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
	
   },
   EXPERIMENTALTANK10 = {
      footprintx=12,
      footprintz=12,
      maxslope=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   HOVERTANKEXPERIMENTAL9 = {
      footprintx=9,
      footprintz=9,
      maxslope=30,
      maxwaterdepth=30,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
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
	  heatmod=unitHeat,
	  slopemod=4,
	  heatmapping=heatmapping,
   },
   
	CHICKENNANO = {
		crushstrength = 0,
		footprintx = 3,
		footprintz = 3,
		maxslope = 18,
		maxwaterdepth = 0,
	},
	CHICKQUEEN = {
		footprintx=3,
		footprintz=3,
		maxwaterdepth=72,
		maxslope=40,
		crushstrength=15000,
		avoidMobilesOnPath=false,
	},
	CHICKENHKBOT1 = {
		footprintx=1,
		footprintz=1,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=1400,
	},
	CHICKENHKBOT2 = {
		footprintx=2,
		footprintz=2,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=1400,
	},
	CHICKENHKBOT3 = {
		footprintx=3,
		footprintz=3,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=1400,
	},
	CHICKENHKBOT4 = {
		footprintx=4,
		footprintz=4,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=11000,
	},
	CHICKENHKBOT5 = {
		footprintx=5,
		footprintz=5,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=11000,
	},
	CHICKENHKBOT6 = {
		footprintx=6,
		footprintz=6,
		maxwaterdepth=22,
		maxslope=36,
		crushstrength=11000,
	},
	CHICKENHOVERDODO = {
		footprintx = 1,
		footprintz = 1,
		maxslope = 30,
		maxwaterslope = 255,
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

