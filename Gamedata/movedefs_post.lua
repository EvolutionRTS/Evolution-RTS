
-- for B,T in pairs(MoveDefs) do
-- Spring.Echo("-----")
-- Spring.Echo(T["name"])
-- for k,v in pairs(T) do
-- Spring.Echo(k,v)
-- end
-- end

local tagList		= 	VFS.Include("gamedata/movedefs_tags.lua")

for unitdefname, ud in pairs(DEFS.unitDefs) do

myMovDef = nil

	if (ud.movementclass) then
		
		for B,T in pairs(MoveDefs) do
			if ( string.lower(T["name"]) == string.lower(ud.movementclass)) then
				myMovDef = B
			end
		end
		
		if (myMovDef ~= nil ) then -- found a valid def time to error check that.
			for tagName,_ in pairs (tagList) do
			tagName = string.lower(tagName)
				if ( MoveDefs[myMovDef][tagName] ~= nil ) then
					if ( ud[tagName] ~= nil and ud[tagName] ~= MoveDefs[myMovDef][tagName] ) then
						--Spring.Echo(tagName,ud[tagName],MoveDefs[myMovDef][tagName])
						Spring.Echo("Warning! Unit: " .. ud.name .." Unit tag: " .. tagName .. " (".. ud[tagName] .. ") conflicts movedata (" .. MoveDefs[myMovDef][tagName] .. ")")
						ud[tagName] = MoveDefs[myMovDef][tagName]
					end
				end
			end			
		else
			Spring.Echo("Unit: " .. ud.name .. ", Missing move class def: \"" .. ud.movementclass .. "\"")
		end

	end
end