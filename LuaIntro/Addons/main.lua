
if addon.InGetInfo then
	return {
		name    = "Main",
		desc    = "displays a simplae loadbar",
		author  = "jK",
		date    = "2012,2013",
		license = "GPL2",
		layer   = 0,
		depend  = {"LoadProgress"},
		enabled = true,
	}
end

local defaultFont = 'ComicSans.ttf'
local fontfile = 'luaui/fonts/'..Spring.GetConfigString("ui_font", defaultFont)
if not VFS.FileExists(fontfile) then
	Spring.SetConfigString('ui_font', defaultFont)
	fontfile = 'luaui/fonts/'..defaultFont
end
local defaultFont2 = 'ComicSans-Bold.ttf'
local fontfile2 = 'luaui/fonts/'..Spring.GetConfigString("ui_font2", defaultFont2)
if not VFS.FileExists(fontfile2) then
	Spring.SetConfigString('ui_font2', defaultFont2)
	fontfile2 = 'luaui/fonts/'..defaultFont2
end
------------------------------------------

local showTips = true
if (Spring.GetConfigInt("LoadscreenTips",1) or 1) == 0 then
	showTips = false
end

local lastLoadMessage = ""

function addon.LoadProgress(message, replaceLastLine)
	lastLoadMessage = message
end

------------------------------------------

-- Random tips we can show
local titleColor = "\255\215\255\215"
local contentColor = "\255\255\255\255"
local tips = {
	
	-- Zopto
	"loadingpics/theenigmatng.png "..titleColor.."The Enigma TNG\n"..contentColor.."He is the creator of most of the music in the game, so go check him out!",
	
	-- Suppy Boi
	
	
	-- Damgam
	"loadingpics/dreamstatelogic.png "..titleColor.."Dreamstate Logic\n"..contentColor.."Composer of a many ambient tracks used ingame, check out his music on Soundcloud!",
	"Press Enter to Chat, Use Alt+Enter to Team Chat, Use Ctrl+Enter to Global Chat",
	
	-- Koyote
	
}

