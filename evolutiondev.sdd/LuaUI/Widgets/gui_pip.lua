
function widget:GetInfo()
	return {
		name      = "Picture-in-Picture",
		desc      = "",
		author    = "Niobium",
		version   = "1.3",
		date      = "5th November 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = false,
		handler   = true,
	}
end

-- Hotkeys (Done !)
-- Mousewheel zoom (Done !)
-- Start points (Done !)
-- Saving all config (Done !)

----------------------------------------------------------------------------------------------------
-- Todo
----------------------------------------------------------------------------------------------------
-- Add rendering building on cursor when active command is a building (incl. indicator of valid build location)
-- Add rendering of buildings that are in queues
-- Fix perspective
-- Fix unit y positioning (Requires fixed perspective)
-- Blips don't get selection or construction outline, easily fixed when done with the SetDrawMode above
-- Find out why glTexture(0, '$units') fixes feature drawing

----------------------------------------------------------------------------------------------------
-- Config
----------------------------------------------------------------------------------------------------
local panelBackColor = {0.5, 0.5, 0.5, 0.5} -- {0.4, 0.4, 0.4, 1}
local panelBorderColorLight = {0.75, 0.75, 0.75, 1}
local panelBorderColorDark = {0.15, 0.15, 0.15, 1}
local minPanelSize = 175
local buttonSize = 16
local fontSize = 16 -- Currently only for the 'Tracking #' text

local zoomWheel = 2 -- Factor for mousewheel zoom
local zoomRate = 4 -- magnification multiplication per second
local zoomMin = 0.075
local zoomMax = 0.6

local radarDotRadius = 30
local simpleColorSelf	= {0.2, 0.9, 0.2, 1} -- Green
local simpleColorAlly	= {0.3, 0.3, 0.9, 1} -- Blue
local simpleColorEnemy	= {0.9, 0.2, 0.2, 1} -- Red

----------------------------------------------------------------------------------------------------
-- Globals
----------------------------------------------------------------------------------------------------
-- Base variables
local pl, pr, pb, pt = 200, 400, 200, 400
local zoom = 0.25
local wcx, wcz = 1000, 1000

-- Calculated variables
local wl, wr, wb, wt
local gvl, gvr, gvb, gvt
local gcl, gcr, gcb, gct

-- State variables
local inMinMode = false
local minModeL
local minModeB
local drawingGround = true
local drawBlipsOnly = false
local usingSimpleColors = false
local usingLightBorder = false
local panelBorderColor
local areResizing = false
local areDragging = false
local arePanning = false
local areCentering = false
local areZoomingOut = false
local areZoomingIn = false
local areTracking = nil

-- Misc variables
local startX, startZ
local unitShader
local oldTeamColors
local teamColors = {}
local pipUnits = {}
local pipFeatures = {}
local pipBlipTeam, pipBlipX, pipBlipY
local unitDefTextures = {}
local noModelFeatures = {}
local xsizes = {}
local zsizes = {}
local isFactory = {}
local radiusSqs = {}
local featureRadiusSqs = {}
local unitOutlineList = nil
local radarDotList = nil
local specFullView
local myAllyTeamID
local gameHasStarted

-- Command colors
local cmdColors = {
		unknown			= {1.0, 1.0, 1.0, 1},
		[CMD.MOVE]		= {0.5, 1.0, 0.5, 1},
		[CMD.ATTACK]	= {1.0, 0.2, 0.2, 1},
		[CMD.FIGHT]		= {0.5, 0.5, 1.0, 1},
		[CMD.GUARD]		= {0.5, 0.5, 1.0, 1},
		[CMD.PATROL]	= {0.3, 0.3, 1.0, 1},
		[CMD.CAPTURE]	= {1.0, 1.0, 0.3, 1},
		[CMD.REPAIR]	= {0.3, 1.0, 1.0, 1},
		[CMD.RECLAIM]	= {1.0, 0.2, 1.0, 1},
		[CMD.RESTORE]	= {0.0, 1.0, 0.0, 1},
		[CMD.RESURRECT]	= {0.2, 0.6, 1.0, 1},
		[CMD.LOAD_UNITS]= {0.3, 1.0, 1.0, 1},
		[CMD.UNLOAD_UNIT] = {1.0, 1.0, 0.0, 1},
		[CMD.UNLOAD_UNITS]= {1.0, 1.0, 0.0, 1},
	}

