function gadget:GetInfo()
	return {
		name = "unit_damageovertime",
		desc = "",
		author = "",
		date = "11/14/2012",
		license = "Public Domain",
		layer = 0,
		enabled = false
	}
end

local dottedUnits		= {}
local dotsAttackedBy	= {}

local dotTime	= 10
local dotDamage	= 500
local effect			= "sparklered"
local overkillEffect	= "sparklegreen"
local hurtAllies		= false

local dotWeapons		=	{
	["wafflecaones1"] = true,	
	["wafflecones"] = true,
	}

local spSpawnCEG			= Spring.SpawnCEG
local spGetUnitTeam			= Spring.GetUnitTeam
local spGetUnitHealth		= Spring.GetUnitHealth
local spSetUnitHealth		= Spring.SetUnitHealth
local spGetUnitIsDead		= Spring.GetUnitIsDead
local spGetUnitBasePosition	= Spring.GetUnitBasePosition
local spDestroyUnit	= Spring.DestroyUnit

if (gadgetHandler:IsSyncedCode()) then
--start synced
	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		local weaponName	= WeaponDefs[weaponDefID].name
		local unitName		= UnitDefs[unitDefID].name
		local validtarget	= true
		
		if spGetUnitTeam(unitID) == attackerTeam then
		
			if hurtAllies == false then
				validtarget = false
			end
		end
		
		Spring.Echo(validtarget)
		
		if dotWeapons[weaponName] and validtarget then
			dottedUnits[unitID]	= dotTime
			dotsAttackedBy[unitID] = attackerID
		end
	end

	function gadget:GameFrame(frames)
		--every second
		if frames %30 <0.1 then
			-- counts down the dot.
			for unitID, _ in pairs(dottedUnits) do
				if dottedUnits[unitID] > 0 then 
					local currentHP, maxHP = spGetUnitHealth(unitID)
					if (currentHP ~= nil) then
						local x,y,z = spGetUnitBasePosition(unitID)
							
						dottedUnits[unitID] =	dottedUnits[unitID] - 1
						
						if (currentHP > dotDamage) then
							-- if we are taking dot damage
							spSetUnitHealth(unitID, currentHP - dotDamage)
							spSpawnCEG(effect,x,y,z)						
						elseif (currentHP == dotDamage) then
							--if we JUST enough to die at 0 health
							spDestroyUnit(unitID, dotsAttackedBy[unitID])
							dottedUnits[unitID] = 0	
							spSpawnCEG(effect,x,y,z)	
						else
							--OUCH!!!
							spDestroyUnit(unitID, dotsAttackedBy[unitID])
							dottedUnits[unitID] = 0	
							spSpawnCEG(overkillEffect,x,y,z)						
						end
					else
						--somehow the hp was nil, fuggitaboutit
						dottedUnits[unitID] = 0
						dotsAttackedBy[unitID] = nil						
					end
				end
			end
		end	
	end

end
--end synced