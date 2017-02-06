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

	for name, ud in pairs(UnitDefs) do
	  if (tobool(ud.canfly) and not tobool(ud.istransport)) then
		ud.collide = false
	  end
	end


	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Calculate mincloakdistance based on unit footprint size
	--

	local sqrt = math.sqrt

	for name, ud in pairs(UnitDefs) do
	  if (not ud.mincloakdistance) then
		local fx = ud.footprintx and tonumber(ud.footprintx) or 1
		local fz = ud.footprintz and tonumber(ud.footprintz) or 1
		local radius = 8 * sqrt((fx * fx) + (fz * fz))
		ud.mincloakdistance = (radius + 48)
	  end
	end


	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Spring Kludge Removal
	-- 
	for name, ud in pairs(UnitDefs) do
		ud.activateWhenBuilt  = true 
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	
	--Set reverse velocity automatically
		for id,unitDef in pairs(UnitDefs) do
			if unitDef.maxvelocity then
				unitDef.maxreversevelocity = unitDef.maxvelocity * 0.75
			end
		end

	--Override groundplate used
	for id,unitDef in pairs(UnitDefs) do
		if unitDef.usegrounddecal == true then
			unitDef.buildinggrounddecaltype = "groundplate.dds"
		end
	end
		
end

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
	
	if wDef.customparams and wDef.customparams.nocosttofire == true then
		wDef.energypershot = 0
	elseif wDef.customparams and wDef.customparams.oldcosttofireforumula == true then
		local weaponDefaultDamage = wDef.damage.default
		local weaponAreaOfEffect = wDef.areaofeffect or 0
		local weaponRange = wDef.range or 0
		local energycosttofire = weaponDefaultDamage * 0.1 * ((weaponAreaOfEffect * 0.001) + 1)
		local function roundToFirstDecimal(energycosttofire)
			return math.floor(energycosttofire*10 + 0.5)*0.1
		end
		wDef.energypershot = energycosttofire	
	else
		local weaponDefaultDamage = wDef.damage.default
		local weaponAreaOfEffect = wDef.areaofeffect or 0
		local weaponRange = wDef.range or 0
		local energycosttofire = weaponDefaultDamage * 0.05 * ((weaponAreaOfEffect * 0.001) + 1) * (weaponRange * 0.005)
		local function roundToFirstDecimal(energycosttofire)
			return math.floor(energycosttofire*10 + 0.5)*0.1
		end
		wDef.energypershot = energycosttofire	
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