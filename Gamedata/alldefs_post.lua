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
	
	-- Allow all unit to see planes high above
	-- This ties in with the global Cylinder Targetting
	-- Default airsightdistance is sightdistance * 1.5
	uDef.airsightdistance = uDef.sightdistance * 2
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Set building Mask 0 for all mobile units
	--
	if uDef.customparams and uDef.customparams.unittype == "mobile" then
		uDef.buildingmask = 0
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
	-- Set building start sound for all builders
	--
	
	if uDef.builder == true and uDef.sounds then
		uDef.sounds.build = "miscfx/buildstart.wav"
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Calculate mincloakdistance based on unit footprint size
	--

	local sqrt = math.sqrt

	local fx = uDef.footprintx and tonumber(uDef.footprintx) or 1
	local fz = uDef.footprintz and tonumber(uDef.footprintz) or 1
	local radius = 8 * sqrt((fx * fx) + (fz * fz))
	if uDef.customparams and uDef.customparams.decloakradiusmodifier then
		uDef.mincloakdistance = (radius * uDef.customparams.decloakradiusmodifier)
	else
		uDef.mincloakdistance = (radius * 6)
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
	
	-- Cylinder Targeting for everything
	wDef.cylindertargeting = 128
	
	-- weapon reloadTime and stockpileTime were seperated in 77b1
	if (tobool(wDef.stockpile) and (wDef.stockpiletime==nil)) then
		wDef.stockpiletime = wDef.reloadtime
		--wDef.reloadtime    = 2             -- 2 seconds
	end
	
	if (tobool(wDef.ballistic) or tobool(wDef.dropped)) then
		wDef.gravityaffected = true
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	-- Set up params for Point Defense turrets
	if wDef.customparams and wDef.customparams.ispointdefenselaser == true then
		if wDef.customparams.primaryweaponrange ~= nil then
			primaryWeaponRange = tonumber(wDef.customparams.primaryweaponrange)
			else
			primaryWeaponRange = 0
		end
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
		wDef.projectiles = 1
		wDef.range = primaryWeaponRange
		wDef.reloadtime = 0.25
		wDef.weapontype = [[LaserCannon]]
		wDef.rgbcolor = [[0 0.5 1]]
		wDef.rgbcolor2 = [[1 1 1]]
		wDef.soundtrigger = true
		wDef.soundstart = [[weapons/pointdefensefire.wav]]
		wDef.texture1 = [[shot]]
		wDef.texture2 = [[empty]]
		wDef.thickness = 2
		wDef.tolerance = 1000
		wDef.turret = true
		wDef.weaponvelocity = 1500
		wDef.customparams.damagetype = [[pdlaser]]
		wDef.damage.default = 6.25
		wDef.energypershot = math.floor(wDef.damage.default * 0.05 * wDef.projectiles * ((wDef.areaofeffect * 0.001) + 1) * wDef.range^0.25 * 0.5 * 10 + 0.5) * 0.1
	end	
end


--------------------------
-- MODOPTIONS
-------------------------

