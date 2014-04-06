function widget:GetInfo()
  return {
    name      = "Color Select Screen",
    desc      = "Choose your color screen",
    author    = "Smoth",
    date      = "Dec, 2012",
    license   = "PD",
    layer     = 5,
    enabled   = false  -- loaded by default?
  }
end

local pigments						= WG.pigments
local finishes						= WG.finishes --BuildPaintBucketsAndFinishes(colorSets, false)
local matrices						= WG.matrices
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
	
local paintGridHeight 	= 45 * RatioVal
local paintGridWidth 	= 20 * RatioVal
local rowCount			= 11


local currentMaterial
local currentUnitDefId
local currentUnit 

local currentMaterialUpdate = false
local currentMaterialSets	= { "white_standard", "white_standard", 
								"white_standard", "white_standard", 
								"white", "white", "white", "white", }

-- chili windows
local finishChoices, paintChoices, textureChoices
local lastChoice
local currentChoice
local lookingForNewUnit

local textureDir = "bitmaps/detailtextures/"
local textureFiles = VFS.DirList(textureDir)
table.sort(textureFiles)

-- texture that is used when nothing is selected.
local nilTexture			= ":cl:bitmaps/ui/buckets/notexture.gif"
				
local spGetSelectedUnits	= Spring.GetSelectedUnits 
local spGetUnitDefID		= Spring.GetUnitDefID

-----------------------------------------------------------------
-- recieves bucket settings from BucketManagement gadget
-----------------------------------------------------------------
function GetUpdateColors(currentUnitSelection, bucketName, bucketValue)	
	local bucketId	= bucketsChoices[bucketName]
	if(bucketValue ~= "done" and  bucketId~= nil)then
		currentMaterialSets[bucketId] = bucketValue
	else
		currentMaterialUpdate = true
	end
	--Spring.Echo(bucketName .. " = " .. bucketValue, bucketId)
end

-----------------------------------------------------------------
-- Update bucket settings within the widget in order to facilitate
-- the saving of bucket settings.
-----------------------------------------------------------------
local function KickTheBucket(bucketsChoice, setting)
	local bucketId	= bucketsChoices[bucketsChoice]
	currentMaterialSets[bucketId] = setting
end

-----------------------------------------------------------------
-- determines current visible bucket setting selection window
-----------------------------------------------------------------
local function showHideBucketGrid(current)
	if current then
		if current < 5 then
			currentChoice = finishChoices
		elseif current <= 8 and current > 4 then
			currentChoice = paintChoices
		elseif current <= 10 and current > 8 then
			currentChoice = textureChoices
		else
			currentChoice = matrixChoices
		end
		
		if lastChoice ~= currentChoice then
			if lastChoice ~= nil then
				Chili.Screen0:RemoveChild(lastChoice)
			end
			lastChoice = currentChoice
			Chili.Screen0:AddChild(currentChoice)
		else
			return
		end
	end
end

-----------------------------------------------------------------
-- updates paint preview in buckets setting area
-----------------------------------------------------------------
local function UpdatePaintPreview(number, params)

	local currentDetail	= unitDetails[bucketsChoices[number]]
	local pigmentId		= pigmentLookup[params]
	
	-- Spring.Echo(pigmentId, pigmentId == nil, pigmentLookup, pigmentLookup["white"])
	if pigmentId == nil then
		pigmentId		= pigmentLookup["white"]
	end
	
	--Spring.Echo(pigmentId)
	local pigmentColor	= pigments[pigmentId].colors 
	
	currentDetail.children[3].color	= {1,1,1,1}
	currentDetail.children[3]:Invalidate()
	currentDetail.children[4].color = pigmentColor
	currentDetail.children[4]:Invalidate()
end	

-----------------------------------------------------------------
-- updates finish preview in buckets setting area
-----------------------------------------------------------------
local function UpdateFinishPreview(number, params)
	local currentDetail	= unitDetails[bucketsChoices[number]]
	local finishId		= finishLookup[params]
	
	--Spring.Echo(finishId, finishId == nil, finishLookup)
	--Spring.Echo(finishLookup["white_standard"])
	if finishId == nil then
		finishId		= finishLookup["white_standard"]
	end

	local finishColor	= finishes[finishId].colors
	
	currentDetail.children[2].color	= {1,1,1,finishColor[4]}
	currentDetail.children[3].color	= {finishColor[1], finishColor[2], finishColor[3], 1}
	currentDetail.children[4].color	= {finishColor[1]*0.2, finishColor[2]*0.2, finishColor[3]*0.2, 1}

	currentDetail.children[2]:Invalidate()	
	currentDetail.children[3]:Invalidate()
	currentDetail.children[4]:Invalidate()