-- Buttons (Must be declared after variables)
local buttons = {
		{
			texture = 'LuaUI/Images/PipMinus.png',
			tooltip = 'Zoom out [Hold]',
			command = nil,
			OnPress = function() areZoomingOut = true end
		},
		{
			texture = 'LuaUI/Images/PipPlus.png',
			tooltip = 'Zoom in [Hold]',
			command = nil,
			OnPress = function() areZoomingIn = true end
		},
		{
			texture = 'LuaUI/Images/PipCenter.png',
			tooltip = 'Enter centering mode',
			command = nil,
			OnPress = function() areCentering = true areTracking = nil end
		},
		{
			texture = 'LuaUI/Images/PipSwitch.png',
			tooltip = 'Switch PiP view with main view',
			command = 'pip_switch',
			OnPress = function()
						local sizex, sizez = Spring.GetWindowGeometry()
						local _, pos = Spring.TraceScreenRay(sizex/2, sizez/2, true)
						if pos and pos[2] > -10000 then
							Spring.SetCameraTarget(wcx, 0, wcz, 0.2) -- Spring.GetGroundHeight(pwx, pwz)
							wcx, wcz = pos[1], pos[3]
							RecalculateWorldCoordinates()
							RecalculateGroundTextureCoordinates()
						end
					end
		},
		{
			texture = 'LuaUI/Images/PipT.png',
			tooltip = 'Track selected units',
			command = 'pip_track',
			OnPress = function()
						if areTracking then
							areTracking = nil
						else
							areTracking = Spring.GetSelectedUnits()
						end
					end
		},
		{
			texture = 'LuaUI/Images/PipGround.png',
			tooltip = 'Toggle ground drawing',
			command = 'pip_toggle_ground',
			OnPress = function() drawingGround = not drawingGround end
		},
		{
			texture = 'LuaUI/Images/PipBlipButton.png',
			tooltip = 'Toggle dot-only mode',
			command = 'pip_toggle_dots',
			OnPress = function() drawBlipsOnly = not drawBlipsOnly end
		},
		{
			texture = 'LuaUI/Images/PipColors.png',
			tooltip = 'Toggle simple colors',
			command = 'pip_toggle_colors',
			OnPress = function()
						usingSimpleColors = not usingSimpleColors
						SetupTeamColors(usingSimpleColors)
					end
		},
		{
			texture = 'LuaUI/Images/PipHalfHalf.png',
			tooltip = 'Toggle PiP window color',
			command = 'pip_toggle_bordercolor',
			OnPress = function()
						if usingLightBorder then
							panelBorderColor = panelBorderColorDark
							usingLightBorder = false
						else
							panelBorderColor = panelBorderColorLight
							usingLightBorder = true
						end
					end
		},
		{
			texture = 'LuaUI/Images/PipMove.png',
			tooltip = 'Move PiP window [Drag]',
			command = nil,
			OnPress = function() areDragging = true end
		},
	}

-- What commands are issued at a position or unit/feature ID (Only used by GetUnitPosition)
local positionCmds = {
	[CMD.MOVE]=true,		[CMD.ATTACK]=true,		[CMD.RECLAIM]=true,		[CMD.RESTORE]=true,		[CMD.RESURRECT]=true,
	[CMD.PATROL]=true,		[CMD.CAPTURE]=true,		[CMD.FIGHT]=true, 		[CMD.DGUN]=true,		[38521]=true, -- jump
	[CMD.UNLOAD_UNIT]=true,	[CMD.UNLOAD_UNITS]=true,[CMD.LOAD_UNITS]=true,	[CMD.GUARD]=true,
}

----------------------------------------------------------------------------------------------------
-- Speedups
----------------------------------------------------------------------------------------------------
local GL_LINE_LOOP = GL.LINE_LOOP
local GL_LINE_STRIP = GL.LINE_STRIP
local GL_LINES = GL.LINES
local GL_TRIANGLES = GL.TRIANGLES
local GL_QUADS = GL.QUADS

local glDepthTest = gl.DepthTest
local glDepthMask = gl.DepthMask
local glBlending = gl.Blending
local glColor = gl.Color
local glRect = gl.Rect
local glLineWidth = gl.LineWidth
local glTexCoord = gl.TexCoord
local glTexture = gl.Texture
local glTexRect = gl.TexRect
local glVertex = gl.Vertex
local glBeginEnd = gl.BeginEnd
local glText = gl.Text
local glScissor = gl.Scissor
local glPushMatrix = gl.PushMatrix
local glPopMatrix = gl.PopMatrix
local glTranslate = gl.Translate
local glRotate = gl.Rotate
local glScale = gl.Scale
local glUnitRaw = gl.UnitRaw
local glUseShader = gl.UseShader
local glCallList = gl.CallList
local glLineWidth = gl.LineWidth

