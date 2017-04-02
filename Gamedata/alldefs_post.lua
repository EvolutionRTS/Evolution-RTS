--------------------------
-- DOCUMENTATION
-------------------------

-- Evolution RTS contains weapondefs in its unitdef files
-- Standalone weapondefs are only loaded by Spring after unitdefs are loaded
-- So, if we want to do post processing and include all the unit+weapon defs, and have the ability to bake these changes into files, we must do it after both have been loaded
-- That means, ALL UNIT AND WEAPON DEF POST PROCESSING IS DONE HERE

-- What happens:
-- unitdefs_post.lua calls the _Post functions for unitDefs and any weaponDefs that are contained in the unitdef files
-- unitdefs_post.lua writes the corresponding unitDefs to customparams (if wanted)
-- weapondefs_post.lua fetches any weapondefs from the unitdefs, 
-- weapondefs_post.lua fetches the standlaone weapondefs, calls the _post functions for them, writes them to customparams (if wanted)
-- strictly speaking, alldefs.lua is a misnomer since this file does not handle armordefs, featuredefs or movedefs

-- Switch for when we want to save defs into customparams as strings (so as a widget can then write them to file)
-- The widget to do so can be found in 'etc/Lua/bake_unitdefs_post'
SaveDefsToCustomParams = false


-------------------------
-- DEFS POST PROCESSING
-------------------------

local function tobool(val)
	local t = type(val)
	if (t == 'nil') then
		return false
	elseif (t == 'boolean') then
		return val
	elseif (t == 'number') then
		return (val ~= 0)
	elseif (t == 'string') then
		return ((val ~= '0') and (val ~= 'false'))
	end
	return false
end

