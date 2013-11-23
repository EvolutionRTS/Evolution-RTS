function widget:GetInfo()
  return {
    name      = "Color Select Screen",
    desc      = "Choose your color screen",
    author    = "Smoth",
    date      = "Dec, 2012",
    license   = "PD",
    layer     = 5,
    enabled   = true  -- loaded by default?
  }
end

local pigments						= WG.pigments
local finishes						= WG.finishes --BuildPaintBucketsAndFinishes(colorSets, false)
local finishLookup					= WG.finishLookup	--CreateColorLookup(finishes)
local pigmentLookup					= WG.pigmentLookup	--CreateColorLookup(pigments)
local bucketsChoices				= WG.bucketsChoices

-- VFS.Include('gamedata/libs/ShaderAndColorUtilities.lua')

-- local colorSets	= GetColorSets()
-- local pigments, finishes			= BuildPaintBucketsAndFinishes(colorSets, false)
-- local finishLookup					= CreateColorLookup(finishes)
-- local pigmentLookup					= CreateColorLookup(pigments)
-- local bucketsChoices				= GetBucketTypes()

--local Chili
local gridchildren	= {}
local unitDetails	= {}
local RatioVal		= WG.RatioVal
local screenSizeX, screenSizeY = Spring.GetViewGeometry()
	
local paintGridHeight 	= 47 * RatioVal
local paintGridWidth 	= 20 * RatioVal
local rowCount			= 11


local currentMaterial
local currentUnitDefId

local currentMaterialUpdate = false
local currentMaterialSets	= { "white_standard", "white_standard", 
								"white_standard", "white_standard", 
								"white", "white", "white", "white", }

-- chili windows
local finishChoices, paintChoices, textureChoices
local lastchoice
local lookingForNewUnit

local textureDir = "bitmaps/detailtextures/"
local textureFiles = VFS.DirList(textureDir)
table.sort(textureFiles)
				
local spGetSelectedUnits	= Spring.GetSelectedUnits 
local spGetUnitDefID		= Spring.GetUnitDefID

function GetUpdateColors(currentUnitSelection, bucketName, bucketValue)	
	bucketId	= bucketsChoices[bucketName]
	if(bucketValue ~= "done" and  bucketId~= nil)then
		currentMaterialSets[bucketId] = bucketValue
	else
		currentMaterialUpdate = true
	end
end

local function showHideMaterials(current)
	if current then
		if current < 5 and lastchoice == "finishChoices" then
			return			
		end
		if (current < 8 and current > 4) and lastchoice == "paintChoices" then
			return
		end
		if current > 8 and lastchoice == "textureChoices" then
			return
		end
		
		if current < 5 then
			lastchoice = "finishChoices"
			Chili.Screen0:AddChild(finishChoices)
			Chili.Screen0:RemoveChild(paintChoices)
			Chili.Screen0:RemoveChild(textureChoices)
		elseif current < 8 and current > 4 then
			lastchoice = "paintChoices"
			Chili.Screen0:AddChild(paintChoices)
			Chili.Screen0:RemoveChild(finishChoices)
			Chili.Screen0:RemoveChild(textureChoices)
		elseif current > 8 then
			lastchoice = "textureChoices"
			Chili.Screen0:AddChild(textureChoices)
			Chili.Screen0:RemoveChild(paintChoices)
			Chili.Screen0:RemoveChild(finishChoices)
		end
	end
end

local function UpdateTexturePreview(number, params)	
	local currentDetail	= unitDetails[bucketsChoices[number]]
	local currentTexture	= params:sub(24)

	currentDetail.children[1].children[1]:SetCaption(currentTexture)

	currentDetail.children[3].file	= params
	currentDetail.children[3]:Invalidate()
end	

local function UpdatePaintPreview(number, params)

	local currentDetail	= unitDetails[bucketsChoices[number]]
	local pigmentId		= pigmentLookup[params]
	
	-- Spring.Echo(pigmentId, pigmentId == nil, pigmentLookup, pigmentLookup["white"])
	if pigmentId == nil then
		pigmentId		= pigmentLookup["white"]
	end
	
	--Spring.Echo(pigmentId)
	local pigmentColor	= pigments[pigmentId].colors 
	
	currentDetail.children[1].children[1]:SetCaption(params)
	
	currentDetail.children[4].color	= {1,1,1,1}
	currentDetail.children[4]:Invalidate()
	currentDetail.children[5].color = pigmentColor
	currentDetail.children[5]:Invalidate()
end	
				