local spGetGroundHeight = Spring.GetGroundHeight
local spGetUnitsInRectangle = Spring.GetUnitsInRectangle
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitBasePosition = Spring.GetUnitBasePosition
local spGetUnitDirection = Spring.GetUnitDirection
local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitDefID = Spring.GetUnitDefID
local spGetFeatureDefID = Spring.GetFeatureDefID
local spGetFeatureDirection = Spring.GetFeatureDirection
local spGetFeaturePosition = Spring.GetFeaturePosition
local spGetFeatureTeam = Spring.GetFeatureTeam
local spGetFeaturesInRectangle = Spring.GetFeaturesInRectangle
local spIsUnitSelected = Spring.IsUnitSelected
local spGetUnitHealth = Spring.GetUnitHealth
local spGetMouseState = Spring.GetMouseState
local spGetUnitLosState = Spring.GetUnitLosState

local rad2deg = 180 / math.pi
local atan2 = math.atan2
local mapSizeX = Game.mapSizeX
local mapSizeZ = Game.mapSizeZ

----------------------------------------------------------------------------------------------------
-- Local functions
----------------------------------------------------------------------------------------------------
-- Utility
function RecalculateWorldCoordinates()
	local hw, hh = 0.5 * (pr - pl) / zoom, 0.5 * (pt - pb) / zoom
	wl, wr, wb, wt = wcx - hw, wcx + hw, wcz + hh, wcz - hh 
end
function RecalculateGroundTextureCoordinates()
	if wl < 0 then
		gvl = pl + (pr - pl) * (-wl / (wr - wl))
		gcl = 0
	else
		gvl = pl
		gcl = wl / mapSizeX
	end
	if wr > mapSizeX then
		gvr = pr - (pr - pl) * ((wr - mapSizeX) / (wr - wl))
		gcr = 1
	else
		gvr = pr
		gcr = wr / mapSizeX
	end
	if wt < 0 then
		gvt = pt - (pt - pb) * (-wt / (wb - wt))
		gct = 0
	else
		gvt = pt
		gct = wt / mapSizeZ
	end
	if wb > mapSizeZ then
		gvb = pb + (pt - pb) * ((wb - mapSizeZ) / (wb - wt))
		gcb = 1
	else
		gvb = pb
		gcb = wb / mapSizeZ
	end
end
local function UpdateCentering(mx, my)
	local _, pos = Spring.TraceScreenRay(mx, my, true)
	if pos and pos[2] > -10000 then
		wcx, wcz = pos[1], pos[3]
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
	end
end
local function UpdateTracking()
	
	local uCount = 0
	local ax, az = 0, 0
	local stillAlive = {}
	
	for t = 1, #areTracking do
		local uID = areTracking[t]
		local ux, uy, uz = spGetUnitBasePosition(uID)
		if ux then
			ax = ax + ux
			az = az + uz
			uCount = uCount + 1
			stillAlive[uCount] = uID
		end
	end
	
	if uCount > 0 then
		
		wcx = math.min(math.max(ax / uCount, 0), mapSizeX)
		wcz = math.min(math.max(az / uCount, 0), mapSizeZ)
		
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
		
		areTracking = stillAlive
	else
		areTracking = nil
	end
end
local function PipToWorldCoords(mx, my)
	return wl + (wr - wl) * ((mx - pl) / (pr - pl)),
		   wb + (wt - wb) * ((my - pb) / (pt - pb))
end
local function WorldToPipCoords(wx, wz)
	return pl + (pr - pl) * ((wx - wl) / (wr - wl)),
		   pb + (pt - pb) * ((wz - wb) / (wt - wb))
end
function SetupTeamColors(useSimple)
	if useSimple then
		teamColors = {}
		local myTeamID = Spring.GetMyTeamID()
		local teamList = Spring.GetTeamList()
		for i = 1, #teamList do
			local tID = teamList[i]
			if tID == myTeamID then
				teamColors[tID] = simpleColorSelf
			else
				if Spring.AreTeamsAllied(myTeamID, tID) then
					teamColors[tID] = simpleColorAlly
				else
					teamColors[tID] = simpleColorEnemy
				end
			end
		end
	else
		teamColors = {}
		local teamList = Spring.GetTeamList()
		for i = 1, #teamList do
			local tID = teamList[i]
			teamColors[tID] = {Spring.GetTeamColor(tID)}
		end
	end
end

-- Drawing
local function ResizeHandleVertices(t)
	glVertex(pr, pb)
	glVertex(pr - buttonSize, pb)
	glVertex(pr, pb + buttonSize)
end
local function GroundTextureVertices()
	glTexCoord(gcl, gcb); glVertex(gvl, gvb)
	glTexCoord(gcr, gcb); glVertex(gvr, gvb)
	glTexCoord(gcr, gct); glVertex(gvr, gvt)
	glTexCoord(gcl, gct); glVertex(gvl, gvt)
