function widget:GetInfo()
	return {
		name = "Local Team Colors",
		desc = "Makes neat team color scheme - you teal, allies blueish, enemies reddish",
		author = "Licho",
		date = "February, 2010",
		license = "GPL like rest of CA",
		layer = -10000,
		enabled = true,
	}
end


local myColor = { 0, 1, 0 }

local gaiaColor = { 0.8, 0.8, 0.8 }

local allyColors = {
  { 0.0, 0.0, 0.8 },
  { 184/255, 1.0, 228/255 },
  { 0.05, 0.96, 0.95 },
  { 0.0, 106/255, 1 },
  { 0.0, 97/255, 40/255 },
  { 151/255, 199/255, 219/255 },
  { 92/255, 91/255, 189/255},
  { 34/255, 156/255, 149/255},
  { 88/255,46/255,1 },
}

local enemyColors = {
  { 1.0, 0.0, 4/255 },
  { 1, 191/255, 0 },
  { 1.0, 0.0, 225/255 },
  { 132/255, 0.0, 1.0 },
  { 158/255, 42/255, 0.0 },
  { 153/255, 0.0, 13/255 },
  { 238/255, 1.0, 3/255 },
  { 250/255, 127/255, 225/255 },
  { 183/255, 99/255, 103/255 },
}


local function SetNewTeamColors() 
	local gaia = Spring.GetGaiaTeamID()
	Spring.SetTeamColor(gaia, unpack(gaiaColor))
	
	local myAlly = Spring.GetMyAllyTeamID()
	local myTeam = Spring.GetMyTeamID()

	local a, e = 0, 0
	for _, teamID in ipairs(Spring.GetTeamList()) do
		local _,_,_,_,_,allyID = Spring.GetTeamInfo(teamID)
		if (teamID == myTeam) then 
			Spring.SetTeamColor(teamID, unpack(myColor))
		elseif (allyID == myAlly) then
			a = (a % #allyColors) + 1
			Spring.SetTeamColor(teamID, unpack(allyColors[a]))
		else
			e = (e % #enemyColors) + 1
			Spring.SetTeamColor(teamID, unpack(enemyColors[e]))
		end
	end
end


local function ResetOldTeamColors()
	for _,team in ipairs(Spring.GetTeamList()) do
		Spring.SetTeamColor(team,Spring.GetTeamOrigColor(team))
	end
end


function widget:Initialize()
	SetNewTeamColors()
end

function widget:Shutdown()
	ResetOldTeamColors()
end

