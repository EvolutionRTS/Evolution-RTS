if Spring.GetModOptions and Spring.GetModOptions().unitheat ~= nil then
	unitHeat = Spring.GetModOptions().unitheat * 0.0001
else
	unitHeat = 0.0042
end

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
   },

--End Hover--


--hBot--

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
   },

--End hBot--


--All Terrain--

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
	},
	
--End ZAAL--
   
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