-- Random unit descriptions we can show
local titleColor = "\255\215\255\215"
local contentColor = "\255\255\255\255"
local unit_descs = {

	"elightturret2.png "..titleColor.."Pincushion\n"..contentColor.."Only you can prevent tech rushes (by building a Pincushion in your base)!",
	"ehbotpeewee.png "..titleColor.."A.K. (H-Bot Raider)\n"..contentColor.."H-Bots can traverse any terrain, but they have two giant weaknesses... They are terrible in close quarter combat, and they are extremely vulnerable to artillery. Use cloaked All-Terrains to get in close, or use artillery to zone them out.",
	"elighttank3.png "..titleColor.."Kite (Hovertank Raider)\n"..contentColor.."Hovertanks are all around good units with a lot of excellent variety, however, they lack some of the more specialized abilities of the other techs.",
	"eallterrlight.png "..titleColor.."Recluse (All-Terrain Raider)\n"..contentColor.."All-Terrains have some of the most specialized units in the game. All All-Terrain units can cloak. Cloaking is ESSENTIAL to ensure that your units get the first shot. This can be the difference between winning or losing a battle.",
	"eamphibbuggy.png "..titleColor.."Snake (Amphibious Raider\n"..contentColor.."Amphibious units are fast (even faster underwater!), extremely high damage, but suffer in terms of armor and range. Use them to hit fast and hard. Then back away before your opponent can do any real damage and hit is undefended flank!",
	"emetalextractor.png "..titleColor.."Metal Extractor\n"..contentColor.."Make sure to evolve your Metal Extractors so that you can continually increase your income",
	"esolar2.png "..titleColor.."Fission Energy Generator\n"..contentColor.."Make sure to keep building energy production as your tech progresses. At each tech, the energy cost for units and buildings increases.",

	-- Zopto
	"ecommander.png "..titleColor.."Overseer\n"..contentColor.."Don't forget to evolve your overseer, different upgrades can be helpful!", 
	"ehbotpeewee.png "..titleColor.."H-Bots\n"..contentColor.."While h-bots have long range, no h-bot units are armored.", 
	"eallterrlight.png "..titleColor.."All Terrain Units\n"..contentColor.."Despite the designation 'All-terrain', All-Terrain units cannot traverse deep water.", 
	"emetalextractor.png "..titleColor.."Metal\n"..contentColor.."Don't forget to evolve your metal extractors to get more metal!", 
	"estorage.png "..titleColor.."Supply\n"..contentColor.."In order to increase your army supply cap, build more supply depots.", 
	"ehbotengineer.png "..titleColor.."Lifter\n"..contentColor.."Just like normal h-bots, the lifter can deploy as well.", 
	"eorb.png "..titleColor.."O.R.B.\n"..contentColor.."If you have a surplus of metal and can't find a way to use it, evolve your orbs or build more of them.", 
	"ebasefactory.png "..titleColor.."Factories\n"..contentColor.."Evolve your factories, upgraded units will give you the upper hand in battle.", 
	"ekrow.png "..titleColor.."Endbringers\n"..contentColor.."While Endbringers are strong, don't send them out on their own to fight entire armies.", 
	"eartyturret.png "..titleColor.."Lobster\n"..contentColor.."If you really want to make your opponent hate you, evolve the lobster.", 
	"eallterrshield.png "..titleColor.."Widow\n"..contentColor.."Even though widows have a shield, don't expect them to soak up all the damage for you.", 
	"emine.png "..titleColor.."Mines\n"..contentColor.."In the early game, mines can be used as a simple and cheap defense.", 
	"eshieldgen.png "..titleColor.."Anti-Nuke\n"..contentColor.."Don't forget to build an anti-nuke platform before it's too late.", 
	"esilo.png "..titleColor.."Nuke Silo\n"..contentColor.."Remember that if a nuclear missile silo is destroyed, the nuclear core inside it will detonate as well. Take care to place them well away from anything important.", 
	
	-- Suppy Boi
	"eartytank.png "..titleColor.."Artillery\n"..contentColor.."Always try to include some of artillery units into your army. The sight distance can be a huge help.",  
	"eartytank.png "..titleColor.."Artillery\n"..contentColor.."Try to keep your artillery behind your main battle tanks.",  
	"emetalextractor.png "..titleColor.."Metal\n"..contentColor.."Evolved metal extractors use energy, so when evolving to a higher tier, be sure to plan ahead for the increased energy consumption.",  
	"eamphibmedtank.png "..titleColor.."Amphibious Units\n"..contentColor.."While Amphibious units are fast, nimble, and deal great damage, this comes at the cost of having little to no armor.",
}

local quotes = {
	{"Zopto is to lol as carbon is to life", "Dr.Hamster"},
	{"Build 1 more Mex than the other guy.", "KoyoteKamper"},
	{"...As Chobby will come after Half Life 3...", "Damgam"},
	{"Damgam: Can you remind me why we disabled Communism?\n Forboding Angel: Because people don't like to share? lol xD\n Damgam: Tfw my question and your answer works for both ingame communism and real communism", "Damgam & Forboding Angel"},
	
}


-- Since math.random is not random and always the same, we save a counter to a file and use that.
filename = "LuaUI/Config/randomseed.data"
k = os.time() % 1500
if VFS.FileExists(filename) then
	k = VFS.LoadFile(filename)
end
k = k + 1
local file = assert(io.open(filename,'w'), "Unable to save latest randomseed from "..filename)
    file:write(k)
    file:close()
file = nil

local random_tip_or_desc = unit_descs[((k/2) % #unit_descs) + 1]
if k%2 == 1 then
	random_tip_or_desc = tips[((math.ceil(k/2)) % #tips) + 1]
elseif k%3 == 2 then
	random_tip_or_desc = quotes[((math.ceil(k/3)) % #quotes) + 1]
end

local loadedFontSize = 70
local font = gl.LoadFont("FreeSansBold.otf", 70, 22, 1.15)

local engineVersion = 100 -- just filled this in here incorrectly but old engines arent used anyway
if Engine and Engine.version then
	local function Split(s, separator)
		local results = {}
		for part in s:gmatch("[^"..separator.."]+") do
			results[#results + 1] = part
		end
		return results
	end
	engineVersion = Split(Engine.version, '-')
	if engineVersion[2] ~= nil and engineVersion[3] ~= nil then
		engineVersion = tonumber(string.gsub(engineVersion[1], '%.', '')..engineVersion[2])
	else
		engineVersion = tonumber(Engine.version)
	end
elseif Game and Game.version then
	engineVersion = tonumber(Game.version)
end

function DrawRectRound(px,py,sx,sy,cs)

	--local csx = cs
	--local csy = cs
	--if sx-px < (cs*2) then
	--	csx = (sx-px)/2
	--	if csx < 0 then csx = 0 end
	--end
	--if sy-py < (cs*2) then
	--	csy = (sy-py)/2
	--	if csy < 0 then csy = 0 end
	--end
	--cs = math.min(cs, csy)

	gl.TexCoord(0.8,0.8)
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)

	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)
	
	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)
	
	local offset = 0.05		-- texture offset, because else gaps could show
	local o = offset
	
	-- top left
	--if py <= 0 or px <= 0 then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, py+cs, 0)
	-- top right
	--if py <= 0 or sx >= vsx then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, py+cs, 0)
	-- bottom left
	--if sy >= vsy or px <= 0 then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, sy-cs, 0)
	-- bottom right
	--if sy >= vsy or sx >= vsx then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, sy-cs, 0)
