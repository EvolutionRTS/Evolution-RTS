if Spring.GetModOptions and Spring.GetModOptions().unitheat ~= nil then
	unitHeat = Spring.GetModOptions().unitheat * 0.0042
else
	unitHeat = 0.0042
end

flowMappingToggle = true

local genericDepthmodParams = {
		minHeight      = 0,
		maxHeight      = 5000,
		maxScale       = 1.25,
		quadraticCoeff = 0,
		linearCoeff    = 0, -- deprecates "depthMod"
		constantCoeff  = 1.25,
}

local amphibDepthmodParams = {
		minHeight      = 0,
		maxHeight      = 5000,
		maxScale       = 1,
		quadraticCoeff = 0,
		linearCoeff    = 0, -- deprecates "depthMod"
		constantCoeff  = 1,
}

local moveDefs = {

--Hover--

   HOVERTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

   HOVERTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   ORBHOVERTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End Hover--


--hBot--

   HOVERHBOT2 = {
      footprintx=2,
      footprintz=2,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

   HOVERHBOT3 = {
      footprintx=3,
      footprintz=3,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERHBOT4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERHBOT5 = {
      footprintx=5,
      footprintz=5,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERHBOT6 = {
      footprintx=6,
      footprintz=6,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   HOVERHBOT8 = {
      footprintx=8,
      footprintz=8,
      maxslope=90,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=3,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End hBot--


--All Terrain--

   ALLTERRTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=90,
      maxwaterdepth=30,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

   ALLTERRTANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=90,
      maxwaterdepth=30,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

   ALLTERRTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      maxwaterdepth=30,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

    ALLTERRTANK5 = {
      footprintx=5,
      footprintz=5,
      maxslope=90,
      maxwaterdepth=30,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

   ALLTERRTANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=90,
      maxwaterdepth=30,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End All Terrain--


--Amphibious--
   TANK1 = {
      footprintx=1,
      footprintz=1,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=0,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=2,
	  depthMod=0,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   NORMALTANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
      maxwaterdepth=10,
      maxwaterslope=26,
      badwaterslope=26,
      crushstrength=20,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   TANK2 = {
      footprintx=2,
      footprintz=2,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=2,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   TANK3 = {
      footprintx=3,
      footprintz=3,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=2,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   TANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=2,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   
   TANK6 = {
      footprintx=6,
      footprintz=6,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=2,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   

--End Amphibious--


--UBoat--

    UBOAT4 = {
      footprintx = 4,
      footprintz = 4,
      maxslope=60,
      minwaterdepth = 30,
      crushstrength = 20,
      subMarine = 1,
	  depthModParams = amphibDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End UBoat--


--Endbringers--

   EXPERIMENTALTANK10 = {
      footprintx=12,
      footprintz=12,
      maxslope=30,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=100,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   HOVERTANKEXPERIMENTAL9 = {
      footprintx=9,
      footprintz=9,
      maxslope=30,
      maxwaterdepth=30,
      crushstrength=100,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   EXPERIMENTALTANK12 = {
      footprintx=12,
      footprintz=12,
      maxslope=90,
      maxwaterdepth=80,
      crushstrength=100,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End Endbringers--


--Commanders--

   COMMANDERTANK4 = {
      footprintx=4,
      footprintz=4,
      maxslope=90,
      crushstrength=20,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },
   COMMANDERTANKAI4 = {
      footprintx=4,
      footprintz=4,
      maxslope=30,
      crushstrength=20,
      maxwaterdepth=10,
      maxwaterslope=255,
      badwaterslope=255,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=10,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
   },

--End Commanders--


--ZAAL--
   
	ZAALQUEEN3 = {
		footprintx=3,
		footprintz=3,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT1 = {
		footprintx=1,
		footprintz=1,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT2 = {
		footprintx=2,
		footprintz=2,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT3 = {
      footprintx=3,
      footprintz=3,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT4 = {
		footprintx=4,
		footprintz=4,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT5 = {
		footprintx=5,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	ZAALKBOT6 = {
		footprintx=6,
		footprintz=6,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	
--End ZAAL--

--Pattern--

	PATTERNKBOT2 = {
      footprintx=2,
      footprintz=2,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},
	
	PATTERNKBOT3 = {
      footprintx=3,
      footprintz=3,
      maxslope=40,
      maxwaterdepth=5000,
      maxwaterslope=255,
      badwaterslope=255,
      crushstrength=20,
	  depthModParams = genericDepthmodParams,
	  minwaterdepth=0,
	  heatmod=unitHeat,
	  slopemod=4,
	  allowRawMovement=true,
	  flowMapping=flowMappingToggle,
	},

}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- convert from map format to the expected array format

local array = {}
local i = 1
for k,v in pairs(moveDefs) do
	v.heatmapping = false -- disable heatmapping
	v.allowRawMovement = true
	array[i] = v
	v.name = k
	i = i + 1
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return array

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------