local function UpdateFinishPreview(number, params)
	local currentDetail	= unitDetails[bucketsChoices[number]]
	local finishId		= finishLookup[params]
	
	--Spring.Echo(finishId, finishId == nil, finishLookup)
	--Spring.Echo(finishLookup["white_standard"])
	if finishId == nil then
		finishId		= finishLookup["white_standard"]
	end

	local finishColor	= finishes[finishId].colors
	
	currentDetail.children[1]:SetCaption(params)
	
	currentDetail.children[3].color	= {1,1,1,finishColor[4]}
	currentDetail.children[4].color	= {finishColor[1], finishColor[2], finishColor[3], 1}
	currentDetail.children[5].color	= {finishColor[1]*0.2, finishColor[2]*0.2, finishColor[3]*0.2, 1}
	
	currentDetail.children[3]:Invalidate()	
	currentDetail.children[4]:Invalidate()
	currentDetail.children[5]:Invalidate()
end	

local function ResetBucketPreview()
	unitDetails["UnitName"]:SetCaption("Choose a unit to begin")

	UpdatePaintPreview(5, "white")
	UpdatePaintPreview(6, "white")
	UpdatePaintPreview(7, "white")
	UpdatePaintPreview(8, "white")
				
	UpdateFinishPreview(1, "white_standard")
	UpdateFinishPreview(2, "white_standard")
	UpdateFinishPreview(3, "white_standard")					
	UpdateFinishPreview(4, "white_standard")
end

local function BuildOutPaintGrid()
	local counterY = 0
	local counterX = 0
	for paintName, paintValues in pairs (pigments) do
		--Spring.Echo("paint_"..paintName, paintValues)
		local parentPanel = paintSection
		local gridXPos		=	3.8 *	counterX * RatioVal --.. "%"
		local gridYPos		=	3.8 *	counterY * RatioVal --.. "%"
		local basesize		=	4*	RatioVal
		local currentName	=	paintValues.name

		gridchildren[currentName] = Chili.Button:New{
			parent				= parentPanel,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			--tooltip			= GetToolTip(paintName),
			OnMouseUp = { 
				function()
					if currentUnitDefId then						
						Spring.SendLuaRulesMsg('updateunitcolors' .. currentMaterial .. currentName)
						UpdatePaintPreview(currentMaterial, currentName)	
					end
				end
			},
			children = {
				Chili.Image:New{
					file 	= ":cl:".. "bitmaps/ui/buckets/label.png",
					x		= "10%",
					y		= "10%",
					width	= "85%",  
					height	= "85%",
					color	= {1,1,1,1},
					children	={
						Chili.Label:New{
							caption	= paintValues.name, 
							x		= "10%",
							y		= "30%", 
							fontsize = 10,			
						},					
					},
				},
				Chili.Image:New{
					file = ":cl:".. "bitmaps/ui/buckets/metal.png",
					x		= "10%",
					y		= "10%",
					width	= "85%",  
					height	= "85%",
				},
				Chili.Image:New{
					file 	= ":cl:".. "bitmaps/ui/buckets/finish2.png",
					x		= "11%",
					y		= "0%",
					width	= "83%",  
					height	= "100%",
					color	= {1,1,1,1},
				},
				Chili.Image:New{
					file	= ":cl:".. "bitmaps/ui/buckets/paint.png",
					x		= "11%",
					y		= "2%",
					width	= "83%",  
					height	= "100%",
					color 	= paintValues.colors,
				},
			}
		}
		
		counterY = counterY + 1
		if(math.floor(counterY/rowCount) == 1) then
			counterX = counterX + 1
			counterY = 0
		end
	end
end

