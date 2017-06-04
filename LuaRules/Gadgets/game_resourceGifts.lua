function gadget:GetInfo()
	return {
		name = "Resource Gifts and Mex Income",
		desc = "Adds 1/1 resource income so that I don't have to tie it to units anymore, controls extractor income",
		author = "lurker (Dylan Petonke), Google Frog",
		date = "Sept 8 2009",
		license = "GPL",
		layer = 1,
		enabled = true
	}
end

local MEX_INCOME = 0.5 -- income of each mex
local modOptions = Spring.GetModOptions();

-- Give resources to teams
local baseIncome = 0
local baseIncomeIncrease = Spring.GetModOptions().basicincome or 3 -- add this each 1cycle

if Spring.GetModOptions().basicincomeinterval ~= nil then
	baseIncomeIncreasePeriod = Spring.GetModOptions().basicincomeinterval*60*30
else
	baseIncomeIncreasePeriod = 2.5*60*30 -- x min * 60 s/min * 30 frame/s
end

local maximumBaseIncome = Spring.GetModOptions().maxbasicincome or 15

local aiCheatHandicapMetal = { 
	["veryeasy"] =  0,
	["easy"] =  5,
	["medium"] =  10,
	["hard"] =  25,
	["insane"] =  50,
}

local aiCheatHandicapEnergy = { 
	["veryeasy"] =  10,
	["easy"] =  20,
	["medium"] =  30,
	["hard"] =  40,
	["insane"] =  50,
}

if (not gadgetHandler:IsSyncedCode()) then
	return -- No Unsynced
end

--- Detect metal extractors, manual entering of mexes possible
local mexDefs = {}

for i=1,#UnitDefs do
	local udef = UnitDefs[i]
	if (udef.extractsMetal > 0) then
		mexDefs[i] = true
	end
end

-- Initialise ally teams
local allyTeamInfo = {} -- list of players and mexes on a team

local allyTeamList = Spring.GetAllyTeamList()
local allyTeams = #allyTeamList
do
	for i=1,allyTeams do
		local allyTeamID = allyTeamList[i]
		local teamList = Spring.GetTeamList(allyTeamID)
		allyTeamInfo[allyTeamID] = {
			teams = 0,
			team = {},
			mexes = 0,
			mex = {},
			mexIndex = {},
		}
		for j=1,#teamList do
			local teamID = teamList[j]
			allyTeamInfo[allyTeamID].teams = allyTeamInfo[allyTeamID].teams + 1
			allyTeamInfo[allyTeamID].team[allyTeamInfo[allyTeamID].teams] = teamID
		end
	end
end

local function addMex(unitID)
	local allyTeam = allyTeamInfo[Spring.GetUnitAllyTeam(unitID)]
	allyTeam.mexes = allyTeam.mexes + 1
	allyTeam.mex[allyTeam.mexes] = unitID
	allyTeam.mexIndex[unitID] = allyTeam.mexes
end

local function removeMex(unitID)
	local allyTeam = allyTeamInfo[Spring.GetUnitAllyTeam(unitID)]
	allyTeam[allyTeam.mexIndex[unitID]] = allyTeam[allyTeam.mexes]
	allyTeam[allyTeam.mexes] = nil
	allyTeam.mexIndex[unitID] = nil
	allyTeam.mexes = allyTeam.mexes - 1
end

local function getMexIncomes()

	local income = {}

	for i=1,allyTeams do
		local allyTeamID = allyTeamList[i]
		local allyTeam = allyTeamInfo[allyTeamID]
		local mexCount = 0
		for i = 1, allyTeam.mexes do
			local unitID = allyTeam.mex[i]
			local stunned_or_inbuld = Spring.GetUnitIsStunned(unitID)
			if not stunned_or_inbuld then
				mexCount = mexCount + 1
			end
		end
		income[allyTeamID] = MEX_INCOME*mexCount/allyTeam.teams
	end

	return income
end