end	

-----------------------------------------------------------------
-- updates texture image in buckets setting area
-----------------------------------------------------------------
local function UpdateTexturePreview(number, textureName)
	local currentDetail	= unitDetails[bucketsChoices[number]]
	--Spring.Echo(number, textureName)
	if textureName and textureName ~= "" then
		currentDetail.children[1].file = textureName
		currentDetail.children[1]:Invalidate() 
	else
		currentDetail.children[1].file = ""
		currentDetail.children[1]:Invalidate() 
	end
end

-----------------------------------------------------------------
-- resets everything to white. Used when unit is deselected
-----------------------------------------------------------------
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

-----------------------------------------------------------------
-- builds out items for selection preview of paint colors
-----------------------------------------------------------------
local function BuildOutPaintGrid()
	local counterY	= 0
	local counterX 	= 0		
	local basesize	= 3.8 * RatioVal
	
	for paintName, paintValues in pairs (pigments) do
		--Spring.Echo("paint_"..paintName, paintValues)
		local gridXPos		=	3.8 *	counterX * RatioVal --.. "%"
		local gridYPos		=	3.8 *	counterY * RatioVal --.. "%"

		local currentName	=	paintValues.name

		gridchildren[currentName] = Chili.Button:New{
			parent				= paintSection,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			padding				= {2,2,2,2};
			--tooltip			= GetToolTip(paintName),
			OnMouseUp = { 
				function()
					if currentUnitDefId then
						Spring.SendLuaRulesMsg('updateunitcolors' .. currentMaterial .. currentName)
						UpdatePaintPreview(currentMaterial, currentName)
						KickTheBucket(bucketsChoices[currentMaterial], currentName)
					end
				end
			},
			children = {
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

-----------------------------------------------------------------
-- builds out items for selection preview of finish colors
-----------------------------------------------------------------
local function BuildOutFinishGrid()
	local counterY	= 0
	local counterX	= 0
	local basesize	= 3.8*RatioVal

	for finishId, finishValues in pairs (finishes) do
		--Spring.Echo(finishName, finishValues[1], finishValues[2], finishValues[3], finishValues[4])
		local finishColor	= finishValues.colors
		local currentName	= finishValues.name
		
		local gridXPos =	3.8* counterX * RatioVal --.. "%"
		local gridYPos =	3.8* counterY * RatioVal --.. "%"


		gridchildren[currentName] = Chili.Button:New{
			parent				= finishSection,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			padding				= {2,2,2,2};
			--tooltip				= GetToolTip(paintName),
			OnMouseUp = { 
				function()
					if currentUnitDefId then
						--Spring.Echo(currentMaterial, currentName)
						Spring.SendLuaRulesMsg('updateunitcolors' .. currentMaterial .. currentName)
						UpdateFinishPreview(currentMaterial, currentName)
						KickTheBucket(bucketsChoices[currentMaterial], currentName)				
					end
				end
			},
			children = {
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

-----------------------------------------------------------------
-- builds out items for selection listing for available matrices
-----------------------------------------------------------------
local function BuildOutMatrixGrid()

	local counterY = 0
	local counterX = 0
	local basesize =	2*RatioVal
		
	--Spring.Echo("building matrix grid")
	for matricesId, matricesValues in pairs (matrices) do
		--Spring.Echo(matricesId, matricesValues)
		local gridXPos =	1.5* RatioVal
		local gridYPos =	2* counterY * RatioVal + (1.5 * RatioVal)

		gridchildren[matricesId] = Chili.Button:New{
			parent				= matrixSection,
			caption				= matricesId,
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize*8,  
			height				= basesize,
			backgroundColor 	= WG.mainColor,
			padding				= {2,2,2,2};
			--tooltip				= GetToolTip(paintName),
			OnMouseUp = { 
				function()
					if currentUnitDefId then
						--Spring.Echo(currentMaterial, matricesId)
						Spring.SendLuaRulesMsg('updateprojectionTexture' .. currentMaterial-8 .. matricesId)
						Spring.SendLuaRulesMsg('updateunitmaterial')
						KickTheBucket(bucketsChoices[currentMaterial], matricesId)
						--UpdateFinishPreview(currentMaterial, matricesId)						
					end
				end
			},
		}
		
		counterY = counterY + 1
	end
end

-----------------------------------------------------------------
-- builds out items for selection listing for available textures
-----------------------------------------------------------------
local function BuildOutTexturesGrid()
	local counterY	= 0
	local counterX	= 0
	local sizeRoot	= 8
	local basesize	= sizeRoot * RatioVal
	
	local textureCount	=	#textureFiles+1
	local gridXPos		=	sizeRoot * counterX * RatioVal
	local gridYPos		=	sizeRoot * counterY * RatioVal
	local columnCount	=	math.floor(textureCount/(rowCount/2))-1
	
	-- add initial option for NO TEXTURE
	local nullTexture	= "notexture.gif"
	unitDetails[nullTexture] = Chili.Button:New{
		parent				= textureSection,
		caption				= '',
		x					= gridXPos,
		y					= gridYPos,
		width				= basesize,  
		height				= basesize,
		backgroundColor 	= {0.1,0.1,0.1,0,},
		padding				= {0, 0, 0, 0},
		OnMouseUp = { 
			function()
				if currentUnitDefId then
					Spring.SendLuaRulesMsg('updateprojectionTexture' .. currentMaterial-8 .. nullTexture)
					UpdateTexturePreview(currentMaterial, nilTexture)
						KickTheBucket(bucketsChoices[currentMaterial], "")
					Spring.SendLuaRulesMsg('updateunitmaterial')
				end
			end
		},
		children = {
			Chili.Image:New{
				file	=  nilTexture,
				x		= "11%",
				y		= "10%",
				width	= "85%",  
				height	= "85%",
				color 	= {1, 1, 1, 1},
			},
		}
	}
	--	add the rest
	counterY =1
	
	for identity=1, #textureFiles do
		local currentTexture	= textureFiles[identity]:sub(24)
		gridXPos			=	sizeRoot * counterX * RatioVal --.. "%"
		gridYPos			=	sizeRoot * counterY * RatioVal --.. "%"

		unitDetails[currentTexture] = Chili.Button:New{
			parent				= textureSection,
			caption				= '',
			x					= gridXPos,
			y					= gridYPos,
			width				= basesize,  
			height				= basesize,
			backgroundColor 	= {0.1,0.1,0.1,0,},
			padding				= {0, 0, 0, 0},
			OnMouseUp = { 
				function()
					if currentUnitDefId then
						Spring.SendLuaRulesMsg('updateprojectionTexture' .. currentMaterial-8 .. currentTexture)
						UpdateTexturePreview(currentMaterial, textureFiles[identity])
						Spring.SendLuaRulesMsg('updateunitmaterial')
						KickTheBucket(bucketsChoices[currentMaterial], textureFiles[identity])
						--Spring.Echo(currentMaterial, textureFiles[identity], bucketsChoices[currentMaterial], currentTexture)
					end
				end
			},
			children = {
				Chili.Image:New{
					file	= ":cl:" .. textureFiles[identity],
					x		= "11%",
					y		= "10%",
					width	= "90%",  
					height	= "90%",
					color 	= {1, 1, 1, 1},
				},
			}
		}
		
		counterY = counterY + 1
		--Spring.Echo(math.floor(gridYPos), math.floor(gridXPos), counterY, counterX,columnCount)
		if(math.floor(counterY/columnCount) == 1) then
			counterX = counterX + 1
			counterY = 0
		end
	end
end

-----------------------------------------------------------------
-- Saves current unit bucket settings to file in: 
-- springdir/unitThemes/unitname.lua"
--
-- each setting file will need to be placed in the folder:
-- modulebase\gamedata\configs\paintjobs\themename\
-----------------------------------------------------------------
local function SaveUnitBuckets()
	local outupDir		= "unitThemes/"
	Spring.CreateDir(outupDir)
	
	local unitName		= UnitDefs[currentUnitDefId].name
	local filename		= outupDir .. unitName..".lua"
	local stringBuilder	= {}
	
	local currentFile = io.open(filename, "w+")
	if (currentFile) then
		--currentUnitDefId
		--start
		stringBuilder[#stringBuilder+1]	= ("local colors	= {")
		--color and sheen data
		for k,v in pairs(currentMaterialSets) do
			--don't write setting for things that have no values
			if v ~= "" and v ~= nil then
				stringBuilder[#stringBuilder+1]	= (	"\t\t".. bucketsChoices[k] .. 
													"\t\t= \"" .. v .. "\",")			
			end
		end	
		stringBuilder[#stringBuilder+1]	= ("\t\t----------------------------------")
		stringBuilder[#stringBuilder+1]	= ("}\nreturn colors")
		
		local builtString	= table.concat(stringBuilder,"\n")
		currentFile:write(builtString)
		currentFile:close()
		
		Spring.Echo("saving current unit", unitName)
	else
		Spring.Echo("could not find file:" .. filename)
	end
end

-----------------------------------------------------------------
-- builds out items for the preview of bucket settings and
-- selection of bucket to change settings
-----------------------------------------------------------------
local function BuildOutBucketList()
	local counterY	= 0
	local counterX	= 0
	local counter	= 1
	local finishNum = 2
	local paintNum	= 1	
	
	local bucketName	= "sheenR"	
	local parentPanel	= unitSection
	local basesize		= 5 * RatioVal
			
	while counter < 13 do
		--Spring.Echo(finishName, finishValues[1], finishValues[2], finishValues[3], finishValues[4])

		local gridXPos	= 1 * RatioVal + 5* counterX * RatioVal --.. "%"
		local gridYPos	= 5 * RatioVal + 5* counterY * RatioVal --.. "%"

		--Spring.Echo(bucketsChoices[counter])
		current = bucketsChoices[counter]
		local currentIndex = counter
		if counter < 9 then
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
						showHideBucketGrid(currentIndex)
						currentMaterial	= currentIndex
					end
				},
				children = {
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
		
		--textures
		elseif  counter > 8  and counter < 11 then 
			gridYPos = gridYPos + (basesize/10)
			unitDetails[current] = Chili.Button:New{
				parent				= parentPanel,
				caption				= '',

				x					= gridXPos,
				y					= gridYPos,
				width				= basesize*0.9,  
				height				= basesize*0.9,
				backgroundColor 	= {0.1,0.1,0.1,0,},
				OnMouseUp = { 
					function()
						--Spring.Echo(currentIndex, current)
						showHideBucketGrid(currentIndex)
						currentMaterial	= currentIndex
					end
				},
				children = {
					Chili.Image:New{
						file	= nilTexture;
						x		= "11%";
						y		= "10%";
						width	= "83%"; 
						height	= "85%";
						color 	= {1, 1, 1, 1};
					},
				}
			}
		-- matrices
		elseif  counter > 10 then 
			gridYPos	= gridYPos - 10.25 * RatioVal
			--Spring.Echo("matrix:", current)
			unitDetails[bucketsChoices[current]] = Chili.Button:New{
				parent				= parentPanel,
				caption				= 'matrix',

				x					= gridXPos,
				y					= gridYPos+basesize,
				width				= basesize,  
				height				= basesize/5,
				backgroundColor 	= {0.1,0.1,0.1,0,},
				OnMouseUp = { 
					function()
						--Spring.Echo(currentIndex, current, counter)
						showHideBucketGrid(currentIndex)
						currentMaterial	= currentIndex
					end
				},
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
		padding			= {2,2,2,2};
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
				--ResetBucketPreview()	
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

local function CreateWindows()
	--local myTeamID = GetMyTeamID()
	
	--Spring.Echo(screenSizeX, screenSizeY)
	paintChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "paint list parent",
		right	= 0,
		y		= 5.2 * RatioVal,
		padding			= {2,2,2,2};
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
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
	}	
	
	--matrix windows
	matrixChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "matrix list parent",
		right	= 0,
		y		= 5.2 * RatioVal,
		padding			= {2,2,2,2};
		clientWidth		= paintGridWidth,--screenSizeX-screenSizeX*0.75,
		clientHeight	= paintGridHeight,--screenSizeY-screenSizeY*0.50,
		draggable		= false,
		resizable		= false,
		--color			= mainColor,
	}
	
	matrixSection	= Chili.ScrollPanel:New{
		parent		= matrixChoices,
		color		= {0,0,0,1},
		name		= "matrix list",
		padding 	= {0,0,0,0},
		x			= "2.5%",
		y			= "2.5%",
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
	}		
	
	--finish windows
	finishChoices	= Chili.Window:New{
		parent	= Chili.Screen0,
		color	= WG.mainColor,
		name	= "finish list parent",
		right	= 0,
		y		= 5.2 * RatioVal,
		padding			= {2,2,2,2};
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
		y		= 5.2 * RatioVal,
		padding			= {2,2,2,2};
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
		width		= "95%",  
		height		= "95%", 
		draggable	= false,
		resizable	= false,
		children	= unitBuckets,
	}

	BuildOutBucketList()
	BuildOutPaintGrid()
	BuildOutFinishGrid()
	BuildOutMatrixGrid()
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
	Chili.Screen0:RemoveChild(matrixChoices)
end	

function widget:Update()
	if lookingForNewUnit then
		local currentSelections = spGetSelectedUnits()
		if #currentSelections == 1 then
			lookingForNewUnit	= false
			currentUnit			= currentSelections[1]
			currentUnitDefId	= spGetUnitDefID(currentUnit)
			
			Spring.SendLuaRulesMsg('selectcolorunit' .. currentUnit)
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
		
		UpdateTexturePreview(9, currentMaterialSets[9])	
		UpdateTexturePreview(10, currentMaterialSets[10])	
		currentMaterialUpdate = false
	end
end