local function BuildOutFinishGrid()
	local counterY = 0
	local counterX = 0
	
	for finishId, finishValues in pairs (finishes) do
		--Spring.Echo(finishName, finishValues[1], finishValues[2], finishValues[3], finishValues[4])
		local finishName	= finishValues.displayName--WG.finishLookUp[finishId]
		local finishColor	= finishValues.colors
		local parentPanel	= finishSection
		local currentName	= finishValues.name
		local gridXPos =	4* counterX * RatioVal --.. "%"
		local gridYPos =	4* counterY * RatioVal --.. "%"
		local basesize =	4*RatioVal

		gridchildren[currentName] = Chili.Button:New{
			parent				= parentPanel,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			--tooltip				= GetToolTip(paintName),
			OnMouseUp = { 
				function()
					if currentUnitDefId then
						--Spring.Echo(currentMaterial, currentName)
						Spring.SendLuaRulesMsg('updateunitcolors' .. currentMaterial .. currentName)
						UpdateFinishPreview(currentMaterial, currentName)						
					end
				end
			},
			children = {
				Chili.Label:New{
					caption	= finishName,
					x		= "10%",
					y		= "30%", 
					fontsize = 10,
				},
				Chili.Image:New{
					file = ":cl:".. "bitmaps/ui/buckets/metal.png",
					x		= "10%",
					y		= "10%",
					width	= "85%",  
					height	= "85%",
				},
				Chili.Image:New{
					file 	= ":cl:".. "bitmaps/ui/buckets/finish2.png",
					x		= "11%",
					y		= "10%",
					width	= "83%",  
					height	= "85%",
					color	= {1,1,1,finishColor[4]},
				},
				Chili.Image:New{
					file 	= ":cl:".. "bitmaps/ui/buckets/finish.png",
					x		= "11%",
					y		= "10%",
					width	= "83%",  
					height	= "85%",
					color	= {finishColor[1], finishColor[2], finishColor[3], 1},
				},
				Chili.Image:New{
					file	= ":cl:".. "bitmaps/ui/buckets/paint.png",
					x		= "11%",
					y		= "10%",
					width	= "83%",  
					height	= "85%",
					color 	= {finishColor[1]*0.2, finishColor[2]*0.2, finishColor[3]*0.2, 1},
				},
			}
		}
		
		counterY = counterY + 1
		if(math.floor(counterY/rowCount) == 1) then
			counterX = counterX + 1
			counterY = 0
		end
	end
end

local function SaveUnitBuckets()
	--Spring.Echo("WOO WOO", WG.playerSchemeSelections)
	 
	local outupDir = "unitThemes/"
	Spring.CreateDir(outupDir)
	
	--currentUnitDefId
end

local function BuildOutPaintList()
	local counterY	= 0
	local counterX	= 0
	local counter	= 1
	local finishNum = 2
	local paintNum	= 1	
	
	local bucketName	= "sheenR"	
	local parentPanel	= unitSection
	local basesize		= 5 * RatioVal
			
	while counter < 11 do
		--Spring.Echo(finishName, finishValues[1], finishValues[2], finishValues[3], finishValues[4])

		local gridXPos	= 1 * RatioVal + 5* counterX * RatioVal --.. "%"
		local gridYPos	= 5 * RatioVal + 5* counterY * RatioVal --.. "%"

		current = bucketsChoices[counter]
		local currentIndex = counter
		if counter <9 then
			unitDetails[current] = Chili.Button:New{
				parent				= parentPanel,
				caption				= '',
				x					= gridXPos,
				y					= gridYPos,
				width				= basesize,  
				height				= basesize,
				backgroundColor 	= {0.1,0.1,0.1,0,},
				OnMouseUp = { 
					function()
						--Spring.Echo(currentIndex, current)
						showHideMaterials(currentIndex)
						currentMaterial	= currentIndex
					end
				},
				children = {
					Chili.Image:New{
						file 	= ":cl:bitmaps/ui/buckets/label.png",
						x		= "10%",
						y		= "10%",
						width	= "85%",  
						height	= "85%",
						color	= {1,1,1,1},
						children= {
							Chili.Label:New{
								caption	= current,
								x		= "10%",
								y		= "30%", 
								fontsize = 10,
							},						
						},
					},
					Chili.Image:New{
						file = ":cl:bitmaps/ui/buckets/metal.png",
						x		= "10%",
						y		= "10%",
						width	= "85%",  
						height	= "85%",
					},
					Chili.Image:New{
						file 	= ":cl:bitmaps/ui/buckets/finish2.png",
						x		= "11%",
						y		= "10%",
						width	= "83%",  
						height	= "85%",
						color	= {1,1,1,0},
					},
					Chili.Image:New{
						file 	= ":cl:bitmaps/ui/buckets/finish.png",
						x		= "11%",
						y		= "10%",
						width	= "83%",  
						height	= "85%",
						color	= {1, 1, 1, 0},
					},
					Chili.Image:New{
						file	= ":cl:bitmaps/ui/buckets/paint.png",
						x		= "11%",
						y		= "10%",
						width	= "83%",  
						height	= "85%",
						color 	= {1, 1, 1, 1},
					},
				}
			}
		else
			unitDetails[current] = Chili.Button:New{
				parent				= parentPanel,
				caption				= '',

				x					= gridXPos,
				y					= gridYPos,
				width				= basesize,  
				height				= basesize,
				backgroundColor 	= {0.1,0.1,0.1,0,},
				OnMouseUp = { 
					function()
						--Spring.Echo(currentIndex, current)
						showHideMaterials(currentIndex)
						currentMaterial	= currentIndex
					end
				},
				children = {
					Chili.Image:New{
						file 	= ":cl:bitmaps/ui/buckets/label.png",						
						x		= "10%",
						y		= "10%",
						width	= "85%",  
						height	= "85%",
						color	= {1,1,1,1},
						children= {
							Chili.Label:New{
								caption	= current,
								x		= "10%",
								y		= "30%", 
								fontsize = 10,
							},						
						},
					},
					Chili.Image:New{
						file	= ":cl:bitmaps/detailtextures/tigerstripe1.png",
						x		= "11%",
						y		= "10%",
						width	= "83%",  
						height	= "85%",
						color 	= {1, 1, 1, 1},
					},
				}
			}
		end
		
		counter = counter + 1
		counterY = counterY + 1
		if(math.floor(counterY/4) == 1) then
			counterX = counterX + 1
			counterY = 0
			bucketName = current
			finishNum = finishNum +1
		else
			bucketName = current
			paintNum = paintNum +1
		end
	end
	

		
	unitDetails["UnitName"] =	Chili.Label:New{
		caption	= "Choose a unit to begin", 
		parent	= parentPanel,
		x		= 2 * RatioVal,
		y		= 3.5 * RatioVal,
		fontsize = 16,
	}
	
	ResetBucketPreview()
	

		
	Chili.Button:New{
		parent				= parentPanel,
		caption				= 'Select a unit',
		x					= 6 * RatioVal,
		y					= 1 * RatioVal,
		width				= 7 * RatioVal,  
		height				= 2 * RatioVal,
		backgroundColor 	= {0.0, 1.0, 0.0, 1,},
		--tooltip				= GetToolTip(paintName),
		OnMouseUp = { 
			function()
				lookingForNewUnit = true
			end
		},
	}
	
	Chili.Button:New{
		parent				= parentPanel,
		caption				= 'save selection',
		x					= 2 * RatioVal,
		y					= 25.5 * RatioVal,
		width				= 6 * RatioVal,  
		height				= 2 * RatioVal,
		backgroundColor 	= {0.0, 1.0, 0.1, 1,},
		--tooltip				= GetToolTip(paintName),
		OnMouseUp = { 
			function()
				ResetBucketPreview()	
				SaveUnitBuckets()
			end
		},
	}
	
	Chili.Button:New{
		parent				= parentPanel,
		caption				= 'Cancel selection',
		x					= 11 * RatioVal,
		y					= 25.5 * RatioVal,
		width				= 6 * RatioVal,  
		height				= 2 * RatioVal,
		backgroundColor 	= {0.0, 1.0, 0.0, 1,},
		--tooltip				= GetToolTip(paintName),
		OnMouseUp = { 
			function()
				ResetBucketPreview()	
				lookingForNewUnit = false
			end
		},
	}
