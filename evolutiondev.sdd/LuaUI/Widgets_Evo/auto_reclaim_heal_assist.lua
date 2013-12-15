-----------------------------------
-- Author: Johan Hanssen Seferidis
--
-- Comments: Sets all idle units that are not selected to fight. That has as effect to reclaim if there is low metal
--					 , repair nearby units and assist in building if they have the possibility.
--					 If you select the unit while it is being idle the widget is not going to take effect on the selected unit.
--
-------------------------------------------------------------------------------------

function widget:GetInfo()
	return {
		name = "Auto Reclaim/Heal/Assist",
		desc = "Makes idle unselected builders/rez/com/nanos to reclaim metal if metal bar is not full, repair nearby units and assist in building",
		author = "Pithikos/smoth",
		date = "Nov 21, 2010, last update 12/15/2013",
		license = "GPLv3",
		layer = 0,
		enabled = true
	}
end

--------------------------------------------------------------------------------------
local spEcho			= Spring.Echo
local spGetUnitPos		= Spring.GetUnitPosition
local spOrderUnit		= Spring.GiveOrderToUnit
local spGetUnitTeam		= Spring.GetUnitTeam
local spIsUnitSelected	= Spring.IsUnitSelected

local gameInSecs			= 0
local lastOrderGivenInSecs	= 0
local idleReclaimers={} --reclaimers because they all can reclaim

myTeamID=-1;

--------------------------------------------------------------------------------------


--Initializer
function widget:Initialize()
	--disable widget if I am a spec
	local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
	if spec then
		widgetHandler:RemoveWidget()
		return false
	end
	myTeamID = Spring.GetMyTeamID()                         --get my team ID
end


--Give reclaimers the FIGHT command every second
function widget:GameFrame(n)
	if n%30 == 0 then
		if WG.Cutscene and WG.Cutscene.IsInCutscene() then
			return
		end
		for unitID in pairs(idleReclaimers) do
			local x, y, z = spGetUnitPos(unitID)                --get unit's position
			if (not spIsUnitSelected(unitID)) then              --if unit is not selected
				spOrderUnit(unitID, CMD.FIGHT, { x, y, z }, {})   --command unit to reclaim
			end
		end
	end
end


--Add reclaimer to the register
function widget:UnitIdle(unitID, unitDefID, unitTeam)
	--check if unit is mine
	if (myTeamID == spGetUnitTeam(unitID)) then					
		local unitDef = UnitDefs[unitDefID]		
		
		--no factories ***
		if (unitDef.isFactory) then 
			return 
		end	
		
		--check if unit can reclaim		
		if (unitDef.isBuilder) then
			--add unit to register		
			idleReclaimers[unitID]=true					
			--spEcho("<auto_reclaim_heal_assist>: registering unit "..unitID.." as idle")
		end
	end
end


--Unregister reclaimer once it is given a command
function widget:UnitCommand(unitID)
	--spEcho("<auto_reclaim_heal_assist>: unit "..unitID.." got a command") --Â¤debug
	if idleReclaimers[unitID] then
		idleReclaimers[unitID]=nil
		--spEcho("<auto_reclaim_heal_assist>: unregistering unit "..reclaimerID.." as idle")
	end
end