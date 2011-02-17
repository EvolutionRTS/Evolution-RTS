--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    moveDefs.lua
--  brief:   move data definitions
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local moveDefs = {

   TANK1 = {
      footprintx=1;
      footprintz=1;
      maxslope=28;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=0;
      depthmod=0.1;
	  heatmapping=false;
   },

   HOVERTANK2 = {
      footprintx=2;
      footprintz=2;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
	  heatmapping=false;
   },

   NORMALTANK2 = {
      footprintx=2;
      footprintz=2;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=26;
      badwaterslope=26;
      crushstrength=20;
	  heatmapping=false;
   },
   
   TANK2 = {
      footprintx=2;
      footprintz=2;
      maxslope=28;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
      depthmod=0.1;
	  heatmapping=false;
   },

   HOVERTANK3 = {
      footprintx=3;
      footprintz=3;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
	  heatmapping=false;
   },

   TANK3 = {
      footprintx=3;
      footprintz=3;
      maxslope=28;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
      depthmod=0.1;
	  heatmapping=false;
   },
   
   ALLTERRTANK3 = {
      footprintx=3;
      footprintz=3;
      maxslope=180;
      maxwaterdepth=10;
      crushstrength=20;
	  heatmapping=false;
   },

   HOVERTANK4 = {
      footprintx=4;
      footprintz=4;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
	  heatmapping=false;
   },

   TANK4 = {
      footprintx=4;
      footprintz=4;
      maxslope=28;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
      depthmod=0.1;
	  heatmapping=false;
   },
   ALLTERRTANK4 = {
      footprintx=4;
      footprintz=4;
      maxslope=180;
      maxwaterdepth=10;
      crushstrength=20;
	  heatmapping=false;
   },
    UBOAT4 = {
      footprintx = 4,
      footprintz = 4,
      maxslope=60;
      minwaterdepth = 30,
      crushstrength = 20,
      subMarine = 1,
	  heatmapping=false;
   },

   HOVERTANK5 = {
      footprintx=5;
      footprintz=5;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
	  heatmapping=false;
   },
   
    ALLTERRTANK5 = {
      footprintx=5;
      footprintz=5;
      maxslope=180;
      maxwaterdepth=10;
      crushstrength=20;
	  heatmapping=false;
   },

   HOVERTANK6 = {
      footprintx=6;
      footprintz=6;
      maxslope=26;
      maxwaterdepth=10;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=20;
	  heatmapping=false;
   },
   ALLTERRTANK6 = {
      footprintx=6;
      footprintz=6;
      maxslope=180;
      maxwaterdepth=10;
      crushstrength=20;
	  heatmapping=false;
   },
   COMMANDERTANK4 = {
      footprintx=4;
      footprintz=4;
      maxslope=180;
      maxwaterdepth=25;
      crushstrength=20;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      depthmod=0.1;
	  heatmapping=false;
   },
   EXPERIMENTALTANK10 = {
      footprintx=12;
      footprintz=12;
      maxslope=28;
      maxwaterdepth=5000;
      maxwaterslope=255;
      badwaterslope=255;
      crushstrength=100;
	  heatmapping=false;
   },
   HOVERTANKEXPERIMENTAL9 = {
      footprintx=9;
      footprintz=9;
      maxslope=26;
      maxwaterdepth=20;
      crushstrength=100;
	  heatmapping=false;
   },
   EXPERIMENTALTANK12 = {
      footprintx=12;
      footprintz=12;
      maxslope=180;
      maxwaterdepth=80;
      crushstrength=100;
	  heatmapping=false;
   },
}


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- convert from map format to the expected array format

local array = {}
local i = 1
for k,v in pairs(moveDefs) do
   array[i] = v
   v.name = k
   i = i + 1
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return array

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
