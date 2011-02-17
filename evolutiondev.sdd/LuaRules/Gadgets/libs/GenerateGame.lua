
function GetMaxAllyTeam(BunchOfPlayers)
	local maxteamfound=0
	for p,_ in ipairs(BunchOfPlayers) do
		if BunchOfPlayers[p].allyteam>maxteamfound then
			maxteamfound=BunchOfPlayers[p].allyteam
		end
	end
	return maxteamfound
end

function GenerateRandInt(lower_bound,higher_bound)
	if lower_bound>higher_bound then
		local bound=higher_bound
		higher_bound=lower_bound
		lower_bound=bound
	end
	if lower_bound==higher_bound then
		return lower_bound
	end
	return math.random(lower_bound,higher_bound)
end

function GenerateRandMapChoice()
	--Spring.Echo("GenerateRandMapChoice: I'm run!")
	local w=0
	for m,_ in ipairs(ModSpecific.MapsList) do
		w=w+ModSpecific.MapsList[m].Weight
	end
	local d=w*math.random()
	w=0
	for m,_ in ipairs(ModSpecific.MapsList) do
		w=w+ModSpecific.MapsList[m].Weight
		if w>=d then
			return ModSpecific.MapsList[m]
		end
	end
	return nil
end

function GenerateSkirmish(map,grouping,difficulty,AlliesFaction,EnemiesFaction)

	local skirm=nil
	local nbr_allies=1
	local nbr_enemies=1
	local player_num
	local cw=false
	local sos=false
	local ons={false,false,false} -- player, friendly bots, enemy bots
	local preplaced={false,false,false} -- player, friendly bots, enemy bots
	local roster_string="??"

	skirm={}
	skirm.map = map or GenerateRandMapChoice()
	skirm.grouping = grouping or math.random(1,2)
	skirm.difficulty = difficulty or math.random(1,2)
	skirm.AlliesFaction = AlliesFaction or nil
	skirm.EnemiesFaction = EnemiesFaction or nil
	skirm.players={}
	skirm.isSpeccing=0
	skirm.ModOptions={}
	skirm.MapOptions=skirm.map.DefaultMapOptions
	if ModSpecific and ModSpecific.MultiplayerModOptions then
		for _,mo in pairs(ModSpecific.MultiplayerModOptions) do
			skirm.ModOptions[mo.key]=mo.def
		end
	end
	skirm.ModOptions["sos"]=0
	skirm.ModOptions["colorwars"]=0
	skirm.ModOptions["preplaced"]=0
	skirm.EndCondition=0
	skirm.PlayerName="Player"
	local HalfMaxMapTeam=math.floor(skirm.map.MaxPlayers/2)

	if skirm.grouping==0 then -- Spectate:
		nbr_allies=GenerateRandInt(1,HalfMaxMapTeam)
		nbr_enemies=nbr_allies
		skirm.isSpeccing=1
		ons=GenerateRandInt(0,2)~=0 and {0,0,0} or {2,2,2}
		--cw=true
		if skirm.difficulty>=3 then
			skirm.ModOptions["preplaced"]=1
			preplaced={true,true,true}
		end
		roster_string="Spectating AI battling themselves"
	elseif skirm.grouping==1 then -- Duels:
		if skirm.difficulty==1 then -- Duel Easy:
			nbr_allies=1
			nbr_enemies=1
			roster_string="Beginner's Duel"
		elseif skirm.difficulty==2 then -- Duel Medium:
			nbr_allies=1
			nbr_enemies=1
			roster_string="Standard Duel"
		elseif skirm.difficulty==3 then -- Duel Hard:
			nbr_allies=1
			nbr_enemies=1
			roster_string="Experienced Duel"
		elseif skirm.difficulty==4 then -- Very Hard Duel:
			nbr_allies=1
			nbr_enemies=1
			ons={0,0,4}
			sos=true
			--cw=true
			roster_string="Veteran's Duel"
		end
	elseif skirm.grouping==2 then -- Teams:
		if skirm.difficulty==1 then -- Team Easy:
			nbr_allies=GenerateRandInt(2,HalfMaxMapTeam)
			nbr_enemies=nbr_allies-1
			ons={1,0,0}
			roster_string="Easy Team Game"
		elseif skirm.difficulty==2 then -- Team Medium:
			nbr_allies=GenerateRandInt(2,HalfMaxMapTeam)
			nbr_enemies=nbr_allies
			roster_string="Medium Team Game"
		elseif skirm.difficulty==3 then -- Team Hard:
			nbr_allies=GenerateRandInt(2,HalfMaxMapTeam-1)
			nbr_enemies=GenerateRandInt(nbr_allies+1,HalfMaxMapTeam+1)
			roster_string="Hard Team Game"
		elseif skirm.difficulty==4 then -- Team Very Hard:
			nbr_enemies=GenerateRandInt(3,HalfMaxMapTeam+1)
			nbr_allies=GenerateRandInt(1,nbr_enemies-2)
			ons={0,0,2}
			sos=true
			roster_string="Very Hard Team Game"
		end
	elseif skirm.grouping==3 then -- Challenges: (Harsh, Tough, Severe, Difficult)
		if skirm.difficulty==1 then -- Challenge Easy
			nbr_allies=1
			nbr_enemies=2
			roster_string="Tough Challenge"
		elseif skirm.difficulty==2 then -- Challenge Medium:
			nbr_allies=1
			nbr_enemies=3
			ons={0,0,2}
			roster_string="Difficult Challenge"
		elseif skirm.difficulty==3 then -- Challenge Hard:
			nbr_allies=1
			nbr_enemies=math.min(4,skirm.map.MaxPlayers-1)
			ons={0,0,3}
			--cw=true
			roster_string="Insane Challenge"
		elseif skirm.difficulty==4 then -- Challenge Very Hard:
			nbr_allies=1
			nbr_enemies=math.min(GenerateRandInt(5,skirm.map.MaxPlayers-1),skirm.map.MaxPlayers-1)
			ons={0,0,4}
			--cw=true
			sos=true
			roster_string="Impossible Challenge"
		end
	end

	-- Set skirm.ModOptions.ons
	if (ons[1] and ons[1]>0) or (ons[2] and ons[2]>0) or (ons[3] and ons[3]>0) then
		--skirm.ModOptions["ons"]=math.max(ons[1] or 0, ons[2] or 0, ons[3] or 0)
	end

	-- Set skirm.ModOptions["colorwars"]
	if cw then
		if skirm.map.TimeFactor<=1 then
			skirm.ModOptions["colorwars"]=5
		elseif skirm.map.TimeFactor<=2 then
			skirm.ModOptions["colorwars"]=10
		elseif skirm.map.TimeFactor<=5 then
			skirm.ModOptions["colorwars"]=15
		elseif skirm.map.TimeFactor<=8 then
			skirm.ModOptions["colorwars"]=20
		else
			skirm.ModOptions["olorwars"]=30
		end
		if skirm.grouping==0 then
			skirm.ModOptions["colorwars"]=30
		end
	end

	-- Don't set skirm.ModOptions["sos"], instead change sos from boolean to numeric
	if sos then
		if skirm.map.TimeFactor<=1 then
			sos=512
		elseif skirm.map.TimeFactor==2 then
			sos=1024
		else
			sos=1024*skirm.map.TimeFactor
		end
	end

	sos=false-- force disable sos

	player_num=GenerateRandInt(0,nbr_allies+nbr_enemies-1)
	if nbr_allies>1 then
		if nbr_enemies<nbr_allies then -- If outnumbering Then Even PlayerTeamNum
			player_num=2*GenerateRandInt(0,nbr_allies-1)
		end
		if nbr_enemies>nbr_allies then -- If outnumbered Then Odd PlayerTeamNum
			player_num=1+2*GenerateRandInt(0,nbr_allies-1)
		end
	end
	skirm.NbrPlayers=(nbr_allies+nbr_enemies)
	skirm.PlayerTeamNum=player_num

	-- Get Factions
	if(skirm.grouping==0 and skirm.AlliesFaction and not skirm.EnemiesFaction) then-- Ignore player choice in that case
		skirm.AlliesFaction=nil
		skirm.EnemiesFaction=nil
	end
	if not skirm.AlliesFaction then
		skirm.AlliesFaction=ModSpecific.FactionsList[GenerateRandInt(1,#ModSpecific.FactionsList)]
	end
	if not skirm.EnemiesFaction then
		if #ModSpecific.FactionsList>=1 then
			local AFI=nil
			for fi,f in ipairs(ModSpecific.FactionsList) do
				if f==skirm.AlliesFaction then
					AFI=fi
					break
				end
			end
			local EFI=GenerateRandInt(2,#ModSpecific.FactionsList)
			if AFI and EFI<=AFI then
				EFI=EFI-1
			end
			skirm.EnemiesFaction=ModSpecific.FactionsList[EFI]
		else
			skirm.EnemiesFaction=ModSpecific.FactionsList[1]
		end
	end


	-- Create all teams
	for p=0, nbr_allies+nbr_enemies-1 do

		local enemy=(((p+player_num)%2)~=0)
		if nbr_allies>1 then
			enemy=(((p+player_num)%2)~=0)
			if nbr_enemies<nbr_allies then
				if p>2*nbr_enemies then
					enemy=false
				end
			end
			if nbr_allies<nbr_enemies then
				if p>2*nbr_allies then
					enemy=true
				end
			end
		else
			enemy=(p~=player_num)
		end

		skirm.players[1+p]={}
		skirm.players[1+p].allyteam=enemy and 1 or 0
		skirm.players[1+p].faction=enemy and skirm.EnemiesFaction or skirm.AlliesFaction
		skirm.players[1+p].bot=ModSpecific.BotsList[1] -- By default, regular AI
		skirm.players[1+p].noons=false
		skirm.players[1+p].sos=false

		if skirm.grouping==0 and skirm.difficulty%2==0 then -- If speccing medium or very hard, then FFA
			skirm.players[1+p].allyteam=p
			skirm.players[1+p].faction=ModSpecific.FactionsList[GenerateRandInt(1,#ModSpecific.FactionsList)]
		end

		if enemy then -- Allies are always the regular KPAI
			if skirm.grouping==1 then
				if skirm.difficulty==1 then
					skirm.players[1+p].bot=ModSpecific.BotsList[2] -- Second AI, "Fair KPAI"
				end
				if skirm.difficulty>=3 then
					skirm.players[1+p].bot=ModSpecific.BotsList[3] -- Third AI, Baczek's KP AI
				end
			elseif skirm.grouping==4 then
				if skirm.difficulty==2 then
					skirm.players[1+p].bot=ModSpecific.BotsList[2] -- Second AI, "Fair KPAI"
				end
			elseif skirm.grouping>=2 and skirm.difficulty>=3 then
				skirm.players[1+p].bot=(math.floor(p/2))%2~=0 and ModSpecific.BotsList[3] or ModSpecific.BotsList[1]
			end
		end

		if skirm.players[1+p].bot then
			local f=skirm.players[1+p].bot.PathAndFileName
			if type(f)=="string" and f~="" and not VFS.FileExists(f) then
				-- if Baczek's KP AI not installed, use KPAI
				skirm.players[1+p].bot=ModSpecific.BotsList[1]
			end
		end

		if p==player_num and skirm.isSpeccing==0 then
			skirm.players[1+p].bot=nil -- Player is no bot
			if sos then
				skirm.players[1+p].sos=sos -- only player may have sos
			end
		end

		-- Set noons of each player
		if skirm.ModOptions["ons"] and skirm.ModOptions["ons"]~="0" and skirm.ModOptions["ons"]~=0 then
			local i = (p==player_num and 1) or ((not enemy) and 2) or 3
			if (not ons[i]) or (ons[i]==0) then
				skirm.players[1+p].noons=1
			end
		end

	end
	PickRandomColors(skirm.players)

	if((skirm.isSpeccing~=0)or(player_num<0)or(player_num>nbr_allies+nbr_enemies)) then
	-- Spec
		skirm.description=roster_string..": "..nbr_allies.."v"..nbr_enemies
	else
	-- Not Spec
		skirm.description=roster_string..": "..nbr_allies.."v"..nbr_enemies.." - Player is n°"..player_num.." in [0.."..nbr_allies+nbr_enemies-1 .."] and "..skirm.players[1+player_num].faction.ClearName..""
	end

	return skirm

end