end
local function RectangleVertices(l, b, r, t)
	glVertex(l - 0.5, b - 0.5) -- Bottom-left
	glVertex(r + 0.5, b - 0.5) -- Bottom-right
	glVertex(r + 0.5, t + 0.5) -- Top-right
	glVertex(l - 0.5, t + 0.5) -- Top-left
end
local function UnitBuildingVerts(prog)
	local f = 2 * prog
	glVertex(-1, 0.1, -1); glVertex(-1 + f, 0.1, -1    )
	glVertex( 1, 0.1, -1); glVertex( 1    , 0.1, -1 + f)
	glVertex( 1, 0.1,  1); glVertex( 1 - f, 0.1,  1    )
	glVertex(-1, 0.1,  1); glVertex(-1    , 0.1,  1 - f)
end
local function DrawPanel(l, r, b, t)
	
	glColor(panelBackColor)
	glRect(l, b, r, t)
	
	glLineWidth(1.0)
	glColor(panelBorderColor)
	glBeginEnd(GL_LINE_LOOP, RectangleVertices, l, b, r, t)
end
local function DrawGroundLine(x1, z1, x2, z2)
	local dx, dz = x2 - x1, z2 - z1
	for s = 0, 1, 0.0625 do
		local tx, tz = x1 + dx * s, z1 + dz * s
		glVertex(tx, spGetGroundHeight(tx, tz) + 5.0, tz)
	end
end
local function DrawGroundBox(l, r, b, t)
	DrawGroundLine(l, t, r, t)
	DrawGroundLine(r, t, r, b)
	DrawGroundLine(r, b, l, b)
	DrawGroundLine(l, b, l, t)
