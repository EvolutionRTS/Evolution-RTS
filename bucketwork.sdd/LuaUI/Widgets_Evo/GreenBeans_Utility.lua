Spring.SendCommands({"ctrlpanel " .. LUAUI_DIRNAME .. "panel.txt"})

function widget:GetInfo()
	return {
		name      = "Manditory UI stuff",
		desc      = "Required",
		author    = "Smoth",
		date      = "10th February 2008",
		license   = "PD!",
		layer     = -9001,
		enabled   = true  --  loaded by default
	}
end

-- prints a copy of a table to chat
local function recursiveTableReader(currTable, dashes)
	dashes = dashes .. dashes
	if type(currTable) == 'table' then
		for k,v in pairs(currTable) do
			if (v ~= nil) then
				Spring.Echo(dashes .. "[" .. tostring(k) .. "]")
				recursiveTableReader(v, dashes)
			end
		end
	else
		if (currTable ~= nil) then
			Spring.Echo(dashes .. tostring(currTable) )
		end
	end
end

-- Jk's function taken from chili\headers\util.lua
function table:merge(table2)
  for i,v in pairs(table2) do
    if (type(v)=='table') then
      local sv = type(self[i])
      if (sv == 'table')or(sv == 'nil') then
        if (sv == 'nil') then self[i] = {} end
        table.merge(self[i],v)
      end
    elseif (self[i] == nil) then
      self[i] = v
    end
  end
end
	
VFS.Include('gamedata/libs/ShaderAndColorUtilities.lua')
 
local colorSets					= GetColorSets()
local bucketsChoices			= GetBucketTypes()
local pigments, finishes		= BuildPaintBucketsAndFinishes(colorSets, false)
local finishLookup				= CreateColorLookup(finishes)
local pigmentLookup				= CreateColorLookup(pigments)
local mergedSchemes				= SetupSchemes(pigments, finishes)
local playerSchemeSelections	= GetPlayerSchemeSelection()
local bucketSelections, bucketSelectionsByName	= SetupBuckets(mergedSchemes)
local _,matrices				= ProcessMatrices()

WG.SWAGTheme				= GetSWAGScheme()
WG.colors 					= BuildColorSets(colorSets)		
WG.finishes					= finishes
WG.pigments					= pigments
WG.matrices					= matrices
WG.bucketsChoices			= bucketsChoices
WG.bucketSelections			= bucketSelections
WG.paintSchemes				= mergedSchemes
WG.playerSchemeSelections	= playerSchemeSelections
WG.bucketSelectionsByName	= bucketSelectionsByName
WG.finishLookup				= finishLookup
WG.pigmentLookup			= pigmentLookup


local aspectRatios	= {}
local sidedata 		= VFS.Include("gamedata/sidedata.lua")

-- 4:3 = 0.75
-- so...
-- 4/3 = 0.75
-- X * 0.75 = Y
-- so 1024 * 0.75 = 768
--
-- 16:9 = 0.5625
-- so...
-- 9/16 = 0.5625

-- safest to assume that we should go by Y value. 
-- It means that elements will be spaced out in 
-- wide screens but at least 1024 won't be too crazy.
--
-- for goobers who run something like 9:16 (aka moniters sideways) 
-- use width instead of height
--
-- so code should be:
--
--
-- get width/height
-- if height smaller than width assume normal screen sizes and orientation.
-- save height/100 as size multiplier
-- else
-- arange by width value instead.
-- save width/100 as size multiplier
-- end

local vsx,vsy = gl.GetViewSizes()

-- am I widescreen?
--if ( vsy < vsx ) then
	WG.RatioVal = vsx/100
	--Spring.Echo(WG.RatioVal, "widescreen")
	WG.FontSize  = (10/(1600/vsx))+4
-- else
	-- WG.RatioVal = vsy/100
	-- Spring.Echo(WG.RatioVal, "widescreen")
	-- WG.FontSize  = (10/(1600/vsy))+4
-- end
-- initialize widget faction var to an invalid faction
WG.myfaction = "NOTSET"

local function HandleFaction (factionName)
	if ( factionName == "" ) then 
		--default to first faction in list
		factionName = 	string.lower(sidedata[1].name)
	end	
	
	return string.lower(factionName)
end

function ProcessBuild(command, line, words)
	if #words == 1 then
		Spring.SelectUnitArray({(Spring.GetLocalTeamID() + 1)})
		Spring.SetActiveCommand("buildunit_" .. words[1])
	end
	
end

function widget:Initialize()
	WG.uiElementRegistry = {}
	WG.myTeamID = Spring.GetMyTeamID()
	WG.sideData = sidedata
	WG.myFaction = string.upper(HandleFaction(select(5, Spring.GetTeamInfo(WG.myTeamID))))

	WG.myOldFaction = WG.myFaction
	WG.myOldFaction = WG.myFaction
	
	WG.factionColorSet = WG.colors["uiSets_rgba"][WG.myFaction]

	WG.mainColor		= WG.factionColorSet["Main"]
	WG.secondaryColor	= WG.factionColorSet["Trim"]
	WG.rankColor		= WG.factionColorSet["Rank"]
	
	widgetHandler:ConfigLayoutHandler(DefaultHandler)

	-- Remove the resource bar, we dont need it
	Spring.SendCommands('ctrlpanel LuaUI/panel.txt')
	Spring.SendCommands("resbar 0")
	Spring.SendCommands("tooltip 0")
	widgetHandler:AddAction("build", ProcessBuild)
end

------------------------------------------------
-- handle team change.
-- sets main colors for UI elements.
------------------------------------------------
function widget:Update(s) 
	WG.myTeamID = Spring.GetMyTeamID()
	WG.myFaction = string.upper(HandleFaction(select(5, Spring.GetTeamInfo(WG.myTeamID))))

	if WG.myTeamID ~= WG.myOldTeamID then
		WG.myOldTeamID = WG.myTeamID
		
		WG.justSwitched = 1
		
		--Spring.Echo(WG.myFaction, WG.myFaction ~= WG.myOldFaction)
		if ( WG.myFaction ~= WG.myOldFaction ) then
			--Spring.Echo("changed faction from " .. WG.myOldFaction .. " to " .. WG.myFaction)
			
			for k,v in pairs(WG.uiElementRegistry) do
				WG.uiElementRegistry[k] = true;
			end	

			WG.ChangeNow = true
			WG.factionColorSet	= WG.colors["uiSets_rgba"][string.upper(WG.myFaction)]
		--	Spring.Echo("WG.factionColorSet", WG.factionColorSet[1], WG.factionColorSet[2],WG.factionColorSet[3])
			WG.mainColor		= WG.factionColorSet["Main"]
			WG.secondaryColor	= WG.factionColorSet["Trim"]
			WG.rankColor		= WG.factionColorSet["Rank"]
			-- Spring.Echo(WG.rankColor[1], WG.rankColor[1], WG.rankColor[1],
						-- WG.secondaryColor[1], WG.secondaryColor[1], WG.secondaryColor[1],
						-- WG.mainColor[1], WG.mainColor[1], WG.mainColor[1])
			WG.myOldFaction = WG.myFaction
		end
	end
end