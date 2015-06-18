function widget:GetInfo()
	return {
		name			= "Chili game manual",
		desc			= "",
		author			= "Smoth",
		date			= "7/7/2014",
		license		 	= "PD",
		layer		 	= 99999999,
		experimental	= false,
		enabled	 		= true,
	}
end

local Chili
local manualImageLocation = ":cl:bitmaps/ui/manual/"

local settingDefaults = {
		text					= manualImageLocation .. "1x1trans.png",
		textShadow				= false,
		textColor				= {1,1,1,1},
		textOutline				= false,
		textOutlineWidth		= 3,
		textOutlineColor		= {0,0,0,1},
		textOutlineWeight		= 3,
		textVerticalAlign		= "ascender",
		textHorizontalAlign		= "left",
		--thumbnail	
		thumbImage				= manualImageLocation .. "1x1trans.png",
		thumbKeepAspect			= true,
		thumbColor				= {1,1,1,1},
		--section background
		backgroundImage1		= manualImageLocation .. "1x1trans.png",
		backgroundKeepAspect	= false,
		backgroundColor			= {1,1,1,1},
}

local colorDarkTeal	= {0,0.1,0.1,1}
local colorHighlightTeal	= {0,0.4,0.24,1}


local manualWindow, img_indexVisibility, topicListing, contentArea, topicTabs

local blackBox				= manualImageLocation .. "blackbox.png"
local imgRightArrow			= "bitmaps/ui/arrow_right.png"
local imgLeftArrow			= "bitmaps/ui/arrow_left.png"
local manualLocation		= 'gamedata/configs/game manual/'
local manualLocationLength	= string.len(manualLocation)+1

local menuOpen				= true
local menuButtonSize		= 50

-- max tabs for article pages
local maxPages				= 10
-- max sections per page.
local maxSections			= 8

local currentPage = 1
local currentArticle = 1

local sectionPercentBase	= (100/maxSections)
-- look up for the section controls in the content area
local pageSections		= {};
local sectionBG			= {};
local sectionThumb		= {};
local sectionText		= {};

-- look up for the index controls
local topicListing		= {}
-- look up for the article tabs controls(buttons because tabs are a PITA)
local topicTabSet		= {}

VFS.Include('gamedata/VFSUtils.lua') -- needed for RecursiveFileSearch
local manualFiles 			= RecursiveFileSearch(manualLocation, '*.lua') 
local manualSections		= {}
local manualSectionLookup = {}
	
--Spring.Echo("STARTING MANUAL")

for _, filename in ipairs(manualFiles) do
	topicName = string.sub(filename,manualLocationLength+1)
	--Spring.Echo("Manual file: ", filename)
	manualSections[topicName]	= VFS.Include(filename)
	table.sort(manualSections)
	Spring.Echo(manualSections[topicName])
end 

