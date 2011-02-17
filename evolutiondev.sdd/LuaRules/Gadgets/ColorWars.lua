
function gadget:GetInfo()
	return {
		name = "Color Wars!",
		desc = "Self-replicating blocks filling the map",
		author = "zwzsg",
		date = "15 may 2009",
		license = "Public Domain",
		layer = 0,
		enabled = true
	}
end

function CopyTable(src)
	local dest = {}
	for k,e in pairs(src) do
		dest[k] = e
	end
	return dest
end

if (gadgetHandler:IsSyncedCode()) then
--SYNCED

local BuildTestUnit=UnitDefNames.eaaturret.id
local DoomsSecond = nil -- Time before everything turns to block, in seconds
local Phase = 0 -- 0,1,2,3,4
local ActiveBlocks = {}
local BlockCountPerTeam = {}
local FullBlocks = {}
local BlockTable={} -- 0 if free, {..} if seeded with a block that will spawn later, or with a fully bloomed block, or with a block that couldn't bloom due to unbuildable terrain
local MaxBlockCount = nil

local function isUnitComplete(UnitID)
	local health,maxHealth,paralyzeDamage,captureProgress,buildProgress=Spring.GetUnitHealth(UnitID)
	if buildProgress and buildProgress>=1 then
		return true
	else
		return false
	end
end

