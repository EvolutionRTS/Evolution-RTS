
--[[
===============
Specification:
-----------------------
* For missions makers:
-----------------------
Two optional fields in missions startscripts:
	MissionTitle = "A short line";
	MissionBriefing = "A lengthy description. May use newlines\n tabs\t and colors, such as \255\255\180\180red, \255\180\255\180green, \255\180\180\255blue, etc..\ndefault is \255\255\255\255white, so only use light colors as the background will likely be dark.\nIn case it's not obvious, to change color, there is first a 255 to indicate color code escape sequence, then the R,V,B values.";
You can have a MissionBriefing without a MissionTitle, in this case ingame it will show the mission filename in place of the title.

----------------------
* For GUI Lua coders:
----------------------
Three modoptions:
"missionscript": Always there when it's a mission. Contain the filename (maybe with path) of the mission.
"missiontitle": Optional. Short string describing the mission.
"missionbriefing": Optional and not available when game starts. Contains a lengthy briefing, with newlines and color codes.

Have somewhere in your GUI a place to display the mission title. You probably want to prefix it by "Mission: " to make it clearer. When mouse-overing it, expand it to show the briefing as well. Or just present those two info in whatever way you want. Maybe you prefer to use tooltip. Maybe you have a menu in your GUI where it'd fit. But make sure it's in an obvious and easy to access place, so even a newb can read it back in the middle of a game.

In the future, missions should be allowed to change the title and briefing midgame, to reflect change of objectives. There is no mechanism yet for that, but make sure your GUI will easily allow that.

Because of the bug with overlong startscript, the ModOptions "missiontitle" and "missionbriefing" maybe not be available immediatly when game starts, you have may to wait some gameframes for Spring.GetModOptions()["missionbriefing"] to eventually return something.

The missions maker should be allowed to have set a MissionBriefing and no MissionTitle, a MissionTitle and no MissionBriefing, or neither.

If there's no mission title, then in place of it use the mission filename, which is stored in Spring.GetModOptions()["missionscript"] and which by design will always be there if it's a mission. However, before displaying it, you have to prettify it by:
- Removing everything before (and including) the last / or \
- Removing the file extension: .sav, .txt, .whatever
- Replace every _ by space
- Redo the capitalisation: Start Each Word With Capital Case. Or maybe just the first.

If there is no "MissionBriefing", either disable showing the full briefing, or use a default text like "No Briefs. Sorry, you'll have to fight in the bare!"

If there is no Spring.GetModOptions()["missionscript"], then it's not a mission and the GUI should disable the mission title/briefing display entirely.

Looks like I told the mission makers to enclose MissionTitle and MissionBriefing in quotes. Make sure to have code to detect and remove extra quotation or double-quotation marks. Had to write an UnQuoteString function.

Looks like the antislash in modoptions are printed literally. I had to write an EscapeString function to switch them back to their escape sequence roles.

]]--


function widget:GetInfo()
	return {
		name = "Mission Briefing",
		desc = "Show the mission title and briefing",
		author = "zwzsg",
		date = "July 23th, 2010",
		license = "Public Domain",
		version = "1.1",
		layer = 0,
		enabled = true
	}
end

local function UnQuoteString(str)-- Remove the pairs of " and ' at the extremities of a string
	if type(str)=="string" then
		repeat
			local len=string.len(str)
			local last=string.sub(str,len,len)
			local first=string.sub(str,1,1)
			if first==last and (first=="'" or last=='"') then
				str=string.sub(str,2,len-1)
			end
		until len==string.len(str)
	end
	return str
end

local function Capitalize(str)-- Put a capital letter at the beginning of every word
	if type(str)=="string" then
		return string.gsub(str,"(%w)(%w*)",function(a,b) return string.upper(a) .. b end)
	else
		return str
	end
end

local function EscapeString(str)-- Put escape sequence back in place of literal antislashes
	if type(str)=="string" then
		local ListOfEscapes={
			["a"]="\a",
			["b"]="\b",
			["f"]="\f",
			["n"]="\n",
			["r"]="\r",
			["t"]="\t",
			["v"]="\v",
			["\\"]="\\",
			["\""]="\"",
			["\'"]="\'",
			["["]="[",
		}
		local zero,nine=string.byte("0"),string.byte("9")
		local bin={string.byte(str,1,-1)}
		for k=#bin-1,1,-1 do
			if bin[k]==string.byte("\\") then
				if bin[k+1]>=zero and bin[k+1]<=nine then
					if bin[k+2]>=zero and bin[k+2]<=nine then
						if bin[k+3]>=zero and bin[k+3]<=nine then
							bin[k]=(bin[k+1]-zero)*100+(bin[k+2]-zero)*10+bin[k+3]-zero
							table.remove(bin,k+3)
							table.remove(bin,k+2)
							table.remove(bin,k+1)
						else
							bin[k]=(bin[k+1]-zero)*10+bin[k+2]-zero
							table.remove(bin,k+2)
							table.remove(bin,k+1)
						end
					else
						bin[k]=bin[k+1]-zero
						table.remove(bin,k+1)
					end
				else
					for pat,tar in pairs(ListOfEscapes) do
						if string.byte(pat)==bin[k+1] then
							bin[k]=string.byte(tar)
							table.remove(bin,k+1)
							break
						end
					end
				end
			end
		end
		return string.char(unpack(bin))
	else
		return str
	end
