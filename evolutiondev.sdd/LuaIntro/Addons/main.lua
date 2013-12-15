if addon.InGetInfo then
	return {
		name	= "LoadScreen",
		desc	= "",
		author  = "Smoth",
		date	= "2013",
		license = "PD",
		layer   = 0,
		enabled = true,
	}
end

------------------------------------------
------------------------------------------

-- load configurations
local loadScreenSettings	= "gamedata/configs/loadscreens.lua"
local loadscreens			= VFS.FileExists(loadScreenSettings) and VFS.Include(loadScreenSettings)

-- for random selection
local loadScreenCount		= #loadscreens
local currentSelection 		= 0

-- defaults
local toolsettings = {		
		tipText				= "text",
		tipTextColor 		= {1.0,1.0,1.0,1.0},
		tipWindowColor 		= {0.0,0.0,0.0,0.0},
		tipWindowWidth		= "40%",
		tipImage			= "",
		tipFontSize			= 25,
		toolAlign			= "center",
		mapHeight			= "80%",
		mapWidth			= "100%",
		mapfontSize			= 25,
		fontShadow			= true,	
		outlineColor		= {0,0,0,1},
		backgroundImage1	= "",
		backgroundImage2	= "",
		backgroundColor		= {1.0,1.0,1.0,1.0},
		}

function addon.Initialize()

	Spring.Echo(os.time())
	local waffles = math.fmod (os.time(),100)
	for i=0, waffles do 
		currentSelection = math.random(1,loadScreenCount)

		Spring.Echo(waffles, "currentSelection", currentSelection)
	end
	
	for k,v in pairs(loadscreens[currentSelection])do
		toolsettings[k] = v
		Spring.Echo(k,v)
	end
	
	local Chili = SG.Chili

	if (not Chili) then
		addon.Remove()
		return
	end
	
	local img_background1	= Chili.Image:New{
		name		= "pl_backgroundimage1";
		parent		= Chili.Screen0;
		file		= toolsettings["backgroundImage1"];
		y			= "0%";
		x			= "0%",
		height		= "100%";
		width		= "100%";
		keepAspect	= false;
		}
	
	local img_background2	= Chili.Image:New{
		name		= "pl_backgroundimage2";
		parent		= Chili.Screen0;
		file		= toolsettings["backgroundImage2"];
		y			= "0%";
		x			= "0%",
		height		= "100%";
		width		= "100%";
		}
		
	local wnd_background	= Chili.Window:New{
		name		= "pl_background",
		parent		= Chili.Screen0;
		y			= "0%";
		width		= "100%";
		height		= "100%";
		draggable	= false;
		resizable	= false;
		color 		= toolsettings["backgroundColor"];
		padding		= {0,0,0,0};
	}
	
	local wnd_minimap = Chili.Window:New{
		name		= "pl_window",
		parent		= Chili.Screen0;
		y			= "0%";
		width		= "30%";
		height		= "40%";
		draggable	= false;
		resizable	= false;
		color 		= {1,1,1,0};
		children = {
			Chili.Label:New{
				caption		= "Current Map:\n" .. Game.mapName;
				fontSize	= toolsettings["mapfontSize"];
				fontShadow	= toolsettings["fontShadow"];
				textColor	= toolsettings["tipTextColor"];
				font = {
					outlineColor	= toolsettings["outlineColor"];
				};  
				autosize	= false;
				height		= "20%";
				width		= "100%";
				valign		= "top";
			},
			Chili.Image:New{
				file	= "$minimap";
				y		= "20%";
				x		= "0%",
				height	= toolsettings["mapHeight"];
				width	= toolsettings["mapWidth"];
			},
		}
	}
	
	local wnd_tip = Chili.Window:New{
		name		= "tooltip picture";
		parent		= Chili.Screen0;
		x			= "30%";
		y			= "00%";
		width		= "70%";
		height		= "100%";
		--autosize	= true;
		draggable	= false;
		resizable	= false;
		color 		= {1,1,1,0};
		children = {
			Chili.Image:New{
				file	= toolsettings["tipImage"];
				x		= "0%";
				height	= "80%";
				width	= "100%";
			},			
		}
	}
	
	local wnd_image = Chili.Window:New{
		name		= "tooltip";
		parent		= Chili.Screen0;
		x			= "5%";
		y			= "40%";
		width		= toolsettings["tipWindowWidth"];
		height		= "50%";
		--autosize	= true;
		draggable	= false;
		resizable	= false;
		valign		= "top";
		color 		= toolsettings["tipWindowColor"];
		children = {
			Chili.Label:New{
				caption		= toolsettings["tipText"];
				fontSize	= toolsettings["tipFontSize"];
				fontShadow	= toolsettings["fontShadow"];
				outline		= true,
				textColor	= toolsettings["tipTextColor"];
				font = {
					outlineColor	= toolsettings["outlineColor"];
				};  
				autosize	= false;
				height		= "100%";
				width 		= "100%";
			},
		}
	}
	
	bar_loading	= Chili.Progressbar:New{
		parent			= wnd_background;
		color			= {1.0,0.0,0.0,0.6};
		backgroundColor	= toolsettings["tipTextColor"];
		
		height			= "5%";
		width			= "80%";
		x				= "10%";
		y				= "85%";
		fontsize		= 25;
		-- skinName	= "Gtechbar";
	}
	img_background1:SetLayer(9001)
	img_background1:SetLayer(9000)
end

function addon.DrawLoadScreen()
	local progress = SG.GetLoadProgress()
	
	bar_loading:SetValue(progress*100)
	if progress* 100 == 100 then
		bar_loading:SetCaption("Loaded! Game starting shortly...")
	else
		bar_loading:SetCaption("Loading")
	end
end

function addon.Shutdown()
end