-- process unitdef
function UnitDef_Post(name, uDef)

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Utility
	--

	local function tobool(val)
	  local t = type(val)
	  if (t == 'nil') then
		return false
	  elseif (t == 'boolean') then
		return val
	  elseif (t == 'number') then
		return (val ~= 0)
	  elseif (t == 'string') then
		return ((val ~= '0') and (val ~= 'false'))
	  end
	  return false
	end


	local function disableunits(unitlist)
	  for name, ud in pairs(UnitDefs) do
		if (ud.buildoptions) then
		  for _, toremovename in ipairs(unitlist) do
			for index, unitname in pairs(ud.buildoptions) do
			  if (unitname == toremovename) then
				table.remove(ud.buildoptions, index)
			  end
			end
		  end
		end
	  end
	end
		
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- 3dbuildrange for all none plane builders
	--
	--[[
	for name, ud in pairs(UnitDefs) do
	  if (tobool(ud.isBuilder) and not tobool(ud.canfly)) then
		ud.buildrange3d = true
	  end
	end
	--]]

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- turn off unit collision check for planes
	--

	if uDef.canfly and not uDef.istransport then
		uDef.collide = false
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Set cost multiples for mobile units vs buildings
	--

	--Mobile Units
	if uDef.customparams and uDef.customparams.unittype == "mobile" then
		uDef.buildcostmetal = uDef.buildcostmetal * 2
		uDef.maxdamage = uDef.maxdamage * 2
	end
	
	-- Buildings
	if uDef.customparams and uDef.customparams.unittype == "building" then
		uDef.buildcostmetal = uDef.buildcostmetal * 0.5
		uDef.maxdamage = uDef.buildcostmetal * 12.5
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Calculate mincloakdistance based on unit footprint size
	--

	local sqrt = math.sqrt

	if uDef.cancloak == true then
		local fx = uDef.footprintx and tonumber(uDef.footprintx) or 1
		local fz = uDef.footprintz and tonumber(uDef.footprintz) or 1
		local radius = 8 * sqrt((fx * fx) + (fz * fz))
		if uDef.customparams and uDef.customparams.decloakradiusmodifier then
			uDef.mincloakdistance = (radius * uDef.customparams.decloakradiusmodifier)
		else
			uDef.mincloakdistance = (radius * 6)
		end
		
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Spring Kludge Removal
	-- 
	uDef.activateWhenBuilt  = true 

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	
	--Set reverse velocity automatically
	if uDef.maxvelocity then
		uDef.maxreversevelocity = uDef.maxvelocity * 0.75
	end

	--Override groundplate used
	if uDef.usegrounddecal == true then
		uDef.buildinggrounddecaltype = "groundplate.dds"
	end
	
	if uDef.customparams and uDef.customparams.isupgraded == true then
		uDef.maxdamage = uDef.maxdamage * 1.20
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Turn off nanospray globally
	if uDef.shownanospray then
		uDef.shownanospray = false
	end
		
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- process weapondef
function WeaponDef_Post(name, wDef)
	
	-- weapon reloadTime and stockpileTime were seperated in 77b1
	if (tobool(wDef.stockpile) and (wDef.stockpiletime==nil)) then
		wDef.stockpiletime = wDef.reloadtime
		--wDef.reloadtime    = 2             -- 2 seconds
	end
	
	local damageClasses		= VFS.Include("gamedata/configs/damageTypes.lua")
	local damageTypes		= damageClasses.damageTypes
	local defaultClass		= damageClasses.default
	
	weapondamage = tonumber(wDef.damage.default)
	if (weapondamage > 0) then
		if (wDef.customparams) then
			local damagetypelower
			if wDef.customparams.damagetype ~=nil then
				damagetypelower = string.lower(wDef.customparams.damagetype)
			end
			if damagetypelower == '' or damagetypelower == nil then
				damagetypelower = defaultClass
			end
			--Spring.Echo(damagetypelower)	
			--Spring.Echo(" ")	
			if damageTypes[damagetypelower]	then
				for armorClass, armorMultiplier in pairs(damageTypes[damagetypelower]) do	
					--Spring.Echo(wd.name, armorClass, weapondamage*armorMultiplier )
					wDef.damage[armorClass] = weapondamage*armorMultiplier
						-- Handle upgraded units
						if wDef.customparams and wDef.customparams.isupgraded == true then
							wDef.damage[armorClass] = wDef.damage[armorClass] * 1.20
						end
				end
			else
				Spring.Echo("!!WARNING!! Invalid damagetype: " .. damagetypelower)	
			end
		end
	end
	--Spring.Echo("_________")
	--Spring.Echo(wDefName, wDef.name)
	--for damageClass, damageValue in pairs(wDef.damage)do
	--	Spring.Echo(damageClass, damageValue)
	--end
	-- 
	
	if (tobool(wDef.ballistic) or tobool(wDef.dropped)) then
		wDef.gravityaffected = true
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Set energy cost to fire automatically
	-- There are 2 weapondef customparams used to control this
	-- oldcosttofireformula = true, will result in the original formula that did not account for weapon range to be used
	-- nocosttofire == true, will result in cost to fire being set at 0
	local weaponDefaultDamage = wDef.damage.default
	local weaponAreaOfEffect = wDef.areaofeffect or 0
	local weaponRange = wDef.range or 0
	local weaponProjectiles = wDef.projectiles or 1
	if wDef.customparams and wDef.customparams.nocosttofire == true then
		wDef.energypershot = 0
	elseif wDef.customparams and wDef.customparams.oldcosttofireforumula == true then
		local energycosttofire = weaponDefaultDamage * 0.1 * weaponProjectiles * ((weaponAreaOfEffect * 0.001) + 1)
		local function roundToFirstDecimal(energycosttofire)
			return math.floor(energycosttofire*10 + 0.5)*0.1
		end
		wDef.energypershot = energycosttofire	
	else
	--energycosttofire = weaponDefaultDamage * 0.05 * weaponProjectiles * ((weaponAreaOfEffect * 0.001)  + 1) * weaponRange^0.5 * 0.1
		local energycosttofire = weaponDefaultDamage * 0.05 * weaponProjectiles * ((weaponAreaOfEffect * 0.001)  + 1) * weaponRange^0.25 * 0.5
		local function roundToFirstDecimal(energycosttofire)
			return math.floor(energycosttofire*10 + 0.5)*0.1
		end
		wDef.energypershot = energycosttofire	
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Set up params for Point Defense turrets
	if wDef.customparams and wDef.customparams.ispointdefenselaser == true then
		wDef.areaofeffect = 0
		wDef.avoidfeature = false
		wDef.avoidfriendly = false
		wDef.collidefeature = false
		wDef.collidefriendly = false
		wDef.corethickness = 0.2
		wDef.duration = 0.2
		wDef.explosiongenerator = [[custom:genericshellexplosion-small-sparks-burn]]
		wDef.falloffrate = 1
		wDef.impulsefactor = 0
		wDef.interceptedbyshieldtype = 4
		wDef.minintensity = 1
		wDef.name = [[Point Defense Laser]]
		wDef.range = 650
		wDef.reloadtime = 0.25
		wDef.weapontype = [[LaserCannon]]
		wDef.rgbcolor = [[0 0.5 1]]
		wDef.rgbcolor2 = [[1 1 1]]
		wDef.soundtrigger = true
		wDef.soundstart = [[pointdefensefire.wav]]
		wDef.texture1 = [[shot]]
		wDef.texture2 = [[empty]]
		wDef.thickness = 2
		wDef.tolerance = 1000
		wDef.turret = true
		wDef.weaponvelocity = 1500
		wDef.customparams.damagetype = [[pdlaser]]
		wDef.damage.default = 6.25
	end	