end

local function FileNameToPrettyName(n)
	if type(n)~="string" then
		return nil
	else
		local e=(string.find(n,".",string.len(n)-4,true) or 1+string.len(n))-1
		local b=1
		repeat
			local s=string.find(n,"/",b,true) or string.find(n,"\\",b,true)
			b=s and s+1 or b
		until not s
		return Capitalize(string.gsub(string.sub(n,b,e),"[_]"," "))
	end
end

local function GetMissionTitle()
	return EscapeString(UnQuoteString(Spring.GetModOptions()["missiontitle"]))
		or FileNameToPrettyName(Spring.GetModOptions()["missionscript"])
end

local function GetMissionBriefing()
	return EscapeString(UnQuoteString(Spring.GetModOptions()["missionbriefing"]))
end

function widget:Initialize()
	WG.MissionInfoBox=nil
	if not Spring.GetModOptions()["missionscript"] then
		widgetHandler:RemoveWidget()
	end
end

function widget:Shutdown()
	WG.MissionInfoBox=nil
end

local function IsAbove()
	if WG.MissionInfoBox then
		local xMouse,yMouse = Spring.GetMouseState()
		if WG.MissionInfoBox.Title and (xMouse > WG.MissionInfoBox.Title.x1 and xMouse < WG.MissionInfoBox.Title.x2 and yMouse > WG.MissionInfoBox.Title.y1 and yMouse < WG.MissionInfoBox.Title.y2) then
			return true
		elseif WG.MissionInfoBox.Briefing and (xMouse > WG.MissionInfoBox.Briefing.x1 and xMouse < WG.MissionInfoBox.Briefing.x2 and yMouse > WG.MissionInfoBox.Briefing.y1 and yMouse < WG.MissionInfoBox.Briefing.y2) then
			return true
		else
			return false
		end
	else
		return nil
	end
end

local function GetLines(str)
	local nttList = {}
	local maxWidth = 0
	for line in string.gmatch(str,"[^\r\n]+") do
		table.insert(nttList,"\255\255\255\255"..line)
		if gl.GetTextWidth(line)>maxWidth then
			maxWidth=gl.GetTextWidth(line)
		end
	end
	return nttList,maxWidth
end

