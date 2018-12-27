AiModeHandler = class(Module)

function AiModeHandler:Name()
	return "AiModeHandler"
end

function AiModeHandler:internalName()
	return "aimodehandler"
end

local UDC = function(teamID, DefID)
	return #Spring.GetTeamUnitsByDefs(ai.id, DefID)
end
local UDN = UnitDefNames
--local advBuilders = {UDN.armacv.id, UDN.armack.id, UDN.armaca.id, UDN.coracv.id, UDN.corack.id, UDN.coraca.id}
local modenames = {"balanced", "t1", "tech"}
function AiModeHandler:Init()
	self.resources = {metal = {}, energy = {}}
	for res, tab in pairs(self.resources) do
		local c, s, p, i, e = Spring.GetTeamResources(self.ai.id, res)
		self.resources[res] = {c = c, s = s, p = p, i = i, e = e}
	end
	math.randomseed( os.time() + self.ai.id )
	math.random(); math.random(); math.random()
	--self:PickASide(math.random(1,6))
	--self:CreateWantedTechTree(math.random(1,12),math.random(1,12))
	--local count = #Spring.GetTeamList(self.ai.allyId)
	--if count and count > 1 then
		--self:Mode(math.random(1,count)%3 + 1)
	--else
		self:Mode(1)
	--end
end

function AiModeHandler:Update()
	local frame = Spring.GetGameFrame()
	if frame%15 == self.ai.id%15 then
		for res, tab in pairs(self.resources) do
			local c, s, p, i, e = Spring.GetTeamResources(self.ai.id, res)
			if Spring.GetTeamRulesParam(self.ai.id,'mmUse') and tonumber(Spring.GetTeamRulesParam(self.ai.id,'mmUse')) then
				e = e - tonumber(Spring.GetTeamRulesParam(self.ai.id,'mmUse'))
			end
			self.resources[res] = {c = c, s = s, p = p, i = i, e = e}
		end
	end
end


function AiModeHandler:Mode(i)
		self.perraider = 30
		self.perskirmer = 40
		self.nodefenderscounter = math.random(1200,2400)
		self.noregroupcounter = self.nodefenderscounter + math.random(600,1200)
end

-- function AiModeHandler:PickASide(i)
	-- if i == 1 then
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommanderbattleai.id)
		-- self.faction = "OC"
	-- elseif i == 2 then
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommanderbuildai.id)
		-- self.faction = "OC"
	-- elseif i == 3 then
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommandercloakai.id)
		-- self.faction = "OC"
	-- elseif i == 4 then
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommanderfactoryai.id)
		-- self.faction = "OC"
	-- elseif i == 5 then
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommandershieldai.id)
		-- self.faction = "OC"
	-- else
		-- Spring.SetTeamRulesParam(self.ai.id, "startUnit", UnitDefNames.ecommanderhealerai.id)
		-- self.faction = "OC"
	-- end
-- end