-- process modoptions (last, because they should not get baked)
function ModOptions_Post (UnitDefs, WeaponDefs)
	if (Spring.GetModOptions) then
	local modOptions = Spring.GetModOptions()
	
		for id,unitDef in pairs(UnitDefs) do
			unitDef.buildcostmetal = unitDef.buildcostmetal * 2
			
			if unitDef.customparams.corpse == "energycore" then
				unitDef.corpse = "ammobox"
			end
			
		-- Set building Hitpoints
			if unitDef.customparams then
				if unitDef.customparams.unittype == "building" then
					unitDef.maxdamage = unitDef.buildcostmetal * 5
				end
				if unitDef.customparams.unittype == "turret" then
					unitDef.maxdamage = unitDef.buildcostmetal * 5
				end
				if unitDef.customparams.unittype == "shield" then
					unitDef.maxdamage = unitDef.buildcostmetal * 5
				end
			end
		end
	
		--------------------------------------------------------------------------------
		-- Process Upgrades --
		--------------------------------------------------------------------------------
	
		for id,uDef in pairs(UnitDefs) do
			-- Handle upgraded units HP and Max Speed
			if uDef.customparams and uDef.customparams.isupgraded == "1" then
				uDef.maxdamage = uDef.maxdamage * 1.20
				if uDef.maxvelocity then
					uDef.maxvelocity = uDef.maxvelocity * 0.95
				end
			end
			if uDef.customparams and uDef.customparams.isupgraded == "2" then
				uDef.maxdamage = uDef.maxdamage * 1.35
				if uDef.maxvelocity then
					uDef.maxvelocity = uDef.maxvelocity * 0.90
				end
			end
			if uDef.customparams and uDef.customparams.isupgraded == "3" then
				uDef.maxdamage = uDef.maxdamage * 1.50
				if uDef.maxvelocity then
					uDef.maxvelocity = uDef.maxvelocity * 0.85
				end
			end
		end
	
		for id,wDef in pairs(WeaponDefs) do
			-- Handle upgraded units weapon reload times
			if wDef.customparams and wDef.customparams.isupgraded == "1" then
				wDef.reloadtime = wDef.reloadtime * 0.85
				wDef.damage.default = wDef.damage.default * 1.20
				if wDef.exteriorshield == true and wDef.shieldpower < 0 then
					wDef.shieldpower = wDef.shieldpower * 1.20
				end
			end
			if wDef.customparams and wDef.customparams.isupgraded == "2" then
				wDef.reloadtime = wDef.reloadtime * 0.70
				wDef.damage.default = wDef.damage.default * 1.35
				if wDef.exteriorshield == true and wDef.shieldpower < 0 then
					wDef.shieldpower = wDef.shieldpower * 1.35
				end
			end
			if wDef.customparams and wDef.customparams.isupgraded == "3" then
				wDef.reloadtime = wDef.reloadtime * 0.65
				wDef.damage.default = wDef.damage.default * 1.50
				if wDef.exteriorshield == true and wDef.shieldpower < 0 then
					wDef.shieldpower = wDef.shieldpower * 1.50
				end
			end
			
			--Handle Shields
			if wDef.customparams and wDef.customparams.isshieldupgraded == "1" then
				if wDef.exteriorshield == true then
					wDef.shieldpower = wDef.shieldpower * 1.20
				end
			end
			if wDef.customparams and wDef.customparams.isshieldupgraded == "2" then
				if wDef.exteriorshield == true then
					wDef.shieldpower = wDef.shieldpower * 1.35
				end
			end
			if wDef.customparams and wDef.customparams.isshieldupgraded == "3" then
				if wDef.exteriorshield == true then
					wDef.shieldpower = wDef.shieldpower * 1.50
				end
			end
	
		--------------------------------------------------------------------------------
		--------------------------------------------------------------------------------
		
		--------------------------------------------------------------------------------
		-- Process Armortypes --
		--------------------------------------------------------------------------------
		
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
				local energycosttofire = math.floor(weaponDefaultDamage * 0.1 * weaponProjectiles * ((weaponAreaOfEffect * 0.001) + 1)*10 + 0.5)*0.1
				wDef.energypershot = energycosttofire	
			else
			--energycosttofire = weaponDefaultDamage * 0.05 * weaponProjectiles * ((weaponAreaOfEffect * 0.001)  + 1) * weaponRange^0.5 * 0.1
				local energycosttofire = math.floor(weaponDefaultDamage * 0.05 * weaponProjectiles * ((weaponAreaOfEffect * 0.001)  + 1) * weaponRange^0.25 * 0.5*10 + 0.5)*0.1
				wDef.energypershot = energycosttofire	
			end
			
			--Set shield energy cost to recharge
			if wDef.exteriorshield == true then
				if wDef.customparams and wDef.customparams.nocosttofire == true then
					wDef.shieldpowerregenenergy = 0
				else
					wDef.shieldpowerregenenergy = math.floor(wDef.shieldpowerregen * 0.05 * wDef.shieldradius^0.25 * 0.5 * 10 + 0.5) * 0.1
					--Spring.Echo("Energy usage is " .. wDef.shieldpowerregenenergy)
				end		
			end
		end
		--------------------------------------------------------------------------------
		--------------------------------------------------------------------------------

		for id,unitDef in pairs(UnitDefs) do
			for id,weaponDef in pairs(WeaponDefs) do
				weaponDef.name = unitDef.name .. [[ Weapon]]
				--Spring.Echo(weaponDef.name)
			end
		end
		
		--------------------------------------------------------------------------------
		-- Gameplay Speed (Classic RTS Mode) --
		--------------------------------------------------------------------------------

		for id,unitDef in pairs(UnitDefs) do
			unitDef.buildtime = unitDef.buildcostmetal / 4			
		end
	end
end