end

local function BuildOutTexturesGrid()
	local counterY = 0
	local counterX = 0
	
	for identity=1,#textureFiles do
		local currentTexture	= textureFiles[identity]:sub(24)
		local gridXPos		=	4*	counterX * RatioVal --.. "%"
		local gridYPos		=	4*	counterY * RatioVal --.. "%"
		local basesize		=	4*	RatioVal
		local columnCount	=	#textureFiles/rowCount

		unitDetails[currentTexture] = Chili.Button:New{
			parent				= textureSection,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			OnMouseUp = { 
				function()
					if currentUnitDefId then						
						Spring.SendLuaRulesMsg('updateprojectionTexture' .. currentMaterial .. currentTexture)
						UpdateTexturePreview(currentMaterial, textureFiles[identity])						
					end
				end
			},
			children = {
				Chili.Image:New{
					file 	= ":cl:bitmaps/ui/buckets/label.png",
					x		= "10%",
					y		= "10%",
					width	= "85%",  
					height	= "85%",
					color	= {1,1,1,0.6},
					children= {
						Chili.Label:New{
							caption	= currentTexture,
							x		= "10%",
							y		= "30%", 
							fontsize = 10,
						},						
					},
				},
				Chili.Image:New{
					file	= ":cl:" .. textureFiles[identity],
					x		= "11%",
					y		= "10%",
					width	= "83%",  
					height	= "85%",
					color 	= {1, 1, 1, 1},
				},
			}
		}
		
		counterX = counterX + 1
		if(math.floor(counterX/columnCount) == 1) then
			counterY = counterY + 1
			counterX = 0
		end
	end
end