--Spring.Echo("Topios loaded", #manualSections)

local function buildLookup(sourceTable)
	--Spring.Echo("buidling lookup table")
	local counter = 0
	local lookUpTable	= {} 
	for k,v in pairs(sourceTable) do
		counter = counter + 1
		lookUpTable[counter] = k
	end
	
	--Spring.Echo(counter .. " entries found")
	return lookUpTable
end
 
--
--Collapses the menu so the content area can be larger-
--
local function MenuToggle()
	local thirtyPercentManualArea = manualWindow.width * 0.3
	
	if menuOpen == false then
		img_indexVisibility.file	= imgLeftArrow;
		topicListing.width		= thirtyPercentManualArea;
		btn_indexVisibility.x	= thirtyPercentManualArea-menuButtonSize;
		topicArea.x				= thirtyPercentManualArea;
		menuOpen = true
	else
		img_indexVisibility.file	= imgRightArrow;

		topicListing.width		= menuButtonSize;
		btn_indexVisibility.x	= 0;
		topicArea.x				= menuButtonSize;
		topicArea.width			= manualWindow.width - menuButtonSize;
		
		menuOpen = false
	end

end

--
-- clear out all the sections
--
local function ResetPageSections()
	local sectionNumber = 0
	local currentSection
	
	while sectionNumber < maxSections do
		sectionNumber = sectionNumber +1	

		currentSection	= pageSections[sectionNumber]
		if currentSection then
			sectionText[sectionNumber]:SetText("")
			sectionText[sectionNumber]:Invalidate()
			
			sectionThumb[sectionNumber].file	= ""
			sectionThumb[sectionNumber]:Invalidate()
			
			sectionBG[sectionNumber].file		= ""
			sectionBG[sectionNumber]:Invalidate()
		end
	end
end

--
-- clear out all the tabs
--
local function ResetArticleTabs()	
	local pageNumber = 0
	while pageNumber < maxPages do
		pageNumber = pageNumber +1
		topicTabSet[pageNumber].caption = ""
		topicTabSet[pageNumber]:Invalidate()
	end
	
	topicTabSet[1].backgroundColor	= colorHighlightTeal;
end

--
-- load article tabs into content area
--
local function LoadTabs(topic, page)
	Spring.Echo(topic)
	ResetArticleTabs()	
	local pageNumber = 0
	for _,page in pairs(topic.article) do 
		pageNumber = pageNumber +1
		topicTabSet[pageNumber].caption = page.details.pageTitle
	end
end

-- 
-- removes all sections from content area
--
local function decouplePageSections()
	local sectionNumber = 0
	while sectionNumber < maxSections do
		sectionNumber = sectionNumber +1
		contentArea:RemoveChild(pageSections[sectionNumber])
	end
end

--
-- load article sections for this page.
--
local function LoadPage(topic, pageNumber)
	Spring.Echo("------------====LOADPAGE====---------------")
	Spring.Echo(topic, pageNumber)
	Spring.Echo("------------====LOADPAGE====---------------")
	decouplePageSections()
	
	local myArticle = topic.article
	
	local sectionNumber 	= 0
	local sectionCount		= #myArticle[pageNumber].sections
	local sectionSize		= contentArea.height/(sectionCount/100*100)
	
	for sectionNumber, section in pairs(myArticle[pageNumber].sections) do
		local currentSection		= pageSections[sectionNumber]
		local sectionTextFont	= sectionText[sectionNumber].font
		contentArea:AddChild(currentSection)
		
		currentSection:SetPos(currentSection.x, (sectionNumber-1) * sectionSize, 
								currentSection.width, sectionSize)

		sectionText[sectionNumber]:SetText(section.text or settingDefaults.text)
		sectionText[sectionNumber]:SetPos(10, 10, 
							pageSections[sectionNumber].children[2].width - 50, 
							pageSections[sectionNumber].children[2].height - 10)
							
		sectionTextFont.shadow			= section.textShadow			or settingDefaults.textShadow
		sectionTextFont.color			= section.textColor				or settingDefaults.textColor
		sectionTextFont.outline			= section.textOutline			or settingDefaults.textOutline
		sectionTextFont.outlineWidth	= section.textOutlineWidth		or settingDefaults.textOutlineWidth
		sectionTextFont.outlineColor	= section.textOutlineColor		or settingDefaults.textOutlineColor
		sectionTextFont.outlineWeight	= section.textOutlineWeight		or settingDefaults.textOutlineWeight
		sectionTextFont.valign			= section.textVerticalAlign		or settingDefaults.textVerticalAlign
		sectionTextFont.align			= section.textHorizontalAlign	or settingDefaults.textHorizontalAlign
		sectionText[sectionNumber]:UpdateLayout()
			
		sectionThumb[sectionNumber].file		= section.thumbImage		or settingDefaults.thumbImage
		sectionThumb[sectionNumber].keepAspect	= section.thumbKeepAspect	or settingDefaults.thumbKeepAspect
		sectionThumb[sectionNumber].color		= section.thumbColor		or settingDefaults.thumbColor
		
		sectionBG[sectionNumber].file		= section.backgroundImage1		or settingDefaults.backgroundImage1
		sectionBG[sectionNumber].keepAspect	= section.backgroundKeepAspect	or settingDefaults.backgroundKeepAspect
		sectionBG[sectionNumber].color		= section.backgroundColor		or settingDefaults.backgroundColor
		--sectionBG[sectionNumber]:Invalidate()		

		
		currentSection.children[1].height	= sectionSize
		currentSection.children[2].height	= sectionSize
	end

end

--
-- load article 
--
local function LoadArticle(topicId, page)
	local myTopic = manualSections[topicId]
	LoadTabs(myTopic, page)
	LoadPage(myTopic, page)
end

--
-- load next article page
--
local function NextPage(article, page)
	LoadPage(article, page)
end

--
-- load previous article page
--
local function PreviousPage(article, page)
	LoadPage(article, page)
end


--
--Select topic article from index
--
local function TopicSelect(article)

end


--
-- fills out the content display area.
--
local function BuildPageSections()
	local sectionId = 0
	local twentyPercent 	= contentArea.width	* 0.2
	local eightyPercent		= contentArea.width	* 0.8
	
	while ( sectionId < maxSections) do
		sectionId = sectionId +1;
		
		pageSections[sectionId] =  Chili.Window:New{
			parent			= contentArea;
			x				= 0;
			y				= (sectionId-1) * sectionPercentBase + 1 .. "%";
			name			= "contentWind" .. sectionId;
			width			= "100%";
			height			= sectionPercentBase - 0.5 .."%";
			dockable		= false;
			draggable		= false;
			resizable		= false;
			color			= {0,1,0,0};
				children = {	
				Chili.Window:New{
					parent			= pageSections[sectionId];
					name			= "left box ".. sectionId;
					x				= 0;
					width			= twentyPercent;
					height			= "100%";
					dockable		= false;
					draggable		= false;
					resizable		= false;
					color			= {0,1,0,0};
				},
				Chili.Window:New{
					parent			= pageSections[sectionId];
					name			= "right box ".. sectionId;
					x				= twentyPercent;
					width			= eightyPercent;
					height			= "100%";
					dockable		= false;
					draggable		= false;
					resizable		= false;
					color			= {0,0,0.2,0};
				},
			};
		}
		
		sectionThumb[sectionId] = Chili.Image:New{
					parent		= pageSections[sectionId].children[1];
					file		= "";
					height		= "100%";
					width		= "100%";
					keepAspect	= true;
				}

		sectionText[sectionId] = Chili.TextBox:New{
					parent		= pageSections[sectionId].children[2];
					x			= "2%";
					right		= "2%";
					y			= "1%";
					bottom		= "1%";
					text    	= "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
					valign		= "ascender";
					align		= "left";
					fontshadow	= true;
					fontsize	= 20;
				}
		
		sectionBG[sectionId] =   Chili.Image:New{
					parent		= pageSections[sectionId];
					file		= "";
					height		= "100%";
					width		= "100%";
					keepAspect	= false;
				}
		
		if sectionId %2 ==1 then
			pageSections[sectionId].children[1].x 		= eightyPercent;
			pageSections[sectionId].children[1].width	= twentyPercent;
			pageSections[sectionId].children[2].x		= 0;
			pageSections[sectionId].children[2].width	= eightyPercent;
		end	
	end
end

--
-- builds a list of topics for the index
--
local function BuildTopicIndex()
	local topicSize = topicScroll.height * 0.1
	local topicNumber = 0
	local topicButtonName	= "manualTopicIndex"
	local topicButtonNameNumber = string.len(topicButtonName)+1
	
	for topicId, topicValues in pairs (manualSections) do
		topicNumber = topicNumber + 1	
		Spring.Echo(topicNumber, "topicNumber")
		topicListing[topicNumber]	= Chili.Button:New{
			parent				= topicScroll;
			name				= topicButtonName .. topicNumber;
			caption				= topicValues.details.sectionTitle;
			x					= "5%";
			y					= topicSize * (topicNumber-1);
			width				= "90%";
			height				= topicSize;
			backgroundColor		= colorDarkTeal;
			OnMouseUp = {
				function(self) 
					local topicSelectedNow = string.sub(self.name,topicButtonNameNumber)
					if manualSectionLookup[topicSelectedNow] ~= currentArticle then
						topicListing[tonumber(currentArticle)].backgroundColor	= colorDarkTeal;
						self.backgroundColor = colorHighlightTeal;
						currentArticle = tonumber(topicSelectedNow)		
						
						LoadArticle(manualSectionLookup[currentArticle], 1)
					end
				end
			},
		}
	end
end

--
-- builds a page tabs for current article
--
local function BuildTopicTabs()
	local counter = 0
	local tabButtonName	= "manualTabPage"
	local tabButtonNumber = string.len(tabButtonName)+1
	
	while (counter < maxPages) do
		counter = counter + 1
		topicTabSet[counter]	= Chili.Button:New{
			parent				= topicPages;
			name				= tabButtonName .. counter;
			caption				= "page " .. counter;
			x					= (counter-1) * (100/maxPages) .. "%";
			y					= 0;
			width				= "9.5%";
			height				= "100%";
			backgroundColor		= colorDarkTeal;
			OnMouseUp = {
				function(self) 
					local tabSelectedNow = tonumber(string.sub(self.name,tabButtonNumber))
					local myArticle = manualSections[manualSectionLookup[currentArticle]].article
					if tabSelectedNow ~= currentPage and myArticle[tabSelectedNow] ~= nil then
						local pageNumber = 0
						while pageNumber < maxPages do
							pageNumber = pageNumber +1
							topicTabSet[pageNumber].backgroundColor	= colorDarkTeal;
						end
						self.backgroundColor = colorHighlightTeal;
						currentPage = tabSelectedNow

						--local myTopic = manualSections[topicId]
						LoadPage(manualSections[manualSectionLookup[currentArticle]], currentPage)
					end
				end
			},
		}
	end
end

function widget:Initialize()
	Chili = WG.Chili	
	
	if (not Chili) then
		widgetHandler:RemoveWidget()
		return
	end		

	manualWindow	= Chili.Window:New{
		parent		= Chili.Screen0,
		TileImage 		= blackBox,
		--y				= "20%";
		width			= "100%";
		height			= "100%";
		dockable		= false;
		draggable		= false;
		resizable		= false;
		color			= {0,0,0,1};
		padding 		= {0,0,0,0};
		children = {	
			-- kludge to deal with the lack of modal windows
			Chili.Button:New{
				caption			= '',
				width			= "100%";
				height			= "100%";
				backgroundColor	= {0,0,0,1};
				padding 		= {0,0,0,50};
			}
		};
		
	}		
	
	topicListing	= Chili.Window:New{
		parent			= manualWindow;
		TileImage 		= blackBox,
		name			= "topic listing";
		x				= "0%";
		y				= "0%";
		width			= "30%";
		height			= "100%";
		resizable		= false;
		color			= colorDarkTeal;
		padding 		= {0,0,0,0};
	}

	btn_indexVisibility = Chili.Button:New{
		parent				= topicListing,
		caption				= '',
		right				= 0,
		y					= "0",
		height				= menuButtonSize,
		width				= menuButtonSize,
		backgroundColor		= colorDarkTeal;
		padding 			= {5,5,5,5};
		OnMouseUp = { 
			function()
				MenuToggle()
			end
		},
	}
	
	img_indexVisibility = Chili.Image:New{
		file	= imgLeftArrow,
		parent	= btn_indexVisibility,
		width	= "100%",  
		height	= "100%",
		color		= {0,1,0,1};
	}
	
	topicListingText = Chili.Label:New{
		parent	= topicListing,
		caption	= "Topics", 
		x		= '2.5%', 
		y		= '2.5%', 
		fontsize	= 60,
	}	
	
	topicScroll	= Chili.ScrollPanel:New{
		parent			= topicListing;
		TileImage 		= blackBox,
		name			= "scrolling list of topic";
		padding 		= {10,10,10,10};
		x				= "0.5%";
		y				= "10%";
		width			= "99%";
		height			= "89%";
		dockable		= false;
		draggable		= false;
		resizable		= false;
		backgroundColor	= colorDarkTeal;
		color	= colorDarkTeal;
	}
	
	topicArea	= Chili.Window:New{
		parent			= manualWindow;
		TileImage 		= blackBox,
		name			= "topic display";
		x				= "30%";
		y				= "0%";
		width			= "70%";
		height			= "100%";
		dockable		= false;
		draggable		= false;
		resizable		= false;
		color			= {0,0,0,1};
		padding 		= {0,0,0,0};
	}
	
	contentArea	= Chili.Window:New{
		TileImage 		= blackBox,
		parent			= topicArea;
		name			= "topic content";
		x				= "0.5%";
		y				= "8%";
		width			= "99%";
		height			= "91%";
		dockable		= false;
		draggable		= false;
		resizable		= false;
		color			= colorDarkTeal;
		padding 		= {5,5,5,5};
	}
				
	topicPages	= Chili.Window:New{
		parent	= topicArea;
		x				= "1%";
		y				= "2%";
		width			= "98%";
		height			= "5%";
		resizable		= false;
		color			= colorDarkTeal;
		OnMouseUp = {
			Spring.Echo("BOOOM");
		}
	}
	
	
	BuildPageSections()	
	BuildTopicIndex()
	BuildTopicTabs()
	manualSectionLookup = buildLookup(manualSections)	
	topicTabSet[currentArticle].backgroundColor	= colorHighlightTeal;
	Spring.Echo("loading first article")
	LoadArticle(manualSectionLookup[currentArticle], 1)
end
