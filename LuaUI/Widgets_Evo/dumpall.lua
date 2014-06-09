function widget:GetInfo()
	return {
		name      = "Dump all units/features",
		desc      = "Writes the coordinates for all units and features to dumpedunitsfeatures.txt",
		author    = "Gnome, smoth",
		date      = "lol",
		license   = "PD",
		layer     = 5,
		enabled   = false  --  loaded by default?
	}
end

local toUDump = {}
local toBDump = {}
local toFDump = {}

local rotlookup = {}

 rotlookup[0]		= "south" 
 rotlookup[16384]	= "east"
 rotlookup[32767]	= "north"
 rotlookup[-16384]	= "west"


function widget:Initialize()
	local allunits = Spring.GetAllUnits()
	local x, y, z	
	local dx, dy, dz	
	local rot


	for _,ud in ipairs(allunits) do
	
		x,y,z			= Spring.GetUnitBasePosition(ud)
		udid			= Spring.GetUnitDefID(ud)
		rot				= Spring.GetUnitHeading(ud)	
		
		unitname		= UnitDefs[udid].name
		
		if ( UnitDefs[udid].customParams.featureplacer ~= true ) then
		
			if ( UnitDefs[udid].canMove ) then		
				toUDump[#toUDump + 1]	= { name = unitname, x = x, z = z, rot = rot }
			else -- I am not a unit				
				toBDump[#toBDump + 1]	= { name = unitname, x = x, z = z, rot = rotlookup[rot] }
			end
		end
	end
	
	local allfeatures = Spring.GetAllFeatures()
	for _,fd in ipairs(allfeatures) do
		
		x,y,z 			= Spring.GetFeaturePosition(fd)
		rot				= Spring.GetFeatureHeading(fd)		
		fdid 			= Spring.GetFeatureDefID(fd)
		fname 			= FeatureDefs[fdid].name
		toFDump[#toFDump + 1] 	= { name = fname, x = x, z = z, rot = rot }
	end

	local f = io.open("dumpedunitsfeatures.txt", "w+")
	if (f) then
		--f:write("xIcons " .. iconsX .. "\n")

		f:write("local features = { \n\tunitlist = {\n")
		for i=1,#toUDump do
			f:write("\t\t{ name = '" .. toUDump[i].name .. "', x = " .. toUDump[i].x .. ", z = " .. toUDump[i].z ..  ", rot = " .. toUDump[i].rot .." },\n")
		end
		f:write("\t},\n")
		
		f:write("\tbuildinglist = {\n")
		for i=1,#toBDump do
			f:write("\t\t{ name = '" .. toBDump[i].name .. "', x = " .. toBDump[i].x .. ", z = " .. toBDump[i].z ..  ", rot = \"" .. toBDump[i].rot .."\" },\n")
		end
		f:write("\t},\n")
		
		f:write("\tobjectlist = {\n")
		for i=1,#toFDump do
			f:write("\t\t{ name = '" .. toFDump[i].name .. "', x = " .. toFDump[i].x .. ", z = " .. toFDump[i].z .. ", rot = \"" .. toFDump[i].rot .."\" },\n")
		end
		f:write("\t},\n}\nreturn features\n")
		
		f:close()
	else
		Spring.Echo("Could not open dumpedunitsfeatures.txt for writing!")
	end
	
	widgetHandler:RemoveWidget()
end