local function CreateWindows()
	--local myTeamID = GetMyTeamID()
	
	--Spring.Echo(screenSizeX, screenSizeY)
	paintChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "paint list parent",
		right	= 0,
		y		= 5 * RatioVal,
		dockable		= false,
		clientWidth		= paintGridWidth,--screenSizeX-screenSizeX*0.75,
		clientHeight	= paintGridHeight,--screenSizeY-screenSizeY*0.50,
		draggable		= false,
		resizable		= false,
		--color			= mainColor,
	}

	paintSection	= Chili.ScrollPanel:New{
		parent		= paintChoices,
		color		= {0,0,0,1},
		name		= "paint list",
		padding 	= {0,0,0,0},
		x			= "2.5%",
		y			= "2.5%",
		dockable	= false,
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
	}	
	
	finishChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "finish list parent",
		right	= 0,
		y		= 5 * RatioVal,
		dockable		= false,
		clientWidth		= paintGridWidth,--screenSizeX-screenSizeX*0.75,
		clientHeight	= paintGridHeight,--screenSizeY-screenSizeY*0.50,
		draggable		= false,
		resizable		= false,
		--color			= mainColor,
	}

	finishSection	= Chili.ScrollPanel:New{
		parent		= finishChoices,
		color		= {0,0,0,1},
		name		= "finish list",
		padding 	= {0,0,0,0},
		x			= "2.5%",
		y			= "2.5%",
		dockable	= false,
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
	}
	
	textureChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "unit texture list parent",
		right	= 0,
		y		= 5 * RatioVal,
		dockable		= false,
		clientWidth		= paintGridWidth,--screenSizeX-screenSizeX*0.75,
		clientHeight	= paintGridHeight,--screenSizeY-screenSizeY*0.50,
		draggable		= false,
		resizable		= false,
		--color			= mainColor,
	}

	textureSection	= Chili.ScrollPanel:New{
		parent		= textureChoices,
		color		= {0,0,0,1},
		name		= "unit texture list",
		padding 	= {0,0,0,0},
		x			= "2.5%",
		y			= "2.5%",
		dockable	= false,
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
	}
	
	unitChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "unit list parent",
		right	= 20 * RatioVal,
		y		= 16 * RatioVal,
		dockable		= false,
		clientWidth		= 20 * RatioVal,--screenSizeX-screenSizeX*0.75,
		clientHeight	= 30 * RatioVal,--screenSizeY-screenSizeY*0.50,
		draggable		= false,
		resizable		= false,
		--color			= mainColor,
	}
	
	unitSection	= Chili.ScrollPanel:New{
		parent		= unitChoices,
		color		= {0,0,0,1},
		name		= "unit paint list",
		padding 	= {0,0,0,0},
		x			= "2.5%",
		y			= "2.5%",
		dockable	= false,
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
		children	= unitBuckets,
	}

	BuildOutPaintList()
	BuildOutPaintGrid()
	BuildOutFinishGrid()
	BuildOutTexturesGrid()
end

function widget:Initialize()
	Chili = WG.Chili
	
	if (not Chili) then
		widgetHandler:RemoveWidget()
		return
	end
	
	widgetHandler:RegisterGlobal("SetUpdateColors", GetUpdateColors)
	CreateWindows()
	
	Chili.Screen0:RemoveChild(textureChoices)
	Chili.Screen0:RemoveChild(paintChoices)
	Chili.Screen0:RemoveChild(finishChoices)
end	

function widget:Update()
	if lookingForNewUnit then
		local currentSelections = spGetSelectedUnits()
		if #currentSelections == 1 then
			lookingForNewUnit	= false
			currentUnitDefId	= spGetUnitDefID(currentSelections[1])
			
			Spring.SendLuaRulesMsg('selectcolorunit' .. currentSelections[1])					
			unitDetails["UnitName"]:SetCaption(UnitDefs[currentUnitDefId].name)	
		elseif #currentSelections > 1 then
			unitDetails["UnitName"]:SetCaption("You may only select 1 unit at a time")		
		else
			unitDetails["UnitName"]:SetCaption("Choose a unit to begin")
		end
	end
	
	if 	currentMaterialUpdate then				
		UpdatePaintPreview(5, currentMaterialSets[5])
		UpdatePaintPreview(6, currentMaterialSets[6])
		UpdatePaintPreview(7, currentMaterialSets[7])
		UpdatePaintPreview(8, currentMaterialSets[8])
					
		UpdateFinishPreview(1, currentMaterialSets[1])
		UpdateFinishPreview(2, currentMaterialSets[2])
		UpdateFinishPreview(3, currentMaterialSets[3])					
		UpdateFinishPreview(4, currentMaterialSets[4])	
		currentMaterialUpdate = false
	end
end