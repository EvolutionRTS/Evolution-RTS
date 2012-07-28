--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Easy Metal",
    desc      = "Restricts mex placement on pre-analyzed flagged metal spots. Also provides snap-to placement.",
    author    = "CarRepairer",
    date      = "2008-09-25",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true,
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetGroundHeight	 = Spring.GetGroundHeight

local floor				     = math.floor

local SNAPDIST		  = 10000
local MEXSIZE		   = 55
local mexRad		    = Game.extractorRadius > 125 and Game.extractorRadius or 125
local mexRadSqr		 = mexRad*mexRad

local MAPSIDE_METALMAP = "mapconfig/map_metal_layout.lua"
local GAMESIDE_METALMAP = "LuaRules/Configs/MetalSpots/" .. (Game.mapName or "") .. ".lua"

local gameConfig = VFS.FileExists(GAMESIDE_METALMAP) and VFS.Include(GAMESIDE_METALMAP) or false
local mapConfig = VFS.FileExists(MAPSIDE_METALMAP) and VFS.Include(MAPSIDE_METALMAP) or false

local mex_types = {
	[UnitDefNames['emetalextractor'].id]	    = true,
	[UnitDefNames['euwmetalextractor'].id]	  = true,
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
-- BEGIN SYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetGroundInfo	   = Spring.GetGroundInfo
local spGiveOrderToUnit	 = Spring.GiveOrderToUnit
local spGetUnitPosition	 = Spring.GetUnitPosition
local spGetUnitAllyTeam	 = Spring.GetUnitAllyTeam

local GRIDSIZE		  = 4
local CUTOFFRATIO	       = 0.4
local MAXMETALDATA	      = 250000

local mapWidth		  = floor(Game.mapSizeX)
local mapHeight		 = floor(Game.mapSizeZ)
local mapWidth2		 = floor(Game.mapSizeX / GRIDSIZE)
local mapHeight2		= floor(Game.mapSizeZ / GRIDSIZE)

local metalMap		  = {}
local maxMetal		  = 0


local flagCount		 = 0

local metalData		 = {}
local metalDataCount    = 0

local mexes = {}

local flags = {}

local commandq = {}

local function MergeToFlag(flagNum, px, pz, pWeight)
	local fx = flags[flagNum].x
	local fz = flags[flagNum].z
	local fWeight = flags[flagNum].weight
	
	local weight = fWeight + pWeight
	local avgX = (fx * fWeight + px * pWeight) / weight
	local avgZ = (fz * fWeight + pz * pWeight) / weight
	
	flags[flagNum].x = avgX
	flags[flagNum].z = avgZ
	flags[flagNum].weight = weight
end


local function NearFlag(px, pz, dist)
	for k, flag in pairs(flags) do
		local fx, fz = flag.x, flag.z
		if (px-fx)^2 + (pz-fz)^2 < dist then
			return k
		end
	end
	return false
end

local function qOrderToUnit(unitID, cmdID, params, opts)
	commandq[#commandq + 1] = {unitID, cmdID, params, opts}
end

local function AnalyzeMetalMap()	
	-- Check configs
	if gameConfig then
		local spots = gameConfig.spots
		if spots then
			Spring.Echo("Easymetal: Loading gameside mex config")
			for i = 1, #spots do
				local spot = spots[i]
				flagCount = flagCount + 1
				flags[flagCount] = {x = spot.x, z = spot.z, weight = spot.metal}
			end
			return
		end
	end

	if mapConfig then
		local spots = mapConfig.spots
		if spots then
			Spring.Echo("Easymetal: Loading mapside mex config")
			for i = 1, #spots do
				local spot = spots[i]
				flagCount = flagCount + 1
				flags[flagCount] = {x = spot.x, z = spot.z, weight = spot.metal}
			end
			return
		end
	end
	
	Spring.Echo("Easymetal: Detecting spots from map")

	for mx_i = 1, mapWidth2 do
		metalMap[mx_i] = {}
		for mz_i = 1, mapHeight2 do
			local mx = mx_i * GRIDSIZE
			local mz = mz_i * GRIDSIZE
			local _, curMetal = spGetGroundInfo(mx, mz)
			curMetal = floor(curMetal * 100)
			metalMap[mx_i][mz_i] = curMetal
			maxMetal = math.max(maxMetal, curMetal)
		end
	end
	
	local lowMetalThresh = floor(maxMetal * CUTOFFRATIO)
	
	for mx_i = 1, mapWidth2 do
		for mz_i = 1, mapHeight2 do
			local mCur = metalMap[mx_i][mz_i]
			if mCur > lowMetalThresh then
				metalDataCount = metalDataCount +1
				
				metalData[metalDataCount] = {
					x = mx_i * GRIDSIZE,
					z = mz_i * GRIDSIZE,
					metal = mCur
				}
				
			end
		end
	end
	if metalDataCount > MAXMETALDATA then -- ceases to work
		Spring.Echo("Removed Easy Metal, too many spots.")
		gadgetHandler:RemoveGadget()
		return
	end
	
	table.sort(metalData, function(a,b) return a.metal > b.metal end)
	
	for index = 1, metalDataCount do
		
		local mx = metalData[index].x
		local mz = metalData[index].z
		local mCur = metalData[index].metal
		
		local nearFlagNum = NearFlag(mx, mz, mexRadSqr)
	
		if nearFlagNum then
			MergeToFlag(nearFlagNum, mx, mz, mCur)
		else
			flagCount = flagCount + 1
			flags[flagCount] = {
				x = mx,
				z = mz,
				weight = mCur
			}
			
		end
	end

end

function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
	--if cmdID < 0 and UnitDefs[-cmdID].extractsMetal > 0 then
	if cmdID < 0 and mex_types[ -cmdID ] then
		local mx, mz = cmdParams[1],  cmdParams[3]
		
		if mx and mz then
			local flagNum = NearFlag(mx, mz, SNAPDIST)
			local flag = flags[flagNum]
			
			if flag then
				local fx,fz = flag.x, flag.z
				local fy = spGetGroundHeight(fx,fz)+1
				
				if (fx == mx and fz == mz) then
					return true
				end
				
				local opts = {}
				if (cmdOptions.shift) then table.insert(opts, "shift") end
 				if (cmdOptions.alt)   then table.insert(opts, "alt")   end
 				if (cmdOptions.ctrl)  then table.insert(opts, "ctrl")  end
 				if (cmdOptions.right) then table.insert(opts, "right") end
				
				--spGiveOrderToUnit(unitID, cmdID, {fx,fy,fz, cmdParams[4]}, opts)
				qOrderToUnit(unitID, cmdID, {fx,fy,fz, cmdParams[4]}, opts)
			end
			return false
		end
	end

	return true
end

function gadget:Initialize()
	
	AnalyzeMetalMap()
	
	local allUnits = Spring.GetAllUnits()
	for _, unitID in pairs(allUnits) do
		gadget:UnitCreated(unitID, Spring.GetUnitDefID(unitID), Spring.GetUnitTeam(unitID))
	end
	
	_G.mexes = mexes
	_G.flags = flags
    GG.flagCount = flagCount
	
end


function gadget:GameFrame(n)
	--[[
	local frame64 = (n) % 64
	if frame64 < 0.1 then
		local flagsString = ''
		for _,coord in pairs(flags) do
			flagsString =  flagsString ..coord.x ..',' ..coord.z ..'|'	      
		end
		flagsString = flagsString:sub(1, -2)
		SendToUnsynced("GetFlags", flagsString) 
		
	end
	--]]
	
	for i,v in ipairs(commandq) do
		spGiveOrderToUnit(v[1], v[2], v[3], v[4] )
	end
	commandq = {}
end


function gadget:UnitCreated(unitID, unitDefID, unitTeam)
	
	local ud = UnitDefs[unitDefID]
	if mex_types[ unitDefID ] then
		local x,_,z = spGetUnitPosition(unitID)
		local nearFlag = NearFlag(x, z, MEXSIZE*MEXSIZE)
		if not nearFlag then return end
		local alliance = spGetUnitAllyTeam(unitID)
		mexes[unitID] = {
			team = unitTeam,
			alliance = alliance,
			flag = nearFlag,
		}
		flags[nearFlag].mex = unitID
	end

end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	--Only triggers for allied units
	if mexes[unitID] then
		local nearFlag = mexes[unitID].flag
		flags[nearFlag].mex = false
		mexes[unitID] = nil
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
else
-- END SYNCED
-- BEGIN UNSYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local spGetActiveCommand	= Spring.GetActiveCommand
local spGetUnitDefID	    = Spring.GetUnitDefID
local spGetGameFrame	    = Spring.GetGameFrame
local spGetMouseState	   = Spring.GetMouseState
local spTraceScreenRay	  = Spring.TraceScreenRay
local spGetMapDrawMode	  = Spring.GetMapDrawMode
local spGetPositionLosState = Spring.GetPositionLosState
local spWorldToScreenCoords     = Spring.WorldToScreenCoords
local spSendCommands	    = Spring.SendCommands
local spTestBuildOrder	  = Spring.TestBuildOrder
local spGetUnitTeam		     = Spring.GetUnitTeam
local spGetUnitLosState	 = Spring.GetUnitLosState

local spGetTeamColor	    = Spring.GetTeamColor
local spGetPlayerInfo	   = Spring.GetPlayerInfo
local spGetTeamInfo		     = Spring.GetTeamInfo
local spGetTeamList		     = Spring.GetTeamList

local glDrawGroundCircle	= gl.DrawGroundCircle 
local glDepthTest		       = gl.DepthTest
local glLineWidth		       = gl.LineWidth
local glScale			   = gl.Scale
local glColor			   = gl.Color
local glPushMatrix	      = gl.PushMatrix
local glPopMatrix	       = gl.PopMatrix
local glTranslate	       = gl.Translate
local glBillboard	       = gl.Billboard
local glAlphaTest	       = gl.AlphaTest
local GL_GREATER		= GL.GREATER
local glTexture			 = gl.Texture
local glTexRect			 = gl.TexRect
local glVertex			  = gl.Vertex
local glBeginEnd			= gl.BeginEnd

LUAUI_DIRNAME = 'LuaUI/'
local fontHandler       = loadstring(VFS.LoadFile(LUAUI_DIRNAME.."modfonts.lua", VFS.ZIP_FIRST))()
local metalFont	 = "LuaUI/Fonts/FreeSansBold_16"
local fhDrawCentered = fontHandler.DrawCentered

local showMetal, showMetalTemp, toggleMetal, showCursorIcon

local snapSteps	 = 20
local confirmSize       = 25

local mexes
local msx,msz

local flags, hoverFlagNum, hoverFlagInLOS
local myAllyID, myTeamID
local gaiaTeamID			= Spring.GetGaiaTeamID()

local teamNames	 = {}
local teamColors	= {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local function NearFlag(px, pz, dist)
	if not flags then return false end
	for k, flag in spairs(flags) do	 
		local fx, fz = flag.x, flag.z
		if (px-fx)^2 + (pz-fz)^2 < dist then
			return k
		end
	end
	return false
end

local DrawBox = function(x,z)
	local y = spGetGroundHeight(x,z)+3
	glVertex(x-MEXSIZE, y, z-MEXSIZE)
	glVertex(x+MEXSIZE, y, z-MEXSIZE)
	
	glVertex(x+MEXSIZE, y, z-MEXSIZE)
	glVertex(x+MEXSIZE, y, z+MEXSIZE)
	
	glVertex(x+MEXSIZE, y, z+MEXSIZE)
	glVertex(x-MEXSIZE, y, z+MEXSIZE)
	
	glVertex(x-MEXSIZE, y, z+MEXSIZE)
	glVertex(x-MEXSIZE, y, z-MEXSIZE)
end

local function DrawSnap(x1,z1,x2,z2)
	--local green = hoverFlagInLOS and 1 or 0
	--local blue = 1-green
	
	for i=0,snapSteps do
		local x = (x1*i + x2*(snapSteps-i)) / snapSteps
		local z = (z1*i + z2*(snapSteps-i)) / snapSteps
		glColor(0, 1, 0, 1-i/snapSteps)
		DrawBox(x,z)
	end
	
end

function gadget:Initialize()
	myAllyID = Spring.GetLocalAllyTeamID()
	myTeamID = Spring.GetLocalTeamID()
	SetupTeams()
end


function gadget:Update()
	if spGetMapDrawMode() == 'metal' then
		spSendCommands({'ShowMetalMap'})
		toggleMetal = true
	end

	local gameFrame = spGetGameFrame()
	local frame4 = (gameFrame) % 4
		
	if (frame4 < 0.1) then  
		local mx, my = spGetMouseState()
		local _,pos = spTraceScreenRay(mx,my,true)      
		if pos then
			 msx,msz = pos[1], pos[3]
		end
	
		if not flags then
			flags = SYNCED.flags
		end
		if not mexes then 
			mexes = SYNCED.mexes
		end
	
		local activeCmdIndex,activeid ,_,buildUnitName = spGetActiveCommand()
		local buildUnitDef = buildUnitName and UnitDefNames[buildUnitName]
		
		hoverFlagNum = false
		--if pos and buildUnitDef and buildUnitDef.extractsMetal > 0 then		       
		if pos and buildUnitDef and mex_types[ -activeid ] then		 
			showCursorIcon = true
			toggleMetal = false
			if not showMetal then
				showMetalTemp = true
				showMetal = true
			end
			
			hoverFlagNum = NearFlag(msx,msz, SNAPDIST)
			
			if hoverFlagNum then
				local msy = spGetGroundHeight(msx,msz)+1
				_, hoverFlagInLOS = spGetPositionLosState(msx,msy,msz, myAllyID)
				
				
				local testBuilding = buildUnitDef.id
				
				local blocking
			    CallAsTeam({ ['read'] = myTeamID }, function()
					blocking = spTestBuildOrder(testBuilding, flags[hoverFlagNum].x, 1, flags[hoverFlagNum].z, 1)
			end)
				
				if blocking == 0 then
					hoverFlagNum = false
				end
			end
		else
			if showMetalTemp then
				showMetal = false
				showMetalTemp = false
			end
			showCursorIcon = false
		end
		
		if toggleMetal then
			toggleMetal = false
			showMetal = not showMetal
		end

		if showMetal then
			-- update colors
			SetupTeams()
		end

	end --every 4 frames
	
end
function gadget:DrawWorld()     
	if showMetal and flags then
		
		fontHandler.UseFont(metalFont)
		glLineWidth(2)
		for k, flag in spairs(flags) do
			local fx,fz = flag.x, flag.z
			local fy = spGetGroundHeight(fx,fz)+45
			
			glColor(1, 1, 0, 0.7)
			glDepthTest(true)
			glDrawGroundCircle(fx, 1, fz, 40, 32)
			glDepthTest(false)
			
			glPushMatrix()
			
			if hoverFlagNum == k and msx then
				glBeginEnd(GL.LINES, DrawSnap, msx, msz, fx, fz)
			else 
				--Draw mex info
				local mexOnFlag = flag.mex and mexes and mexes[flag.mex]
				
				glTranslate(fx,fy,fz)
				glBillboard()
				glScale(.6, .6, .6)
				local _, curFlagInLOS = spGetPositionLosState(fx,fy,fz, myAllyID)
				local mColor
				if curFlagInLOS then
					if mexOnFlag then
						if mexOnFlag.alliance == myAllyID then
							mColor = {1, 1, 0, 0.7}
						else
							mColor = {1, 0, 0, 0.7}
						end
					else
						mColor = {1, 1, 1, 0.7}
					end
					
					
					if flag.mex then
						local curMex = mexes[flag.mex]
						glColor(teamColors[curMex.team])
						fhDrawCentered(teamNames[curMex.team], 0,0,0)
						
					end
				else
					mColor = {0.3, 0.2, 1, 0.7}
				end
				
				--Draw M's
				glColor(mColor)
				glScale(5, 5, 5)
				fhDrawCentered('M', 0,5,0)
			
			end
			
			
			
			glPopMatrix()
		end     -- for every flag
		
		glLineWidth(0)
		glColor(1,1,1,1)
		
	end --if show metal map
	
end

function gadget:DrawScreen() 
	if showCursorIcon then
		local mx, my = spGetMouseState()
		glPushMatrix()
		if hoverFlagNum then
			if hoverFlagInLOS then
				glColor(0,1,0,1)
			else
				glColor(0.3,0.2,1,1)
			end
			
			glAlphaTest(GL_GREATER, 0)
			glTexture('LuaRules/Images/easymetal/yes.png')
			local flag = flags[hoverFlagNum]
			local fx,fz = flag.x, flag.z
			local fy = spGetGroundHeight(fx,fz)+1
			local sx,sy,_ = spWorldToScreenCoords(fx,fy,fz)
			glTexRect(sx-confirmSize, sy-confirmSize, sx+confirmSize, sy+confirmSize)
		else
			glColor(1,0,0,1)
			glAlphaTest(GL_GREATER, 0)
			glTexture('LuaRules/Images/easymetal/no.png')
			glTexRect(mx-confirmSize, my-confirmSize, mx+confirmSize, my+confirmSize)
		end
		
		glPopMatrix()
		
		glAlphaTest(false)
		glColor(1,1,1,1)
	end --if show
	
end

function SetupTeams()
	
	local totalTeamList = spGetTeamList()
	
	for _,team in ipairs(totalTeamList) do
		local _, leaderPlayerID = spGetTeamInfo(team)
		teamNames[team] = spGetPlayerInfo(leaderPlayerID)
		teamColors[team]  = {spGetTeamColor(team)}
		
	end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

end