end

function RectRound(px,py,sx,sy,cs)
	--local px,py,sx,sy,cs = math.floor(px),math.floor(py),math.ceil(sx),math.ceil(sy),math.floor(cs)
	
	gl.Texture(":n:luaui/Images/bgcorner.png")
	--gl.Texture(":n:luaui/Images/bgcorner.png")
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs)
	gl.Texture(false)
end

function gradienth(px,py,sx,sy, c1,c2)
	gl.Color(c1)
	gl.Vertex(sx, sy, 0)
	gl.Vertex(sx, py, 0)
	gl.Color(c2)
	gl.Vertex(px, py, 0)
	gl.Vertex(px, sy, 0)
end


local lastLoadMessage = ""
local lastProgress = {0, 0}

local progressByLastLine = {
	["Parsing Map Information"] = {0, 20},
	["Loading Weapon Definitions"] = {10, 50},
	["Loading LuaRules"] = {40, 80},
	["Loading LuaUI"] = {70, 95},
	["Finalizing"] = {100, 100}
}
for name,val in pairs(progressByLastLine) do
	progressByLastLine[name] = {val[1]*0.01, val[2]*0.01}
end

function addon.LoadProgress(message, replaceLastLine)
	lastLoadMessage = message
	if message:find("Path") then -- pathing has no rigid messages so cant use the table
		lastProgress = {0.8, 1.0}
	end
	lastProgress = progressByLastLine[message] or lastProgress
end

