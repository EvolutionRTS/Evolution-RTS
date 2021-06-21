--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    featuredefs_post.lua
--  brief:   featureDef post processing
--  author:  Dave Rodgers
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Per-unitDef featureDefs
--

local function isbool(x)   return (type(x) == 'boolean') end
local function istable(x)  return (type(x) == 'table')   end
local function isnumber(x) return (type(x) == 'number')  end
local function isstring(x) return (type(x) == 'string')  end
local spGetModOptions   = Spring.GetModOptions

--------------------------------------------------------------------------------

if spGetModOptions then

for name, fd in pairs(FeatureDefs) do
	
	if fd["footprintz"] == 0 or fd["footprintz"] == nil then
		fd["footprintz"] = 1
	end
	if fd["footprintx"] == 0 or fd["footprintx"] == nil then
		fd["footprintx"] = 1
	end
	
	if fd["footprintz"] ~= nil and fd["footprintx"] ~= nil then
		if(
		(
			tonumber(fd["footprintz"]) <= 8 
			or tonumber(fd["footprintx"]) <= 8 
			or string.lower(fd["category"]) == "vegitation" 
			or string.lower(fd["category"]) == "vegetation" 
		)
		and (not fd["name"] or string.lower(fd["name"]) ~= "ammobox")
		) then
			fd["blocking"] = false
			if (not fd.customparams) then 
			 fd.customparams = {}
			end
			if (not fd.customparams.provide_cover) then
			 fd.customparams.provide_cover = 1
	--		  Spring.Echo("Feature["..name.."] is providing cover!")
			end   
		end
	end
	
	-- Reset maximum feature values
	if tonumber(fd["metal"]) == nil or tonumber(fd["metal"]) == 0 then
		fd.metal = 100
	end
	if tonumber(fd["metal"]) > 100 then
		fd.metal =  100
	end
	if tonumber(fd["energy"]) == nil or tonumber(fd["energy"]) == 0 then
		fd.energy = 100
	end
	if tonumber(fd["energy"]) > 500 then
		fd.energy = 500
	end
end


end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