function widget:DrawScreenEffects(vsx,vsy)

	if Spring.IsGUIHidden() then
		WG.MissionInfoBox=nil
		return
	else
		WG.MissionInfoBox=WG.MissionInfoBox or {}
	end

	local TextWidthFixHack = 1
	if tonumber(string.sub(Game.version,1,4))<=0.785 and string.sub(Game.version,1,5)~="0.78+" then
		TextWidthFixHack = (vsx/vsy)*(4/3)
	end

	-- First, the mission title:
	local FontSize=WG.MissionInfoBox.FontSize or math.max(13,4+vsy/100)
	local xSize, ySize = 0, 0
	local lines,maxWidth
	if WG.MissionInfoBox.Title and WG.MissionInfoBox.Title.lines then
		lines,maxWidth = WG.MissionInfoBox.Title.lines, WG.MissionInfoBox.Title.maxWidth
	else
		lines,maxWidth = GetLines("\255\182\254\213Mission:\255\255\255\255 "..(GetMissionTitle() or "?"))
	end
	xSize = FontSize*(1+maxWidth*TextWidthFixHack)
	ySize = FontSize*(1+#lines)

	-- Top left position by default
	local x1,y1,x2,y2=0,vsy-ySize,xSize,vsy

	local MiniMap={Spring.GetMiniMapGeometry()}
	MiniMap={x=MiniMap[1],y=MiniMap[2],sx=MiniMap[3],sy=MiniMap[4],minimized=MiniMap[5],maximized=MiniMap[6]}

	if not MiniMap.maximized then
		if MiniMap.sy>vsy*0.75 then -- left/right of minimap
			if MiniMap.x+MiniMap.sx/2<vsx/2 then -- right of minimap
				x1 = MiniMap.x+MiniMap.sx+3
				x2 = x1+xSize
				y2 = MiniMap.y+MiniMap.sy
				y1 = y2-ySize
			else -- left of minimap
				x2 = MiniMap.x-4
				x1 = x2-xSize
				y2 = MiniMap.y+MiniMap.sy
				y1 = y2-ySize
			end
		else -- above/below minimap
			if MiniMap.y+MiniMap.sy/2>vsy/2 then -- below minimap
				x1 = MiniMap.x
				x2 = x1+xSize
				y2 = MiniMap.y-4
				y1 = y2-ySize
			else -- above minimap
				x1 = MiniMap.x
				x2 = x1+xSize
				y1 = MiniMap.y+MiniMap.sy+3
				y2 = y1+ySize
			end
		end
	end

	-- Saving the position of MissionInfoBox.title
	WG.MissionInfoBox.FontSize=FontSize
	WG.MissionInfoBox.Title={x1=math.min(x1,x2),y1=math.min(y1,y2),x2=math.max(x1,x2),y2=math.max(y1,y2),xSize=math.abs(x2-x1),ySize=math.abs(y2-y1),lines=lines,maxWidth=maxWidth}

	local r,g,b = 0.4,0.4,0.6
	gl.Blending(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA) -- default
	gl.Color(r,g,b,0.5)
	gl.Rect(x1,y1,x2,y2)
	gl.Color(r,g,b,1)
	gl.LineWidth(1)
	gl.Shape(GL.LINE_LOOP,{
		{v={x1,y2}},{v={x2,y2}},
		{v={x2,y1}},{v={x1,y1}},})
	gl.Color(1,1,1,1)
	for k=1,#lines do
		gl.Text(lines[k],x1+FontSize/2,y2-FontSize*(0.5+k),FontSize,'od')
	end
	gl.Text("\255\255\255\255 ",0,0,FontSize,'o') -- Reset color to white for other widgets using gl.Text
	gl.Color(r,g,b,0.15)
	gl.Rect(x1,y1,x2,y2)
	gl.Color(1,1,1,1)

	if IsAbove() then
		-- Then, the mission briefing:
		xSize, ySize = 0, 0
		if WG.MissionInfoBox.Briefing and WG.MissionInfoBox.Briefing.lines then
			lines,maxWidth = WG.MissionInfoBox.Briefing.lines, WG.MissionInfoBox.Briefing.maxWidth
		else
			WG.MissionInfoBox.Title.lines=nil
			lines,maxWidth = GetLines(GetMissionBriefing() or "< No Intel Available >")
		end
		xSize = FontSize*(1+maxWidth*TextWidthFixHack)
		ySize = FontSize*(1+#lines)

		-- Place briefing below title
		x1 = WG.MissionInfoBox.Title.x1
		y2 = WG.MissionInfoBox.Title.y1
		x2 = x1+xSize
		y1 = y2-ySize
		if WG.MissionInfoBox.Title.x2 == MiniMap.x-3 then -- left of minimap
			x1 = MiniMap.x-xSize
			x2 = x1+xSize
		elseif WG.MissionInfoBox.Title.y1 == MiniMap.y+MiniMap.sy+2 then -- above minimap
			y1=WG.MissionInfoBox.Title.y2
			y2=y1+ySize
		end

		-- Saving the position of MissionInfoBox.briefing
		WG.MissionInfoBox.Briefing={x1=math.min(x1,x2),y1=math.min(y1,y2),x2=math.max(x1,x2),y2=math.max(y1,y2),xSize=math.abs(x2-x1),ySize=math.abs(y2-y1),lines=lines,maxWidth=maxWidth}

		local r,g,b = 0.76,0.9,0.6
		gl.Blending(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA) -- default
		gl.Color(r,g,b,0.5)
		gl.Rect(x1,y1,x2,y2)
		gl.Color(r,g,b,1)
		gl.LineWidth(1)
		gl.Shape(GL.LINE_LOOP,{
			{v={x1,y2}},{v={x2,y2}},
			{v={x2,y1}},{v={x1,y1}},})
		gl.Color(1,1,1,1)
		for k=1,#lines do
			gl.Text(lines[k],x1+FontSize/2,y2-FontSize*(0.5+k),FontSize,'od')
		end
		gl.Text("\255\255\255\255 ",0,0,FontSize,'od') -- Reset color to white for other widgets using gl.Text
		gl.Color(r,g,b,0.15)
		gl.Rect(x1,y1,x2,y2)
		gl.Color(1,1,1,1)
	else
		WG.MissionInfoBox.Briefing=nil
	end

end

function widget:MouseWheel(up,value)
	if IsAbove() then
		if up then
			WG.MissionInfoBox.FontSize = math.max(WG.MissionInfoBox.FontSize - 1,2)
		else
			WG.MissionInfoBox.FontSize = WG.MissionInfoBox.FontSize + 1
		end
		return true
	end
	return false
end