local function CmdEditCW(Cmd,Line,WordList,Player)
	if not Spring.IsCheatingEnabled() then
		Spring.SendMessageToPlayer(Player,"Cheat must be enabled.")
		return true
	end
	if Phase~=0 then
		Spring.SendMessageToPlayer(Player,"Too late! Color Wars already started.")
		return true
	end
	local words={}
	local str=Line
	local op=nil
	local spacers={" ","\t",":",",","'","\"","/","\\"}
	local function isSpacer(s)
		for _,spacer in ipairs(spacers) do
			if spacer==s then
				return true
			end
		end
		return false
	end
	while string.len(str)>0 do
		local cursor1=1
		while isSpacer(string.sub(str,cursor1,cursor1)) and cursor1<=string.len(str) do
			cursor1=cursor1+1
		end
		local cursor2=cursor1
		while cursor2<=string.len(str) and not isSpacer(string.sub(str,cursor2,cursor2)) do
			if string.sub(str,cursor2,cursor2)=="+" then
				op=op and 1*op or 1
				cursor1=cursor1+1
				cursor2=cursor1
			elseif string.sub(str,cursor2,cursor2)=="-" then
				op=op and -1*op or -1
				cursor1=cursor1+1
				cursor2=cursor1
			else
				cursor2=cursor2+1
			end
		end
		if cursor1<cursor2 then
			table.insert(words,string.sub(str,cursor1,cursor2-1))
		end
		str=string.sub(str,cursor2,-1)
	end
	--Spring.Echo("string.len(\""..Line.."\")="..string.len(Line))
	--Spring.Echo("#words="..#words)
	--for wi,we in ipairs(words) do
	--	Spring.Echo("word["..wi.."]=\""..we.."\"")
	--end
	local t=nil
	if #words==1 and tonumber(words[1]) then
		t=60*tonumber(words[1])
	elseif #words==2 and tonumber(words[1]) and tonumber(words[2]) then
		t=60*tonumber(words[1])+tonumber(words[2])
	elseif #words==3 and tonumber(words[1]) and tonumber(words[2]) and tonumber(words[3]) then
		t=60*(60*tonumber(words[1])+tonumber(words[2]))+tonumber(words[3])
	end
	if t then
		local h=math.floor(t/3600)
		local m=math.floor((t%3600)/60)
		local s=t%60
		local txt=(h>0 and (h.." hr ") or "")..(m>0 and (m.." min ") or "")..(s>0 and (s.." sec") or "")..((h==0 and m==0 and s==0) and "zero" or "")
		if op and DoomsSecond then
			if Spring.GetGameSeconds()<DoomsSecond+op*t then
				if op<0 then
					Spring.SendMessage("Substracting "..txt.." to Color Wars countdown")
				else
					Spring.SendMessage("Adding "..txt.." to Color Wars countdown")
				end
				DoomsSecond=DoomsSecond+op*t
			else
				Spring.SendMessage("Disabling Color Wars")
				DoomsSecond=nil
				if _G.ColorWars then
					_G.ColorWars=nil
				end
			end
		else
			if t>0 and (not op or op>=0) then
				Spring.SendMessage("Setting Color Wars countdown to "..txt)
				DoomsSecond=Spring.GetGameSeconds()+t
			else
				Spring.SendMessage("Disabling Color Wars")
				DoomsSecond=nil
				if _G.ColorWars then
					_G.ColorWars=nil
				end
			end
		end
		return true
	else
		Spring.SendMessageToPlayer(Player,"Bad syntax in cw command. Use something like:")
		Spring.SendMessageToPlayer(Player,"/luarules cw 2.5      Set to two minutes and a half")
		Spring.SendMessageToPlayer(Player,"/luarules cw -0'30    Substract thirty seconds")
		Spring.SendMessageToPlayer(Player,"/luarules cw +3 45    Add three minutes forty five seconds")
		Spring.SendMessageToPlayer(Player,"/luarules cw 1:15:00  Set to one hour and a quarter")
	end
end

local function SetupCmdEditCW()
	local cmd,func,help
	cmd  = "cw"
	func = CmdEditCW
	help = " Edit Color Wars timer. Separate hours/minutes/seconds with space,tab,comma,colon, etc.. Prefix with + - or nothing."
	gadgetHandler:AddChatAction("cw",func,help)
	Script.AddActionFallback(cmd..' ',help)
end

function gadget:Initialize()
	if Spring.GetModOptions==nil or (tonumber(Spring.GetModOptions()["colorwars"] or 0) or 0)==0 then
		-- gadgetHandler:RemoveGadget() -- Somewhat too early, and not doing it anyway in case command to set it is used in midgame
		-- return
	else
		DoomsSecond = 60*tonumber(Spring.GetModOptions()["colorwars"]) -- Let the ModOption value be in minutes
	end
	SetupCmdEditCW()
end

function gadget:GameStart()
end

local function SeedBlock(BlockType,team,x,z,When)
	local Birthday=When+Spring.GetGameFrame()
	local i,j = math.floor(x/32),math.floor(z/32)
	if type(BlockTable[i][j])~="number" then
		if BlockTable[i][j].Birthday>Birthday then
			BlockTable[i][j].BlockType=BlockType
			BlockTable[i][j].team=team
			BlockTable[i][j].Birthday=Birthday
			return true
		end
		return false
	end
	BlockTable[i][j]={BlockType=BlockType,team=team,x=x,z=z,Birthday=Birthday}
	table.insert(ActiveBlocks,BlockTable[i][j])
	return true
end


function gadget:GameFrame(frame)

	-- Phase 0: Wait till doom
	if Phase==0 then
		if not DoomsSecond then
			-- gadgetHandler:RemoveGadget() -- Not doing it in case command to set it is used in midgame
			return
		end
		if Spring.GetGameSeconds()>DoomsSecond then
			Phase=1
		end

	-- Phase 1: Turn all units into blocks
	elseif Phase==1 then
		-- Initialise BlockTable
		for i=-1,0+Game.mapSizeX/32 do
			BlockTable[i]={}
			for j=-1,0+Game.mapSizeZ/32 do
				BlockTable[i][j]=0
			end
		end
		-- Initial blocks seeding
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local BlockType = 4 -- make something here if only for if hidden races get unhidden
			local _,_,_,_,faction,_=Spring.GetTeamInfo(TeamID)
			faction=string.lower(faction)
			if faction=="system" or faction=="experiment" then
				BlockType=4--QuadBlock
			elseif faction=="hacker" or faction=="hackerold" or faction=="arm" then
				BlockType=3--TriBlock
			elseif faction=="network" or faction=="touhou" or faction=="core" then
				BlockType=6--HexaBlock
			end
			for _,UnitID in ipairs(Spring.GetTeamUnits(TeamID)) do
				local x,y,z=Spring.GetUnitPosition(UnitID)
				local UnitDef=UnitDefs[Spring.GetUnitDefID(UnitID)]
				local xMin=math.max(0,math.floor(x-UnitDef.xsize*4))
				local xMax=math.min(Game.mapSizeX,math.ceil(x+UnitDef.xsize*4))
				local zMin=math.max(0,math.floor(z-UnitDef.zsize*4))
				local zMax=math.min(Game.mapSizeZ,math.ceil(z+UnitDef.zsize*4))
				if true or BlockType==4 then
					for x=xMin,xMax do
						for z=zMin,zMax do
							if x%32==16 and z%32==16 then
								SeedBlock(BlockType,TeamID,x,z,1)
							end
						end
					end
				end
				Spring.MoveCtrl.Enable(UnitID)
				Spring.MoveCtrl.SetNoBlocking(UnitID,true)
			end
		end
		Phase=2

	-- Phase 2: Blocks expansion
	elseif Phase==2 and frame%10==0 then
		for _,b in ipairs(ActiveBlocks) do
			if frame>=b.Birthday then
				local bt1,bt2=Spring.TestBuildOrder(BuildTestUnit,b.x,0,b.z,0)
				if bt1==2 and not bt2 then
					table.insert(FullBlocks,{BlockType=b.BlockType,team=b.team,x=b.x,y=Spring.GetGroundHeight(b.x,b.z),z=b.z})
					BlockCountPerTeam[b.team]=1+(BlockCountPerTeam[b.team] or 0)
					SeedBlock(b.BlockType,b.team,b.x,b.z-32,20)
					SeedBlock(b.BlockType,b.team,b.x,b.z+32,20)
					SeedBlock(b.BlockType,b.team,b.x-32,b.z,20)
					SeedBlock(b.BlockType,b.team,b.x+32,b.z,20)
					SeedBlock(b.BlockType,b.team,b.x-32,b.z-32,30)
					SeedBlock(b.BlockType,b.team,b.x-32,b.z+32,30)
					SeedBlock(b.BlockType,b.team,b.x+32,b.z-32,30)
					SeedBlock(b.BlockType,b.team,b.x+32,b.z+32,30)
					--end
				--else
					--BlockTable[math.floor(b.x/32)][math.floor(b.z/32)]=0 -- Would Remove the ActiveBlocks[_] as well
				end
			end
		end
		for k=#ActiveBlocks,1,-1 do
			if frame>=ActiveBlocks[k].Birthday then
				table.remove(ActiveBlocks,k)
			end
		end
		if #ActiveBlocks==0 then
			Phase=3
		end

	-- Phase 3: Map filled: Count blocks
	elseif Phase==3 then
		for _,t in ipairs(Spring.GetTeamList()) do
			MaxBlockCount=math.max(MaxBlockCount or 0,BlockCountPerTeam[t] or 0)
		end
		for _,t in ipairs(Spring.GetTeamList()) do
			if (BlockCountPerTeam[t] or 0)<(MaxBlockCount or 1) then
				for _,u in ipairs(Spring.GetTeamUnits(t)) do
					Spring.DestroyUnit(u,true,false)
				end
			else
				local names=nil
				for _,pid in ipairs(Spring.GetPlayerList(t,true)) do
					names=(names and names.."," or "").."<PLAYER"..pid..">"
				end
				Spring.SendMessage("Team"..t.."("..(names and names or "")..") won "..gadget:GetInfo().name)
			end
		end
		Phase=4
	end

	_G.ColorWars={DoomsSecond=DoomsSecond,BlockCountPerTeam=BlockCountPerTeam,Phase=Phase,MaxBlockCount=MaxBlockCount,FullBlocks=FullBlocks,SizeFullBlocks=#FullBlocks}

end


else
--UNSYNCED

VFS.Include("LuaRules/Gadgets/libs/ColorConversion.lua",nil)

local BlockDisplayLists = {}
local LastBlockNbr = 0
local ModulatedTeamColors={}

local EchoLines = 0
local function LimitedEcho(txt)
	if EchoLines then
		Spring.Echo(txt)
		EchoLines=EchoLines+1
		if(EchoLines>300) then
			Spring.Echo("Enough text, stopping logging")
			EchoLines=false
		end
	end
end

local function PartialBlocksVertices(n1,n2)
	for n=n1,n2 do
		b=SYNCED.ColorWars.FullBlocks[n]
		local tc=ModulatedTeamColors[b.team]
		--local tc={Spring.GetTeamColor(b.team)}
		gl.Color(tc[1],tc[2],tc[3],1)
		local x,y,z=b.x,b.y,b.z
		--LimitedEcho("Adding block n="..n.." @ x,y,z="..math.floor(x/32)..","..math.floor(y/32)..","..math.floor(z/32))
		-- Top face
		gl.TexCoord(0.5,0)
		gl.Vertex(x-16,y+24,z-16)
		gl.TexCoord(0.5,0.5)
		gl.Vertex(x-16,y+24,z+16)
		gl.TexCoord(1,0.5)
		gl.Vertex(x+16,y+24,z+16)
		gl.TexCoord(1,0)
		gl.Vertex(x+16,y+24,z-16)
		-- South face
		gl.TexCoord(0,0)
		gl.Vertex(x-16,y+24,z+16)
		gl.TexCoord(0,1)
		gl.Vertex(x-16,y-40,z+16)
		gl.TexCoord(0.5,1)
		gl.Vertex(x+16,y-40,z+16)
		gl.TexCoord(0.5,0)
		gl.Vertex(x+16,y+24,z+16)
		-- North face
		gl.TexCoord(0,0)
		gl.Vertex(x-16,y+24,z-16)
		gl.TexCoord(0,1)
		gl.Vertex(x-16,y-40,z-16)
		gl.TexCoord(0.5,1)
		gl.Vertex(x+16,y-40,z-16)
		gl.TexCoord(0.5,0)
		gl.Vertex(x+16,y+24,z-16)
		-- East face
		gl.TexCoord(0,0)
		gl.Vertex(x+16,y+24,z-16)
		gl.TexCoord(0,1)
		gl.Vertex(x+16,y-40,z-16)
		gl.TexCoord(0.5,1)
		gl.Vertex(x+16,y-40,z+16)
		gl.TexCoord(0.5,0)
		gl.Vertex(x+16,y+24,z+16)
		-- West face
		gl.TexCoord(0,0)
		gl.Vertex(x-16,y+24,z-16)
		gl.TexCoord(0,1)
		gl.Vertex(x-16,y-40,z-16)
		gl.TexCoord(0.5,1)
		gl.Vertex(x-16,y-40,z+16)
		gl.TexCoord(0.5,0)
		gl.Vertex(x-16,y+24,z+16)
	end
end

local function DrawNewBlocks()
	gl.PushAttrib(GL.ALL_ATTRIB_BITS)
	gl.DepthTest(true)
	gl.DepthMask(true)
	gl.Texture(":a:UnitTextures/GreyBlock.png")
	gl.BeginEnd(GL.QUADS,PartialBlocksVertices,LastBlockNbr+1,SYNCED.ColorWars.SizeFullBlocks)
	gl.Texture(false)
	gl.DepthMask(false)
	gl.DepthTest(false)
	gl.Color(1,1,1,1)
	-- Note: Leaving DepthTest to false,
	-- or even using gl.ResetState()
	-- Makes the water plane gets drawn over the land
	-- So I save and restore all those OpenGL states with PushAttrib/PopAttrib
	gl.PopAttrib()
end

local function ReDrawBlocks()
	for DispLst in ipairs(BlockDisplayLists) do
		gl.CallList(DispLst)
	end
end

function gadget:DrawWorldPreUnit()
	if SYNCED.ColorWars then
		if SYNCED.ColorWars.SizeFullBlocks>LastBlockNbr then
			--LimitedEcho("New blocks detected! SYNCED.ColorWars.SizeFullBlocks="..SYNCED.ColorWars.SizeFullBlocks)
			-- Modulating blocks team colors according to number of updates
			for _,t in ipairs(Spring.GetTeamList()) do
				local tc={Spring.GetTeamColor(t)}
				local h,s,l=HSLfromRGB(255*tc[1],255*tc[2],255*tc[3])
				l=64+math.abs((127+#BlockDisplayLists*17)%256-128)
				local r,g,b=RGBfromHSL(h,s,l)
				ModulatedTeamColors[t]={r/255,g/255,b/255,1}
			end
			-- Making the display list of newly added blocks
			local NewBlockDisplayList=gl.CreateList(DrawNewBlocks)
			table.insert(BlockDisplayLists,NewBlockDisplayList)
			LastBlockNbr=SYNCED.ColorWars.SizeFullBlocks
		end
		-- Drawing all the blocks from their display list
		ReDrawBlocks()
	end
end

local CountDown={}

function gadget:DrawScreenEffects(vsx, vsy)
	CountDown.Show=false
	if SYNCED.ColorWars and not Spring.IsGUIHidden() then
		CountDown.xSize = CountDown.xSize or vsy*0.1
		CountDown.ySize = CountDown.ySize or vsy*0.05
		CountDown.xPos = math.min(vsx-CountDown.xSize/3,math.max(0-2*CountDown.xSize/3,CountDown.xPos or vsx*0.007))
		CountDown.yPos = math.min(vsy-CountDown.ySize/3,math.max(0-2*CountDown.ySize/3,CountDown.yPos or vsy*0.13))
		local TextWidthFixHack = 1
		if tonumber(string.sub(Game.version,1,4))<=0.785 and string.sub(Game.version,1,5)~="0.78+" then
			TextWidthFixHack = (vsx/vsy)*(4/3)
		end
		if SYNCED.ColorWars.Phase>=2 and SYNCED.ColorWars.BlockCountPerTeam  then
			local cut=0
			local MaxCountTxtxSize=0
			for _,t in ipairs(Spring.GetTeamList()) do
				local count=SYNCED.ColorWars.BlockCountPerTeam[t]
				if count then
					CountDown.Show=true
					local CountTxt=count..(SYNCED.ColorWars.Phase<4 and "" or (count>=SYNCED.ColorWars.MaxBlockCount and " Winner!" or " Loser"))
					local tc={Spring.GetTeamColor(t)}
					gl.Color(tc[1],tc[2],tc[3],1)
					gl.Text(CountTxt,CountDown.xPos,CountDown.yPos-cut*CountDown.ySize,CountDown.ySize,"n")
					cut=cut+1
					MaxCountTxtxSize=math.max(MaxCountTxtxSize,gl.GetTextWidth(CountTxt))
				end
			end
			gl.Color(1,1,1,1)
			CountDown.xSize = CountDown.ySize*TextWidthFixHack*MaxCountTxtxSize
		elseif SYNCED.ColorWars.DoomsSecond and not Spring.IsGUIHidden() then
			CountDown.Show=true
			local t=math.floor(SYNCED.ColorWars.DoomsSecond-Spring.GetGameSeconds())
			local h=math.floor(t/3600)
			local m=math.floor((t%3600)/60)
			local s=t%60
			CountDown.Txt=(t<0 and "Over!" or ((h>0 and h..":" or "")..(m>0 and ((h>0 and m<10) and "0" or "")..m..":" or (h==0 and "" or "00:"))..((s>9 or (m==0 and h==0)) and "" or "0")..s))
			CountDown.xSize = CountDown.ySize*TextWidthFixHack*gl.GetTextWidth(CountDown.Txt)
			gl.Color(1,1,1,1)
			gl.Text(CountDown.Txt,CountDown.xPos,CountDown.yPos,CountDown.ySize,"o")
		end
	end
end

function gadget:MouseMove(x,y,dx,dy,button)
	if CountDown.Show and CountDown.Tweaking then
		if CountDown.Tweaking>=2 then -- resize bar
			if CountDown.Tweaking%2==1 then
				CountDown.xPos=CountDown.xPos+dx
				CountDown.xSize=math.max(9,CountDown.xSize-dx)
			else
				CountDown.xSize=math.max(9,CountDown.xSize+dx)
			end
			if math.floor(CountDown.Tweaking/2)%2==0 then
				CountDown.yPos=CountDown.yPos+dy
				CountDown.ySize=math.max(9,CountDown.ySize-dy)
			else
				CountDown.ySize=math.max(9,CountDown.ySize+dy)
			end
		else -- move bar
			CountDown.xPos=CountDown.xPos+dx
			CountDown.yPos=CountDown.yPos+dy
		end
	end
end

function gadget:MousePress(x,y,button)
	if CountDown.Show and x>CountDown.xPos and y>CountDown.yPos and x<CountDown.xPos+CountDown.xSize and y<CountDown.yPos+CountDown.ySize then
		CountDown.Tweaking=true
		if (x<CountDown.xPos+CountDown.xSize/4 or x>CountDown.xPos+CountDown.xSize-CountDown.xSize/4) and (y<CountDown.yPos+CountDown.ySize/4 or y>CountDown.yPos+CountDown.ySize-CountDown.ySize/4) then
			CountDown.Tweaking=2 -- resize bar
			if x<CountDown.xPos+CountDown.xSize/4 then
				CountDown.Tweaking=CountDown.Tweaking+1
			end
			if y<CountDown.yPos+CountDown.ySize/4 then
				CountDown.Tweaking=CountDown.Tweaking+2
			end
		else
			CountDown.Tweaking=1 -- move bar
		end
		return true
	else
		return false
	end
end
 
function gadget:MouseRelease(x,y,button)
	if CountDown.Show and CountDown.Tweaking then
		CountDown.Tweaking=false
		return true
	else
		return false
	end
end

function gadget:IsAbove(x,y)
	if CountDown.Show and x>CountDown.xPos and y>CountDown.yPos and x<CountDown.xPos+CountDown.xSize and y<CountDown.yPos+CountDown.ySize then
		return true
	else
		return false
	end
end

function gadget:GetTooltip(x,y)
	if SYNCED.ColorWars and SYNCED.ColorWars.Phase then
		local phase=SYNCED.ColorWars.Phase
		if phase==0 then
			return	"When this timer runs out,\r\n"..
				"whoever controls the most\r\n"..
				"territory wins the game."
		elseif phase==1 then
			return "Seeding blocks.."
		elseif phase==2 then
			return "The blocks are now spreading!"
		elseif phase==3 then
			return "Counting blocks.."
		elseif phase==4 then
			return "The blocks have now covered everything!"
		else
			return "Unknown Color Wars phase: "..phase
		end
	end
end

function gadget:Shutdown()
	for DispLst in ipairs(BlockDisplayLists) do
		gl.DeleteList(DispLst)
	end
end

end
