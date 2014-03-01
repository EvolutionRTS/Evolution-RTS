function gadget:GetInfo()
   return {
	  name      = "Weapon Tech Levels",
	  desc      = "Makes certain weapons better after technologies are unlocked",
	  author    = "Anarchid",
	  date      = "28th February 2014",
	  license   = "GNU GPL, v2 or later",
	  layer     = -1,
	  enabled   = true,
   }
end
 
-- Entire gadget is synced
if not gadgetHandler:IsSyncedCode() then
		return
end
 
-- list of upgrade class names to tech levels, automatically initialized from weapondef customparam "upgradeClass"
local upgrades = {}
 
-- table to contain each team's current level in each tech. Ideally should be somehow available to widgets, for example via TeamRulesParams.
-- however, rulesparams cannot have tables, so the table would have to be serialized... cba atm.
local teamUpgradeLevels = {}
 
function gadget:Initialize()
		local upgradeClassCount = 0;
		-- filter distinct upgrade classes from all weapondef customparams
		for i=1,#WeaponDefs do
				local wd = WeaponDefs[i]
				if wd.customParams then
						local class = wd.customParams.upgradeclass;
						if class then
								if not upgrades[class] then
									upgrades[class] = true 
									upgradeClassCount = upgradeClassCount + 1;
								end
						end
				end
		end
 
		-- assign zero tech level in each tech to each team    
		local teams = Spring.GetTeamList()
		for i=1, #teams do
			teamUpgradeLevels[teams[i]] = {}
			for upgrade,_ in pairs(upgrades) do
					teamUpgradeLevels[teams[i]][upgrade] = 0;
			end
		end
		
		Spring.Echo('initialized weapon upgrade system with '..upgradeClassCount..' techs and '..#teams..' teams');
end
 
 
-- Currently upgrades are units like any other. This is simply the easiest way to do them.
-- If you want to do it any other way, just call GG.UpgradeComplete on your appropriate event.
function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
		local ud = UnitDefs[unitDefID];
		if ud.customParams then
				local tech = ud.customParams.upgradetech;
				local level = tonumber(ud.customParams.upgradelevel);
			
				if tech and level then
						GG.UpgradeComplete(tech, level, teamID);
				end
		end
end
 
function GG.UpgradeComplete(techName, level, teamID)
		level = math.max(teamUpgradeLevels[teamID][techName], level);
		teamUpgradeLevels[teamID][techName] = level;
end
 
function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
		local wd = WeaponDefs[weaponDefID];
		
		if wd and wd.customParams then  
			local weaponTech = wd.customParams.upgradeclass or false;
		   
			if (weaponTech) then
					local techModifier = (teamUpgradeLevels[attackerTeam][weaponTech] or 0);
					Spring.Echo ("Techmodifier:" .. techModifier)
					damage = damage*techModifier;
					Spring.Echo ("Damage:" .. damage)
			end
		end
	   
		return damage;
end