end
local function DrawUnit(uID)
	
	local uTeam = spGetUnitTeam(uID)
	local ux, uy, uz = spGetUnitBasePosition(uID)
	
	glPushMatrix()
		glTranslate(ux - wcx, wcz - uz, 0)
		
		if (drawBlipsOnly == false) and (specFullView or spGetUnitLosState(uID, myAllyTeamID).los) then -- else, must be in radar only (or it wouldn't have been found in GetUnitsInRect)
			
			local uDefID = spGetUnitDefID(uID)
			local dirx, _, dirz = spGetUnitDirection(uID)
			local uHeading = dirx and (atan2(dirx, dirz) * rad2deg) or 0 -- Sometimes dirx is nil, why?
			local uHP, uMaxHP, _, _, uBuildProg = spGetUnitHealth(uID)
			local isSelected = spIsUnitSelected(uID)
			
			glRotate(75, 1, 0, 0)
			glRotate(uHeading, 0, 1, 0)
			glColor(teamColors[uTeam])
			glTexture(0, unitDefTextures[uDefID] or '$units')
			glUnitRaw(uID,true)	
			
			if isSelected or (uBuildProg and uBuildProg < 1) then
				
				glTexture(0, false)
				glUseShader(0)
				glBlending(true)
				
				glScale(xsizes[uDefID], 1, zsizes[uDefID])
				
				if isSelected then
					glColor(1, 1, 1, 1)
					glCallList(unitOutlineList)
				end
				
				if uBuildProg and uBuildProg < 1 then
					glScale(1.15, 1, 1.15)
					glColor(0, 0, 0, 1)
					glCallList(unitOutlineList)
					glColor(1, 1, 0, 1)
					glBeginEnd(GL_LINES, UnitBuildingVerts, uBuildProg)
				end
				
				glUseShader(unitShader)
				glBlending(false)
			end
		else
			local idx = #pipBlipTeam + 1
			pipBlipTeam[idx] = uTeam
			pipBlipX[idx], pipBlipY[idx] = WorldToPipCoords(ux, uz)
			
			--[[
			glTexture(0, false)
			glUseShader(0)
			glBlending(true)
			
			glTexture('LuaUI/Images/PipBlip.png')
			glColor(teamColors[uTeam])
			glCallList(radarDotList)
			glTexture(false)
			
			glUseShader(unitShader)
			glBlending(false)
			]]--
		end
		
	glPopMatrix()
end
local function DrawFeature(fID)
	
	local fDefID = spGetFeatureDefID(fID)
	if noModelFeatures[fDefID] then return end
	
	local fx, fy, fz = spGetFeaturePosition(fID)
	local dirx, _, dirz = spGetFeatureDirection(fID)
	local uHeading = dirx and atan2(dirx, dirz) * rad2deg or 0
	
	glPushMatrix()
		glTranslate(fx - wcx, wcz - fz, 0)
		glRotate(65, 1, 0, 0)
		glRotate(uHeading, 0, 1, 0)
		glTexture(0, '%-' .. fDefID .. ':0')
		gl.FeatureShape(fDefID, spGetFeatureTeam(fID))
	glPopMatrix()
end
local function GetUnitAtPoint(wx, wz)
	local factoryID
	for i = 1, #pipUnits do
		local uID = pipUnits[i]
		local ux, uy, uz = spGetUnitPosition(uID)
		if ux then
			local uDefID = spGetUnitDefID(uID)
			local dx, dz = ux - wx, uz - wz
			if dx*dx + dz*dz < (radiusSqs[uDefID] or radarDotRadius*radarDotRadius) then
				if isFactory[uDefID] then
					factoryID = uID
				else
					return uID
				end
			end
		end
	end
	return factoryID
end
local function GetFeatureAtPoint(wx, wz)
	for i = 1, #pipFeatures do
		local fID = pipFeatures[i]
		local fx, fy, fz = spGetFeaturePosition(fID)
		if fx then
			local dx, dz = fx - wx, fz - wz
			if dx*dx + dz*dz < featureRadiusSqs[spGetFeatureDefID(fID)] then
				return fID
			end
		end
	end
end
local function GetIDAtPoint(wx, wz)
	local uID = GetUnitAtPoint(wx, wz)
	if uID then return uID end
	local fID = GetFeatureAtPoint(wx, wz)
	if fID then return fID + Game.maxUnits end
end
local function UnitQueueVertices(uID)
	local uCmds = Spring.GetUnitCommands(uID)
	if #uCmds == 0 then return end
	local ux, uy, uz = spGetUnitPosition(uID)
	local px, pz = WorldToPipCoords(ux, uz)
	for i = 1, #uCmds do
		local cmd = uCmds[i]
		if (cmd.id < 0) or positionCmds[cmd.id] then
			local cx, cy, cz
			if #cmd.params >= 3 then
				cx, cy, cz = cmd.params[1], cmd.params[2], cmd.params[3]
			elseif #cmd.params == 1 then
				if cmd.params[1] > Game.maxUnits then
					cx, cy, cz = spGetFeaturePosition(cmd.params[1] - Game.maxUnits)
				else
					cx, cy, cz = spGetUnitPosition(cmd.params[1])
				end
			end
			if cx then
				local nx, nz = WorldToPipCoords(cx, cz)
				glColor(cmdColors[cmd.id] or cmdColors.unknown)
				glVertex(px, pz)
				glVertex(nx, nz)
				px, pz = nx, nz
			end
		end
	end
end
local function GetCmdOpts(alt, ctrl, meta, shift, right)
	
	local opts = { alt=alt, ctrl=ctrl, meta=meta, shift=shift, right=right }
	local coded = 0
	
	if alt   then coded = coded + CMD.OPT_ALT   end
	if ctrl  then coded = coded + CMD.OPT_CTRL  end
	if meta  then coded = coded + CMD.OPT_META  end
	if shift then coded = coded + CMD.OPT_SHIFT end
	if right then coded = coded + CMD.OPT_RIGHT end
	
	opts.coded = coded
	return opts
end
local function GiveNotifyingOrder(cmdID, cmdParams, cmdOpts)
	
	if widgetHandler:CommandNotify(cmdID, cmdParams, cmdOpts) then
		return
	end
	
	Spring.GiveOrder(cmdID, cmdParams, cmdOpts.coded)
end
local function IssueCommandAtPoint(cmdID, wx, wz, usingRMB)
	
	local alt, ctrl, meta, shift = Spring.GetModKeyState()
	local cmdOpts = GetCmdOpts(alt, ctrl, meta, shift, usingRMB)
	
	local id = GetIDAtPoint(wx, wz)
	if id then
		GiveNotifyingOrder(cmdID, {id}, cmdOpts)
	else
		if cmdID > 0 then
			GiveNotifyingOrder(cmdID, {wx, spGetGroundHeight(wx, wz), wz}, cmdOpts)
		else
			GiveNotifyingOrder(cmdID, {wx, spGetGroundHeight(wx, wz), wz, Spring.GetBuildFacing()}, cmdOpts)
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Callins
----------------------------------------------------------------------------------------------------
function widget:Initialize()
	
	unitOutlineList = gl.CreateList(function()
		gl.BeginEnd(GL.LINE_LOOP, function()
								gl.Vertex( 1, 0, 1)
								gl.Vertex( 1, 0,-1)
								gl.Vertex(-1, 0,-1)
								gl.Vertex(-1, 0, 1)
							end)
		end)
	
	radarDotList = gl.CreateList(function()
			glTexture('LuaUI/Images/PipBlip.png')
			glBeginEnd(GL_QUADS, function()
					glVertex( radarDotRadius, radarDotRadius)
					glVertex( radarDotRadius,-radarDotRadius)
					glVertex(-radarDotRadius,-radarDotRadius)
					glVertex(-radarDotRadius, radarDotRadius)
				end)
			glTexture(false)
		end)
	
	unitShader = gl.CreateShader({
			fragment = [[
				uniform sampler2D unitTex;
				void main(void) {
					gl_FragData[0]     = texture2D(unitTex, gl_TexCoord[0].st);
					gl_FragData[0].rgb = mix(gl_FragData[0].rgb, gl_Color.rgb, gl_FragData[0].a);
					gl_FragData[0].a   = gl_FragCoord.z;
				}
			]],
		})
	
	for uDefID, uDef in pairs(UnitDefs) do
		if uDef.model.type == 's3o' then
			unitDefTextures[uDefID] = '%' .. uDefID .. ':0'
		end
		xsizes[uDefID] = uDef.xsize * 4
		zsizes[uDefID] = uDef.zsize * 4
		radiusSqs[uDefID] = uDef.radius * uDef.radius
		if uDef.isFactory then
			isFactory[uDefID] = true
		end
	end
	
	for fDefID, fDef in pairs(FeatureDefs) do
		if fDef.modelname == '' then
			noModelFeatures[fDefID] = true
		end
		local fx, fz = 8 * fDef.xsize, 8 * fDef.zsize
		featureRadiusSqs[fDefID] = fx*fx + fz*fz
	end
	
	SetupTeamColors(usingSimpleColors)
	panelBorderColor = usingLightBorder and panelBorderColorLight or panelBorderColorDark
	
	gameHasStarted = (Spring.GetGameFrame() > 0)
	startX, _, startZ = Spring.GetTeamStartPosition(Spring.GetMyTeamID())
	if startX and startX >= 0 then
		wcx, wcz = startX, startZ
	end
	
	RecalculateWorldCoordinates()
	RecalculateGroundTextureCoordinates()
end
function widget:Shutdown()
	gl.DeleteShader(unitShader)
	gl.DeleteList(unitOutlineList)
	gl.DeleteList(radarDotList)
end

function widget:GetConfigData()
	return {
			pl=pl, pr=pr, pb=pb, pt=pt,
			zoom=zoom,
			inMinMode=inMinMode,
			minModeL=minModeL,
			minModeB=minModeB,
			drawingGround=drawingGround,
			drawBlipsOnly=drawBlipsOnly,
			usingSimpleColors=usingSimpleColors,
			usingLightBorder=usingLightBorder,
		}
end
function widget:SetConfigData(data)
	pl = data.pl or pl
	pr = data.pr or pr
	pb = data.pb or pb
	pt = data.pt or pt
	zoom = data.zoom or zoom
	inMinMode = data.inMinMode or inMinMode
	minModeL = data.minModeL or minModeL
	minModeB = data.minModeB or minModeL
	drawingGround = data.drawingGround or drawingGround
	drawBlipsOnly = data.drawBlipsOnly or drawBlipsOnly
	usingLightBorder = data.usingLightBorder or usingLightBorder
	usingSimpleColors = data.usingSimpleColors or usingSimpleColors
end

function widget:DrawScreen()
	
	if inMinMode then
		DrawPanel(minModeL, minModeL + buttonSize, minModeB, minModeB + buttonSize)
		glTexture('LuaUI/Images/PipMaximize.png')
		glTexRect(minModeL, minModeB, minModeL + buttonSize, minModeB + buttonSize)
		glTexture(false)
		return
	end
	
	----------------------------------------------------------------------------------------------------
	-- Updates
	----------------------------------------------------------------------------------------------------
	if areCentering then
		UpdateCentering(spGetMouseState())
	end
	
	if areTracking then
		UpdateTracking()
	end
	
	----------------------------------------------------------------------------------------------------
	-- Panel
	----------------------------------------------------------------------------------------------------
	DrawPanel(pl, pr, pb, pt)
	
	if drawingGround then
		glColor(1, 1, 1, 1)
		glTexture('$grass')
			glBeginEnd(GL_QUADS, GroundTextureVertices)
		glTexture(false)
	end
	
	----------------------------------------------------------------------------------------------------
	-- Units, features, and queues
	----------------------------------------------------------------------------------------------------
	_, _, specFullView = Spring.GetSpectatingState()
	myAllyTeamID = Spring.GetMyAllyTeamID()
	
	pipUnits = spGetUnitsInRectangle(wl - 50, wt - 50, wr + 50, wb + 50)
	pipFeatures = spGetFeaturesInRectangle(wl - 50, wt - 50, wr + 50, wb + 50)
	pipBlipTeam = {}
	pipBlipX = {}
	pipBlipY = {}
	
	--if #pipUnits > 0 or #pipFeatures > 0 then
		
		glScissor(pl, pb, pr - pl, pt - pb)
		glDepthTest(true)
		glDepthMask(true)
		glBlending(false)
		glUseShader(unitShader)
		glLineWidth(2.0)
		
		glPushMatrix()
			glTranslate(0.5 * (pl + pr), 0.5 * (pb + pt), 0)
			glScale(zoom, zoom, zoom)
			
			for i = 1, #pipUnits do
				DrawUnit(pipUnits[i])
			end
			
			glTexture(0, '$units') -- For some reason, this prevents a bug with features drawing solid white
				-- Note: Features do their own glTexture(0, ...) every time
			
			for i = 1, #pipFeatures do
				DrawFeature(pipFeatures[i])
			end
		glPopMatrix()
		
		glTexture(0, false)
		glUseShader(0)
		glBlending(true)
		glDepthMask(false)
		glDepthTest(false)
		
		local _, _, _, shift = Spring.GetModKeyState()
		if shift then
			gl.LineStipple("springdefault")
			local selUnits = Spring.GetSelectedUnits()
			for i = 1, #selUnits do
				glBeginEnd(GL_LINES, UnitQueueVertices, selUnits[i])
			end
			gl.LineStipple(false)
		end
		
		local r = radarDotRadius * zoom
		glTexture('LuaUI/Images/PipBlip.png')
		for i = 1, #pipBlipTeam do
			local cx = pipBlipX[i]
			local cy = pipBlipY[i]
			glColor(teamColors[pipBlipTeam[i]])
			glTexRect(cx - r, cy - r, cx + r, cy + r)
		end
		glTexture(false)
		
		glLineWidth(1.0)
		glScissor(false)
		
	--end
	
	----------------------------------------------------------------------------------------------------
	-- Buttons and misc
	----------------------------------------------------------------------------------------------------
	glColor(panelBorderColor)
	glLineWidth(1.0)
	glBeginEnd(GL_TRIANGLES, ResizeHandleVertices)
	
	-- Minimize button
	glTexture('LuaUI/Images/PipMinimize.png')
	glTexRect(pr - buttonSize, pt - buttonSize, pr, pt)
	
	-- Other buttons
	local bx = pl
	for i = 1, #buttons do
		glTexture(buttons[i].texture)
		glTexRect(bx, pb, bx + buttonSize, pb + buttonSize)
		bx = bx + buttonSize
	end
	glTexture(false)
	
	if areTracking then
		--glText('\255\128\255\128Tracking ' .. #areTracking, pr - buttonSize, pb, fontSize, 'rdo')
		glText('\255\128\255\128Tracking ' .. #areTracking .. ' units', pl, pt, fontSize, 'do')
	end
	
	glColor(1, 1, 1, 1)
end
function widget:DrawWorld()
	if inMinMode then return end
	glColor(1, 1, 0, 0.25)
	glLineWidth(1.49)
	glDepthTest(true)
	glBeginEnd(GL_LINE_STRIP, DrawGroundBox, wl, wr, wb, wt)
	glDepthTest(false)
end
function widget:Update(dt)
	if areZoomingIn then
		zoom = math.min(zoom * zoomRate ^ dt, zoomMax)
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
	elseif areZoomingOut then
		zoom = math.max(zoom / zoomRate ^ dt, zoomMin)
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
	end
	if not gameHasStarted then
		local newX, _, newZ = Spring.GetTeamStartPosition(Spring.GetMyTeamID())
		if newX ~= startX then
			startX, startZ = newX, newZ
			wcx, wcz = startX, startZ
			RecalculateWorldCoordinates()
			RecalculateGroundTextureCoordinates()
		end
	end
end
function widget:GameStart()
	gameHasStarted = true
end

function widget:IsAbove(mx, my)
	if inMinMode then
		return mx >= minModeL and mx <= minModeL + buttonSize and my >= minModeB and my <= minModeB + buttonSize
	end
	return mx >= pl and mx <= pr and my >= pb and my <= pt and (GetTooltip(self, mx, my) ~= nil)
end
function widget:GetTooltip(mx, my)
	
	if inMinMode then
		return 'Maximize PiP window'
	end
	
	if mx >= pr - buttonSize and my >= pt - buttonSize then
		return 'Minimize PiP window'
	end
	
	if pr-mx + my-pb <= buttonSize then
		return 'Resize PiP window [Drag]'
	end
	
	if my <= pb + buttonSize then
		local pressedButton = buttons[1 + math.floor((mx - pl) / buttonSize)]
		if pressedButton then
			return pressedButton.tooltip
		end
	end
	
	-- Return nothing, use default tooltip, whatever that is
end

function widget:DefaultCommand()
	if inMinMode then return end
	local mx, my = spGetMouseState()
	if mx >= pl and mx <= pr and
	   my >= pb and my <= pt then
		local wx, wz = PipToWorldCoords(mx, my)
		local uID = GetUnitAtPoint(wx, wz)
		if uID then
			if Spring.IsUnitAllied(uID) then
				return CMD.GUARD
			else
				return CMD.ATTACK
			end
		end
		local fID = GetFeatureAtPoint(wx, wz)
		if fID then
			return CMD.RECLAIM
		end
		return CMD.MOVE
	end
end

function widget:MouseWheel(up, value)
	if not inMidMode then
		local mx, my = spGetMouseState()
		if mx >= pl and mx <= pr and
		   my >= pb and my <= pt then
			if up then
				zoom = math.max(zoom / zoomWheel, zoomMin)
			else
				zoom = math.min(zoom * zoomWheel, zoomMax)
			end
			RecalculateWorldCoordinates()
			RecalculateGroundTextureCoordinates()
			return true
		end
	end
end
function widget:MousePress(mx, my, mButton)
	
	-- Check if we are centering the view, takes priority
	if mButton == 1 then
		if areCentering then
			UpdateCentering(mx, my)
			areCentering = false
			return true
		end
	end
	
	-- Check if we are in min mode
	if inMinMode then
		-- Was maximize clicked?
		if mButton == 1 and
		   mx >= minModeL and mx <= minModeL + buttonSize and
		   my >= minModeB and my <= minModeB + buttonSize then
			inMinMode = false
			return true
		end
		-- Nothing else to click while in minMode
		return
	end
	
	-- Did we click within the pip window ?
	if mx >= pl and mx <= pr and
	   my >= pb and my <= pt then
		
		-- Was it a left click? -> check buttons
		if mButton == 1 then
			
			-- Minimizing?
			if mx >= pr - buttonSize and my >= pt - buttonSize then
				inMinMode = true
				local sw, sh = Spring.GetWindowGeometry()
				if pl < sw * 0.5 then
					minModeL = pl
				else
					minModeL = pr - buttonSize
				end
				if pb < sh * 0.5 then
					minModeB = pb
				else
					minModeB = pt - buttonSize
				end
				return true
			end
			
			-- Resize thing
			if pr-mx + my-pb <= buttonSize then
				areResizing = true
				return true
			end
			
			-- Button row
			if my <= pb + buttonSize then
				local pressedButton = buttons[1 + math.floor((mx - pl) / buttonSize)]
				if pressedButton then
					pressedButton.OnPress()
					return true
				end
			end
			
			-- Missed buttons with left click, so what did we click on?
			local wx, wz = PipToWorldCoords(mx, my)
			local _, cmdID = Spring.GetActiveCommand()
			if cmdID then
				
				IssueCommandAtPoint(cmdID, wx, wz, false)
				
				local _, _, _, shift = Spring.GetModKeyState()
				if not shift then
					Spring.SetActiveCommand(0)
				end
				
				return true
			else
				local uID = GetUnitAtPoint(wx, wz)
				if uID then
					local _, _, _, shift = Spring.GetModKeyState()
					Spring.SelectUnitArray({uID}, shift)
					return true
				end
			end
			
			-- Didn't hit anything, must be panning
			arePanning = true
			return true
			
		elseif mButton == 3 then
			
			local _, cmdID = Spring.GetActiveCommand()
			if cmdID then
				Spring.SetActiveCommand(0)
				return true
			end
			
			local _, cmdID = Spring.GetDefaultCommand()
			if cmdID then
				local wx, wz = PipToWorldCoords(mx, my)
				IssueCommandAtPoint(cmdID, wx, wz, true)
				return true
			end
			
			-- No command (either no units selected, or none can move), and right-click on pip window = do what?
			return true
		end
	end
end
function widget:MouseMove(mx, my, dx, dy, mButton)
	
	if areResizing then
		
		if pr+dx - pl >= minPanelSize then pr = pr + dx end
		if pt-dy - pb >= minPanelSize then pb = pb + dy end
		
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
		
	elseif areDragging then
		
		pl = pl + dx
		pr = pr + dx
		pb = pb + dy
		pt = pt + dy
		
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
		
	elseif arePanning then
		
		wcx = math.min(math.max(wcx - dx / zoom, 0), mapSizeX)
		wcz = math.min(math.max(wcz + dy / zoom, 0), mapSizeZ)
		
		RecalculateWorldCoordinates()
		RecalculateGroundTextureCoordinates()
	end
end
function widget:MouseRelease(mx, my, mButton)
	areResizing = false
	areDragging = false
	arePanning = false
	areZoomingIn = false
	areZoomingOut = false
end

function widget:TextCommand(cmd)
	for i = 1, #buttons do
		local button = buttons[i]
		if cmd == button.command then
			button.OnPress()
			return true
		end
	end
end
