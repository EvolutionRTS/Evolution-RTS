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

local function ProcessUnitDef(udName, ud)

  local fds = ud.featuredefs
  if (not istable(fds)) then
    return
  end

  -- add this unitDef's featureDefs
  for fdName, fd in pairs(fds) do
    if (isstring(fdName) and istable(fd)) then
      local fullName = udName .. '_' .. fdName
      FeatureDefs[fullName] = fd
      fd.filename = ud.filename
    end
  end

  -- FeatureDead name changes
  for fdName, fd in pairs(fds) do
    if (isstring(fdName) and istable(fd)) then
      if (isstring(fd.featuredead)) then
        local fullName = udName .. '_' .. fd.featuredead:lower()
        if (FeatureDefs[fullName]) then
          fd.featuredead = fullName
        end
      end
    end
  end

  -- convert the unit corpse name
  if (isstring(ud.corpse)) then
    local fullName = udName .. '_' .. ud.corpse:lower()
    local fd = FeatureDefs[fullName]
    if (fd) then
      ud.corpse = fullName
    end
  end
end

if spGetModOptions then

for name, fd in pairs(FeatureDefs) do
	if(
	(
		tonumber(fd["footprintz"]) <= 2 
		or tonumber(fd["footprintx"]) <= 2 
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

for name, fd in pairs(FeatureDefs) do
	if fd.name ~= "ammobox" then
		fd.metal = 0
		fd.energy = 10
	end
end

if ( spGetModOptions().comm  == "sandbox"  or  spGetModOptions().comm  == "feature"  ) then
	local FeddyBuild = DEFS.unitDefs["eairengineer"].buildoptions
	local ZeonBuild = DEFS.unitDefs["eairengineer"].buildoptions
	local goldtreeBuild = DEFS.unitDefs["goldtree"].buildoptions

	
	for name, fd in pairs(FeatureDefs) do
	
		unit = {}
		DEFS.unitDefs[name .. "_unit"] = unit
			

		
		setmetatable(unit, {__index = fd})
		unit.isfeature		= true
		unit.corpse			= name
		unit.objectname		= unit.object
		unit.script			= "default.cob"
		unit.maxslope		= 255
		unit.maxwaterdepth	= 255
		unit.footprintX		= footprintX
		unit.footprintZ		= footprintZ
		unit.levelGround	= false
		unit.buildPic		= "featureplacer/" .. name .. "_unit.png"
		unit.collisionvolumetype  		= collisionvolumetype
		unit.collisionvolumescales 		= collisionvolumescales
		unit.collisionvolumeoffsets 	= collisionvolumeoffsets	
		
		goldtreeBuild[#goldtreeBuild + 1] = name .. "_unit"
		table.sort(goldtreeBuild)
	end
	
	Spring.Echo("Sandbox mode active!")
		
	for unitdefname, ud in pairs(DEFS.unitDefs) do
		if(spGetModOptions().comm  == "feature")then
			ud.levelGround		= false
			ud.maxslope			= 255
			ud.maxwaterdepth	= 255	
			ud.footprintX		= 1
			ud.footprintZ		= 1
			DEFS.unitDefs[unitdefname].buildtime		= 0
			DEFS.unitDefs[unitdefname].metalcost		= 0
			DEFS.unitDefs[unitdefname].energycost		= 0
		else
			DEFS.unitDefs[unitdefname].buildtime		= 0.2
			DEFS.unitDefs[unitdefname].metalcost		= 0
			DEFS.unitDefs[unitdefname].energycost		= 0
		end
		--Spring.Echo(DEFS.unitDefs[unitdefname].buildpicname)
		
		--
		-- Kludges to fix random spring bullshit
		--
		
		if ( ud.iconType == nil and ( ud.customparams and ud.customparams.factionname == "neutral" ) ) then
			ud.iconType			= "neutral"
		end
		
		-- units have to have an on/off state for radar/sonar to work. FUCKING RETARDED whatever KLUDGED!
		ud.activateWhenBuilt  = true 
		-- 
		-- Kludges end
		--
		
		if ( ud.customparams  and not ud.customparams.featureplacer ) then
		-- Spring.Echo(ud.unitname)
			if  ( ud.customparams.factionname == "zeon" ) then
				ZeonBuild[#ZeonBuild + 1] = ud.unitname
				--Spring.Echo("Zeon")
			else
				if  (ud.customparams and ud.customparams.factionname == "neutral" or ud.customparams and ud.customparams.factionname == "randm" ) then
					goldtreeBuild[#goldtreeBuild + 1] = ud.unitname
					--Spring.Echo("GoldTree")
				else
					FeddyBuild[#FeddyBuild + 1] = ud.unitname
					--Spring.Echo("Federation")
				end
			end
		else
			--Spring.Echo(ud.unitname, "Has no custom params or is a feature placer")
		end
	end
	table.sort(FeddyBuild)
	table.sort(ZeonBuild)
	--Spring.Echo(#goldtreeBuild .. " Generic features loaded" )
	--Spring.Echo(#FeddyBuild .. " Federation entities loaded" )
	--Spring.Echo(#ZeonBuild .. " Zeon entities loaded " )
end
--------------------------------------------------------------------------------
end
-- Process the unitDefs

local UnitDefs = DEFS.unitDefs

for udName, ud in pairs(UnitDefs) do
  if (isstring(udName) and istable(ud)) then
    ProcessUnitDef(udName, ud)
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