end


--------------------------
-- MODOPTIONS
-------------------------

-- process modoptions (last, because they should not get baked)
function ModOptions_Post (UnitDefs, WeaponDefs)
	if (Spring.GetModOptions) then
	local modOptions = Spring.GetModOptions()

		--------------------------------------------------------------------------------
		-- Gameplay Speed (Classic RTS Mode) --
		--------------------------------------------------------------------------------

		local gamePlaySpeed = modOptions.gameplayspeed or "normal"

		Spring.Echo("[Gameplay Speed] Set to " .. gamePlaySpeed)

		for id,unitDef in pairs(UnitDefs) do
			unitDef.buildtime = unitDef.buildcostmetal / 4
		end

		if gamePlaySpeed == "veryslow" then
			for id,unitDef in pairs(UnitDefs) do
				if unitDef.maxvelocity then
					unitDef.maxvelocity = unitDef.maxvelocity * 0.5
				end
				if unitDef.buildcostmetal then
					unitDef.buildcostmetal = unitDef.buildcostmetal * 1.5
				end
			end
			for id,weaponDef in pairs(WeaponDefs) do
				if weaponDef.weaponvelocity then
					--Spring.Echo ("//")
					--Spring.Echo (weaponDef.name)
					--Spring.Echo (weaponDef.weaponvelocity)
					weaponDef.weaponvelocity = weaponDef.weaponvelocity * 0.5
					--Spring.Echo ("••")
					--Spring.Echo (weaponDef.name)
					--Spring.Echo (weaponDef.weaponvelocity)
					--Spring.Echo ("\\")
				end
			end
		end

		if gamePlaySpeed == "slow" then
			for id,unitDef in pairs(UnitDefs) do
				if unitDef.maxvelocity then
					unitDef.maxvelocity = unitDef.maxvelocity * 0.75
				end
				if unitDef.buildcostmetal then
					unitDef.buildcostmetal = unitDef.buildcostmetal * 1.25
				end
			end
			for id,weaponDef in pairs(WeaponDefs) do
				if weaponDef.weaponvelocity then
					weaponDef.weaponvelocity = weaponDef.weaponvelocity * 0.75
				end
			end
		end

		if gamePlaySpeed == "fast" then
			for id,unitDef in pairs(UnitDefs) do
		--	Spring.Echo(unitDef.buildcostmetal)
				unitDef.buildtime = 5
			end
		end
	end
end