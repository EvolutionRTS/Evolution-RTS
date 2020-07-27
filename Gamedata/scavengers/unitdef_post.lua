-- this file gets included in alldefs_post.lua

local scavUnit = {}
for name,uDef in pairs(UnitDefs) do
    scavUnit[#scavUnit+1] = name..'_scav'
end

local rana = math.random(3,1000)
local ranb = math.random(2,a)
local ranc = math.random(1,b)



function scav_Udef_Post(name, uDef)
	if not uDef.customparams then
		uDef.customparams = {}
	end
	
	if not uDef.customParams then
		uDef.customParams = {}
	end
	----------------- EVO stuff
	
	if uDef.customParams then
		--uDef.customParams.ProvideTech = [[tech0, tech1, tech2, tech3]]
		uDef.customparams.supply_granted = 1
		uDef.customparams.supply_cost = 0
	end
	----------------- End of EVO stuff

	

	-- add unit category
	uDef.category = uDef.category..' SCAVENGER'

	-- add model vertex displacement

	--local udefVertDisp = uDef.customparams.vertdisp1 or 0
	--uDef.customparams.vertdisp = 2.0 * udefVertDisp
	uDef.customparams.healthlookmod = 0.40

	-- make barrelshot purple

	if uDef.sfxtypes then
		-- make barrelshot purple
		-- if uDef.sfxtypes.explosiongenerators then
			-- for k,v in pairs(uDef.sfxtypes.explosiongenerators) do
				-- if string.find(v, 'barrelshot') then
					-- uDef.sfxtypes.explosiongenerators[k] = v..'-purple'
				-- end
			-- end
		-- end
		-- make deathcegs purple
		-- if uDef.sfxtypes.pieceexplosiongenerators then
			-- for k,v in pairs(uDef.sfxtypes.pieceexplosiongenerators) do
				-- if string.find(v, 'deathceg') then
					-- uDef.sfxtypes.pieceexplosiongenerators[k] = v..'-purple'
				-- end
			-- end
		-- end
	end
	-- make unit explosion purple
	if uDef.explodeas and uDef.explodeas ~= "bossScavengerExplosionNuke" and uDef.explodeas ~= "mediumScavengerExplosionNuke" then
		uDef.explodeas = "mediumScavengerExplosionGeneric"
	end
	if uDef.selfdestructas and uDef.selfdestructas ~= "bossScavengerExplosionNuke" and uDef.selfdestructas ~= "mediumScavengerExplosionNuke" then
		uDef.selfdestructas = "mediumScavengerExplosionGeneric"
	end

	-- replace buillists with _scav units
	if uDef.buildoptions then
        for k, v in pairs(uDef.buildoptions) do
            if UnitDefs[v..'_scav'] then
                uDef.buildoptions[k] = v..'_scav'
            end
        end
    end

	-- add Scavenger name prefix to wrecks
	if uDef.featuredefs then
		if uDef.featuredefs.dead then
			if uDef.featuredefs.dead.description then
				uDef.featuredefs.dead.description = "Scavenger "..uDef.featuredefs.dead.description
			end
			-- if uDef.featuredefs.dead.metal then
				-- uDef.featuredefs.dead.metal = math.ceil(uDef.featuredefs.dead.metal*0.5)
			-- end
		end
		if uDef.featuredefs.heap then
			if uDef.featuredefs.heap.description then
				uDef.featuredefs.heap.description = "Scavenger "..uDef.featuredefs.heap.description
			end
			-- if uDef.featuredefs.heap.metal then
				-- uDef.featuredefs.heap.metal = math.ceil(uDef.featuredefs.heap.metal*0.5)
			-- end
		end
	end

	-- add Scavenger name prefix to units
	if uDef.name then
		uDef.name = "Scavenger "..uDef.name
	end

	
	
	if uDef.buildcostenergy then
		uDef.buildcostenergy = math.ceil(uDef.buildcostenergy*2)
	end

	if uDef.buildcostmetal then
		uDef.buildcostmetal = math.ceil(uDef.buildcostmetal*2)
	end

	if uDef.energymake then
		uDef.energymake = math.ceil(uDef.energymake*2)
	end

	if uDef.metalmake then
		uDef.metalmake = math.ceil(uDef.metalmake*2)
	end

	if uDef.maxdamage then
		uDef.maxdamage = math.ceil(uDef.maxdamage*2)
	end

	if uDef.maxvelocity then
		uDef.maxvelocity = uDef.maxvelocity*0.5
	end
	
	if uDef.maxreversevelocity then
		uDef.maxreversevelocity = uDef.maxreversevelocity*0.1
	end

	if uDef.sightdistance then
		uDef.sightdistance = math.ceil(uDef.sightdistance*1.5)
	end
	
	if uDef.radardistancejam then
		uDef.radardistancejam = math.ceil(uDef.radardistancejam*1.5)
	end

	if uDef.maxdamage then
		uDef.autoheal = math.ceil(math.sqrt(uDef.maxdamage/60))
		uDef.idleautoheal = math.ceil(math.sqrt(uDef.maxdamage/60))
	else
		uDef.autoheal = 3
		uDef.idleautoheal = 3
	end

	if uDef.turnrate then
		uDef.turnrate = uDef.turnrate*0.1
	end

	if uDef.turninplaceanglelimit then
		uDef.turninplaceanglelimit = 360
	end

	-- don't let players get scav constructors
	if uDef.buildoptions then
		uDef.capturable = false
		if uDef.featuredefs then
			if uDef.featuredefs.dead then
				uDef.featuredefs.dead.resurrectable = 0
			end
			if uDef.featuredefs.heap then
				uDef.featuredefs.heap.resurrectable = 0
			end
		end
	end
	
	return uDef

end