function addon.DrawLoadScreen()
	local loadProgress = SG.GetLoadProgress()
	if loadProgress == 0 then
		loadProgress = lastProgress[1]
	else
		loadProgress = math.min(math.max(loadProgress, lastProgress[1]), lastProgress[2])
	end

	local vsx, vsy = gl.GetViewSizes()

	-- draw progressbar
	local hbw = 3.5/vsx
	local vbw = 3.5/vsy
	local hsw = 0.2
	local vsw = 0.2
	local yPos =  0.125 --0.054
	local yPosTips = yPos + 0.1245
	local loadvalue = 0.2 + (math.max(0, loadProgress) * 0.6)

	if not showTips then
		yPos = 0.165
		yPosTips = yPos
	end

	--bar bg
	local paddingH = 0.004
	local paddingW = paddingH * (vsy/vsx)
	gl.Color(0.085,0.085,0.085,0.925)
	RectRound(0.2-paddingW,yPos-0.05-paddingH,0.8+paddingW,yPosTips+paddingH,0.007)

	gl.Color(0,0,0,0.75)
	RectRound(0.2-paddingW,yPos-0.05-paddingH,0.8+paddingW,yPos+paddingH,0.007)

    if loadvalue > 0.215 then
	    -- loadvalue
        gl.Color(0.4-(loadProgress/7),loadProgress*0.4,0,0.4)
        RectRound(0.2,yPos-0.05,loadvalue,yPos,0.0055)

        -- loadvalue gradient
        gl.Texture(false)
        gl.BeginEnd(GL.QUADS, gradienth, 0.2,yPos-0.05,loadvalue,yPos, {1-(loadProgress/3)+0.2,loadProgress+0.2,0+0.08,0.14}, {0,0,0,0.14})

        -- loadvalue inner glow
        gl.Color(1-(loadProgress/3.5)+0.15,loadProgress+0.15,0+0.05,0.04)
        gl.Texture(":n:luaui/Images/barglow-center.png")
        gl.TexRect(0.2,yPos-0.05,loadvalue,yPos)

        -- loadvalue glow
        local glowSize = 0.06
        gl.Color(1-(loadProgress/3)+0.15,loadProgress+0.15,0+0.05,0.1)
        gl.Texture(":n:luaui/Images/barglow-center.png")
        gl.TexRect(0.2,	yPos-0.05-glowSize,	loadvalue,	yPos+glowSize)

        gl.Texture(":n:luaui/Images/barglow-edge.png")
        gl.TexRect(0.2-(glowSize*1.3), yPos-0.05-glowSize, 0.2, yPos+glowSize)
        gl.TexRect(loadvalue+(glowSize*1.3), yPos-0.05-glowSize, loadvalue, yPos+glowSize)
    end

	-- progressbar text
	gl.PushMatrix()
		gl.Scale(1/vsx,1/vsy,1)
		local barTextSize = vsy * 0.026

		--font:Print(lastLoadMessage, vsx * 0.5, vsy * 0.3, 50, "sc")
		--font:Print(Game.gameName, vsx * 0.5, vsy * 0.95, vsy * 0.07, "sca")
		font:Print(lastLoadMessage, vsx * 0.21, vsy * (yPos-0.017), barTextSize * 0.67, "oa")
		if loadProgress>0 then
			font:Print(("%.0f%%"):format(loadProgress * 100), vsx * 0.5, vsy * (yPos-0.0325), barTextSize, "oc")
		else
			font:Print("Loading...", vsx * 0.5, vsy * (yPos-0.031), barTextSize, "oc")
		end
	gl.PopMatrix()


	if showTips then
		-- In this format, there can be an optional image before the tip/description.
		-- Any image ends in .dss, so if such a text piece is found, we extract that and show it as an image.
		local text_to_show = random_tip_or_desc
		yPos = yPosTips
		if random_tip_or_desc[2] then
			text_to_show = random_tip_or_desc[1]
		else
			i, j = string.find(random_tip_or_desc, ".png")
		end
		local numLines = 1
		local image_text = nil
		local fontSize = barTextSize * 0.77
		local image_size = 0.0485
		local height = 0.123

		if i ~= nil then
			text_to_show = string.sub(text_to_show, j+2)
			local maxWidth = ((0.58-image_size-0.012) * vsx) * (loadedFontSize/fontSize)
			text_to_show, numLines = font:WrapText(text_to_show, maxWidth)
		else
			local maxWidth = (0.585 * vsx) * (loadedFontSize/fontSize)
			text_to_show, numLines = font:WrapText(text_to_show, maxWidth)
		end

		-- Tip/unit description
		-- Background
		--gl.Color(1,1,1,0.033)
		--RectRound(0.2,yPos-height,0.8,yPos,0.005)

		-- Text
		gl.PushMatrix()
		gl.Scale(1/vsx,1/vsy,1)

		if i ~= nil then
			image_text = string.sub(random_tip_or_desc, 0, j)
			gl.Texture(":n:unitpics/" .. image_text)
			gl.Color(1.0,1.0,1.0,0.8)
			if (engineVersion < 1000 and engineVersion >= 105) or engineVersion > 10401151 then
				gl.TexRect(vsx * 0.21, (vsy*(yPos-0.015))-(vsx*image_size), vsx*(0.21+image_size), vsy*(yPos-0.015),false,true)
			else
				gl.TexRect(vsx * 0.21, (vsy*(yPos-0.015))-(vsx*image_size), vsx*(0.21+image_size), vsy*(yPos-0.015))
			end
			font:Print(text_to_show, vsx * (0.21+image_size+0.012) , vsy * (yPos-0.0175), fontSize, "oa")
		else
			font:Print(text_to_show, vsx * 0.21, vsy * (yPos-0.0175), fontSize, "oa")
		end

		if random_tip_or_desc[2] then
			font:Print('\255\255\222\155'..random_tip_or_desc[2], vsx * 0.79, (vsy * ((yPos-0.0175)-height)) +(fontSize*2.66) , fontSize, "oar")
		end
		gl.PopMatrix()
	end
end


function addon.MousePress(...)
	--Spring.Echo(...)
end


function addon.Shutdown()
	gl.DeleteFont(font)
end