function gadget:Initialize(n)
	if ( Spring.GetModOptions().comm  == "sandbox" or Spring.GetModOptions().comm  == "feature" ) then

		for _,i in ipairs(Spring.GetTeamList()) do
			Spring.SetTeamResource(i,"e",250)
			Spring.SetTeamResource(i,"m",100)
		end
	end
	
	for _, unitID in ipairs(Spring.GetAllUnits()) do
		if (mexDefs[unitDefID]) then
			addMex(unitID)
		end
	end
end
	
function gadget:GameFrame(n)

	-- Give resources to teams
		if (n % baseIncomeIncreasePeriod) == 3 then
--			Spring.Echo("Time to increase income")
--			Spring.Echo("Old baseIncome")
--			Spring.Echo(baseIncome)
--			Spring.Echo("baseIncomeIncrease")
--			Spring.Echo(baseIncomeIncrease)
			baseIncome = baseIncome + baseIncomeIncrease
--			Spring.Echo("New baseIncome")
--			Spring.Echo(baseIncome)
		end
		if Spring.GetModOptions().mincome ~= "disabled" then
			if (n % 30) == 4 then
				local mexIncome = getMexIncomes()
				
				for _,i in ipairs(Spring.GetTeamList()) do
					local _,_,_,_,_,allyTeamID = Spring.GetTeamInfo(i)
					--if i ~= Spring.GetGaiaTeamID() then -- don't give free stuff to GAIA
	--						Spring.AddTeamResource(i,"e",1)
							--Spring.Echo("maxbaseincome is:" .. maximumBaseIncome)
							--Spring.Echo("base income increase period is: " .. baseIncomeIncreasePeriod)
					if not (baseIncome >= tonumber(maximumBaseIncome)) then
						Spring.AddTeamResource(i,"m",baseIncome + mexIncome[allyTeamID])
					else
						Spring.AddTeamResource(i,"m",tonumber(maximumBaseIncome))
					end
	--					Spring.Echo("Final baseIncome amount that is being run through AddTeamResource")
	--					Spring.Echo(baseIncome)
	--					Spring.Echo("DUN DUN DUN")
					--end
				end
			end 
		end

	--Give free resources to AI - Necessary for AI's to properly function
	if n%32 == 4 then
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local isAiTeam = select(4, Spring.GetTeamInfo(TeamID))
			if isAiTeam then
				Spring.AddTeamResource(TeamID,"e", aiCheatHandicapEnergy[modOptions.aidifficulty or "veryeasy"])
			end
		end
	end

	-- Give free unlimited power to AI
	if n==60 and GG.TechGrant then
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local teamNum,leader,isDead,isAiTeam,side,allyTeam,teamCustomOptions = Spring.GetTeamInfo(TeamID)
			if isAiTeam then
				GG.TechGrant("tech0",TeamID)
				GG.TechGrant("tech1",TeamID)
				GG.TechGrant("tech2",TeamID)
				GG.TechGrant("tech3",TeamID)
			end
		end
	end

	-- Give the AI resources according to it's difficulty Setting
	if n%160 == 1 then
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local isAiTeam = select(4, Spring.GetTeamInfo(TeamID))
			if isAiTeam then
				Spring.AddTeamResource(TeamID,"m", aiCheatHandicapMetal[modOptions.aidifficulty or "veryeasy"])
			end
		end
	end
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
	if (mexDefs[unitDefID]) then
		addMex(unitID)
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if (mexDefs[unitDefID]) then
		removeMex(unitID)
	end
end

function gadget:UnitGiven(unitID, unitDefID, teamID, oldTeamID)
	local _,_,_,_,_,newAllyTeam = Spring.GetTeamInfo(teamID)
	local _,_,_,_,_,oldAllyTeam = Spring.GetTeamInfo(oldTeamID)
	
	if (newAllyTeam ~= oldAllyTeam) then
		if (mexDefs[unitDefID]) then 
			addMex(unitID)
		end
	end
end

function gadget:UnitTaken(unitID, unitDefID, oldTeamID, teamID)
	local _,_,_,_,_,newAllyTeam = Spring.GetTeamInfo(teamID)
	local _,_,_,_,_,oldAllyTeam = Spring.GetTeamInfo(oldTeamID)
	
	if (newAllyTeam ~= oldAllyTeam) then
		if (mexDefs[unitDefID]) then 
			removeMex(unitID)
		end
	end
end
