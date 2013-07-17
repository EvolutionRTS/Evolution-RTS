
if addon.InGetInfo then
	return {
		name    = "LoadScreen Menu",
		desc    = "",
		author  = "jK",
		date    = "2012",
		license = "GPL2",
		layer   = 0,
		enabled = true,
	}
end

------------------------------------------
------------------------------------------

local playerWindows = {}
local loadProgressbar
local chickenMode = false

function addon.DrawLoadScreen()
	for i=1, #playerWindows do
		(playerWindows[i]):MyMoveUpdate()
	end

	local progress = SG.GetLoadProgress()
	if (progress>=0) then
		loadProgressbar:SetValue(progress * 100)
	else
		loadProgressbar:SetValue(0)
		loadProgressbar:SetCaption("???")
	end
end


function addon.Initialize()
	local Chili = SG.Chili

	if (not Chili) then
		addon.Remove()
		return
	end

	local wnd_minimap = Chili.Window:New{
		name         = "pl_window",
		parent       = Chili.Screen0;
		x            = "40%";
		y            = "30%";
		width        = "20%";
		height       = "40%";
		--autosize     = true;
		draggable    = false;
		resizable    = false;
		color = {1,1,1,0};
		children = {
			Chili.Label:New{
				caption      = Game.mapName;
				fontSize     = 35;
				fontShadow   = true;
				textColor    = {1,0.2,0.2,0.6};
				autosize     = false;
				bottom = 0;
				height = "20%";
				width  = "100%";
				align  = "center";
				valign = "bottom";
			},
			Chili.Image:New{
				file   = "$minimap";
				height = "80%";
				width  = "100%";
			},
		}
	}

	local allies = Spring.GetAllyTeamList()
	--if (#allies - 1 == 2) then
		for n=1,#allies do
			local skp_ally = Chili.StackPanel:New{
				name         = "skp_ally" .. n;
				parent       = Chili.Screen0;
				x            = (n==1) and (0) or nil;
				right        = (n==2) and (0) or nil;
				y            = "30%";
				width        = "35%";
				height       = "40%";
				custom = {
					ally = n;
				};
			}

			local teams = Spring.GetTeamList(allies[n])
			for i=1,#teams do
				local playerInfos = {}
				local players = Spring.GetPlayerList(teams[i])
				for j=1,#players do
					local playerID      = players[j]
					local playerInfo    = {Spring.GetPlayerInfo(playerID)}
					local playerName    = select(1, unpack(playerInfo))
					local playerIsSpec  = select(3, unpack(playerInfo))
					local playerCountry = select(8, unpack(playerInfo))
					local playerRank    = select(9, unpack(playerInfo))

					playerInfos[#playerInfos + 1] = {
						id = playerID;
						name = playerName;
						isspec = playerIsSpec;
						country = playerCountry;
						rank = playerRank;
					}
				end

				local skirmishAIID, name, hostingPlayerID, shortName, version, options = Spring.GetAIInfo(teams[i])
				if (skirmishAIID) then
					if shortName:find("hicken",1,true) then
						chickenMode = true
					else
						playerInfos[#playerInfos + 1] = {
							isai = true;
							id = skirmishAIID;
							name = name;
							shortname = shortName;
							version = version;
							hostid = hostingPlayerID;
							options = options;
						}
					end
				end

				local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(teams[i])

				if ((#playerInfos) > 0) then
					local y_pos = "20%"
					if playerWindows[#playerWindows] and (playerWindows[#playerWindows].custom.ally == n) then
						y_pos = playerWindows[#playerWindows].y + playerWindows[#playerWindows].height + 20
					end
					local vsx, vsy = gl.GetViewSizes()

					for j=1,#playerInfos do
						--[[
						if (playerInfos[j].isai) then
							Chili.Label:New{
								parent       = skp_ally;
								caption      = playerInfos[j].name;
								fontSize     = 40;
								fontShadow   = true;
								x            = 1;
								y            = 100 * (j-1);
								height       = 100;
								align        = "center";
							}
						else--]]
							Chili.StackPanel:New{
								parent       = skp_ally;
								autosize     = true;

								children = {
									Chili.Label:New{
										caption      = playerInfos[j].name;
										fontSize     = 40;
										fontShadow   = true;
										height       = 100;
										align        = "center";
									},
									Chili.Label:New{
										caption      = side;
										fontSize     = 20;
										fontShadow   = true;
										margin       = {10,3,3,3};
										align        = "center";
										textColor    = {1,0.2,0.2,1};
									}
								}
							}
						--end
					end

					--[[playerWindows[#playerWindows + 1] = Chili.Window:New{
						name         = "wnd_team" .. teams[i];
						parent       = Chili.Screen0;
						--x            = (n==2) and -0 or nil;
						--right        = (n==1) and -0 or nil;
						x            = (n==2) and (vsx + i * 100) or nil;
						right        = (n==1) and (vsx + i * 100) or nil;
						y            = y_pos;
						clientWidth  = 200;
						clientHeight = (#playerInfos) * 100;
						autosize     = true;
						draggable    = false;
						resizable    = false;
						custom = {
							ally = n;
						};
						MyMoveUpdate = function(self)
							if (self.custom.ally == 1) then
								if (self.x + self.width <= wnd_minimap.x - 20) then
									self:SetPos(self.x + 20)
								end
							elseif (self.custom.ally == 2) then
								if (self.x >= wnd_minimap.x + wnd_minimap.width + 20) then
									self:SetPos(self.x - 20)
								end
							end
						end;
					}

					for j=1,#playerInfos do
						if (playerInfos[j].isai) then
							local aiID      = playerInfos[j].id
							local aiName    = playerInfos[j].name

							Chili.Label:New{
								parent       = playerWindows[#playerWindows];
								caption      = aiName;
								fontSize     = 40;
								fontShadow   = true;
								x            = 1;
								y            = 100 * (j-1);
								--width        = "100%";
								height       = 100;
								autosize     = true;
							}
						else
							local playerID      = playerInfos[j].id
							local playerName    = playerInfos[j].name
							local playerIsSpec  = playerInfos[j].isspec
							local playerCountry = playerInfos[j].country
							local playerRank    = playerInfos[j].rank

							Chili.Label:New{
								parent       = playerWindows[#playerWindows];
								caption      = playerName;
								fontSize     = 40;
								fontShadow   = true;
								x            = 1;
								y            = 100 * (j-1);
								--width        = "100%";
								height       = 100;
								autosize     = true;
							}
						end
					end--]]
				end
			end
		end
	--end

	local matchType = "FFA"
	local allies = Spring.GetAllyTeamList()
	local numAllies = #allies
	numAllies = numAllies - 1 --gaia
	if (chickenMode) then numAllies = numAllies - 1 end
	if (numAllies == 2) then
		matchType = ("%iv%i"):format(#Spring.GetTeamList(allies[1]), #Spring.GetTeamList(allies[2]))
	end

	local vsx, vsy = gl.GetViewSizes()

	local top_win = Chili.Window:New{
		parent       = Chili.Screen0;
		x            = 0;
		y            = 0;
		right        = 0;
		height       = "20%";
		draggable    = false;
		resizable    = false;
		tiles        = {0, 0, 0, 85};
		TileImage    = ":cl:" .. LUA_DIRNAME .. "Assets/bar_top.png";

		children = {
			Chili.Label:New{
				name     = "pb_load",
				x        = "30%";
				y        = "20%";
				width    = "40%";
				height   = "50%";
				fontSize = vsy * 0.2 * 0.5;
				caption  = matchType;
				align    = "center",
			};
		};
	}

	local btm_win = Chili.Window:New{
		parent       = Chili.Screen0;
		x            = 0;
		bottom       = 0;
		right        = 0;
		height       = "20%";
		draggable    = false;
		resizable    = false;
		tiles        = {0, 85, 0, 0};
		TileImage    = ":cl:" .. LUA_DIRNAME .. "Assets/bar.png";

		children = {
			Chili.Progressbar:New{
				name   = "pb_load",
				x      = "29%";
				y      = "15%";
				width  = "42%";
				height = "40%";
				color  = {1.0,0.17,0.17,1.0},
				TileImageFG = ":cl:" .. LUA_DIRNAME .. "Assets/progress_full.png",
				TileImageBK = ":cl:" .. LUA_DIRNAME .. "Assets/progress_bg.png",
				tiles       = {50, 34, 50, 35},
			};
		};
	}
	loadProgressbar = btm_win:GetChildByName("pb_load")
end


function addon.Shutdown()
end

