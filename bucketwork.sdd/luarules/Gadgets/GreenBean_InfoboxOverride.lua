function gadget:GetInfo()
	return {
		name = "Info box over ride",
		desc = "The whole resource system",
		author = "KDR_11k (David Becker), Smoth",
		date = "2010-4-11",
		license = "PD",
		layer = 255,
		enabled = true
	}
end

local spEditUnitCmdDesc     = Spring.EditUnitCmdDesc
local spFindUnitCmdDesc     = Spring.FindUnitCmdDesc

local unitCost 				= {} 
local unitToolTips			= {} 
local unitbBuildToolTips	= {} 

local categoryLexicon = {
	SUB			= "Submarines",
	AMPHIB		= "Amphibious Ground",
	LIGHT		= "Light Armored",
	ARMORED		= "Heavily Armored",
	VTOL		= "Aircraft",
	BUILDING	= "Buildings",
	NOTAIR		= "Land units",
}

local categoryLexiconCount = 0 

for _,_ in pairs(categoryLexicon) do
	categoryLexiconCount = categoryLexiconCount +1
end

local metColor
local nrgColor
			
local epColor
local bmtColor
local ltColor
local mdColor
local hvColor
local blColor

local LmtColor	= "\255\100\255\100"

if (gadgetHandler:IsSyncedCode()) then
		
	function BuildToolTip(unitDefID, showRes)
		local unitMetal	= ""
		local metalText	= ""
		local eneText	= ""
		local btText	= ""
		local toolText	= ""
		local ulText	= ""
		local ArText	= ""
		local wepText	= ""
		local sqdText	= ""
		local trgtText	= "\nOnly targets\255\150\250\150"

		unitPow = ( tonumber(UnitDefs[unitDefID].customParams.power)  or nil)

		--Spring.Echo(UnitDefs[unitDefID].humanname)
		if (showRes == 0) then		
			unitMetal = ( tonumber(UnitDefs[unitDefID].metalCost )  or 0)
			
			if(unitMetal and unitMetal > 0)then	
				metalText = metColor .. "  Metal: "	..	unitMetal		
			end
		end		
		
		if( unitPow and unitPow < 0) then 
			eneText = nrgColor .. 0 - unitPow.." Power use, "	
		elseif(unitPow and unitPow > 0) then
			eneText = nrgColor .. "+"..unitPow.." Power, "	
		end

		if(GG.squadType and GG.squadType[unitDefID]) then
			if (UnitDefs[unitDefID].customParams and UnitDefs[unitDefID].customParams.loosesquad ) then
				sqdText = "built as a group of " .. #GG.squadType[unitDefID]+1  .. "\n"
			else
				sqdText = "built as a squad of " .. #GG.squadType[unitDefID]+1  .. "\n"
			end
		end
		
		if (UnitDefs[unitDefID].customParams and UnitDefs[unitDefID].customParams.armortype) then
			local armorClass = UnitDefs[unitDefID].customParams.armortype
			local arColor
			
			if armorClass == "heavyarmor" then
				arColor	= hvColor
			elseif armorClass == "building" then
				arColor	= blColor
			else
				arColor	= ltColor
			end
			-- get armorclass
			ArText = arColor .. "Armor type: " .. (UnitDefs[unitDefID].customParams.armortype or " Medium")
		else
			ArText = mdColor .. "Armor type: Medium"
		end
		
		wepText ="" -- make sure weptext has something in it beyond null
		frontArc =""
		
		local weaponnum = 0
		local targetsStringBuilder ={}
		local targetTypes = {}
		Spring.Echo("-= " .. UnitDefs[unitDefID].humanName .. " =-")
		for k,v in pairs(UnitDefs[unitDefID].weapons ) do
			if (type(v) == "table") then
				local Ability	= false
				
				weaponnum = weaponnum + 1
				if WeaponDefs[v.weaponDef].isShield then
					Spring.Echo("  weapon num:" .. weaponnum, "Shield",
								WeaponDefs[v.weaponDef].shieldRadius)
				end
				
				if not WeaponDefs[v.weaponDef].isShield then
					Spring.Echo("  weapon num:" .. weaponnum, "not Shield", 
								WeaponDefs[v.weaponDef].shieldRadius)
								
					for categoryName,_ in pairs (v.onlyTargets) do
						if categoryLexicon[string.upper(categoryName)]then
							targetTypes[string.upper(categoryName)] = true
						else
						--	Spring.Echo(string.upper(categoryName) .. "missing from categoryLexicon table")
						end
					end
					
					if	(WeaponDefs[v.weaponDef].customParams and 
						WeaponDefs[v.weaponDef].customParams.abilityWeapon) then
						Ability = true
					end
					
					if (WeaponDefs[v.weaponDef].damages[1] >= 2 and not Ability)	then
						wepText = wepText .. "\n" .. WeaponDefs[v.weaponDef].description .. 
							", " .. " ( " ..  WeaponDefs[v.weaponDef].damages[0] .." )"
					end
				end
				
			end 
		end

		targetsStringBuilder[1] = trgtText
					
		for targetType,_ in pairs(targetTypes) do
			targetsStringBuilder[#targetsStringBuilder+1] = categoryLexicon[targetType]
		end
		
		-- do we have more than JUST the string targets?
		if #targetsStringBuilder > 1 and #targetsStringBuilder < categoryLexiconCount +1 then
			trgtText = table.concat(targetsStringBuilder,", ")
		else -- nope, just that string, so let's empty
			trgtText = ""
		end
		
		if(UnitDefs[unitDefID].buildTime	and tonumber(UnitDefs[unitDefID].buildTime) > 0)then		
			btText = "\255\255\255\255Buildtime: "..UnitDefs[unitDefID].buildTime.." seconds"	
		end
		
		-- get general tooltip
		toolTipText = UnitDefs[unitDefID].tooltip or "-- No Unit Description found --"
		
		if toolTipText == ""  then
			toolTipText = "\255\010\255\255-- Unit Description needed --"
		end
		
		--Spring.Echo("energyText",	energyText,	"metalText", metalText)
		if (showRes == 0) then
			return "\255\200\250\200".. UnitDefs[unitDefID].humanName
			.. "\255\255\250\255" .. trgtText .. "\n\255\255\255\255" .. sqdText 
			.. toolTipText .. "\n\255\255\255\255Costs:".. metalText 
			.. "\n\255\255\255\255" .. eneText .. btText .."\n\n" 
			.. ArText .. "\n\255\255\255\255" .. wepText
		else
			return "\255\200\250\200".. UnitDefs[unitDefID].humanName
			.. "\255\255\250\255".. trgtText .. "\n\255\255\255\255"  .. sqdText
			.. toolTipText .. "\n" .. eneText .. btText.. "\n\n" 
			.. ArText  .. "\n\255\255\255\255" .. wepText
		end

	end
	
	function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
		Spring.SetUnitTooltip(unitID,unitToolTips[unitDefID])
	
		-- I have build options be sure they have their tooltips.
		for _,buildListUnit in pairs(UnitDefs[unitDefID].buildOptions) do
			
			local unitDescription = spFindUnitCmdDesc(unitID,-buildListUnit)
			--Spring.Echo(UnitDefs[unitDefID].name, spFindUnitCmdDesc(unitID,-buildListUnit))
			if buildListUnit ~= 0 and unitDescription then
				--Spring.Echo(unitID, buildListUnit, unitbBuildToolTips[buildListUnit])
				spEditUnitCmdDesc(unitID, unitDescription,{	tooltip = unitbBuildToolTips[buildListUnit]	})
			end
		end
	end
	
	function gadget:Initialize()
		metColor	= GG.colors["resource_argb"]["metal"]
		nrgColor	= GG.colors["resource_argb"]["energy"]
					
		epColor		= GG.colors["damageclass_argb"]["explosive"]
		bmtColor	= GG.colors["damageclass_argb"]["beam"]
		ltColor		= GG.colors["damageclass_argb"]["light"]
		mdColor		= GG.colors["damageclass_argb"]["medium"]
		hvColor		= GG.colors["damageclass_argb"]["heavy"]
		blColor		= GG.colors["damageclass_argb"]["building"]
		
		for k,v in pairs (UnitDefs) do
			unitToolTips[k]			= 	BuildToolTip(k,1)
			unitbBuildToolTips[k]	= 	BuildToolTip(k,0)
		end
	end
end
