local confdata = {}
confdata.title = 'Evolution RTS'
confdata.title_image = LUAUI_DIRNAME .. 'Images/evologo.png'

local color = {
	white = {1,1,1,1},
	yellow = {1,1,0,1},
	gray = {0.5,.5,.5,1},
	darkgray = {0.3,.3,.3,1},
	cyan = {0,1,1,1},
	red = {1,0,0,1},
	darkred = {0.5,0,0,1},
	blue = {0,0,1,1},
	black = {0,0,0,1},
	darkgreen = {0,0.5,0,1},
	green = {0,1,0,1},
	postit = {1,0.9,0.5,1},
	
	grayred = {0.5,0.4,0.4,1},
	grayblue = {0.4,0.4,0.45,1},
	transblack = {0,0,0,0.3},
	transblack2 = {0,0,0,0.7},
	transGray = {0.1,0.1,0.1,0.8},
}
color.tooltip_bg = color.transGray
color.tooltip_fg = color.white
color.tooltip_info = color.cyan
color.tooltip_help = color.green

color.main_bg = color.transblack
color.main_fg = color.white

color.menu_bg = color.grayblue
color.menu_fg = color.white

color.game_bg = color.gray
color.game_fg = color.white

color.sub_bg	= color.transblack
color.sub_fg 	= color.white
color.sub_header = color.yellow

color.sub_button_bg = color.gray
color.sub_button_fg = color.white

color.sub_back_bg = color.grayblue
color.sub_back_fg = color.white

color.sub_close_bg = color.grayblue
color.sub_close_fg = color.white

color.stats_bg = color.sub_bg
color.stats_fg = color.sub_fg
color.stats_header = color.sub_header

color.context_bg = color.transblack
color.context_fg = color.white
color.context_header = color.yellow

confdata.color = color

local spSendCommands = Spring.SendCommands


confdata.eopt = {}
local path = ''

local function AddOption(option)
	option.path=path
	if not option.key then
		option.key = option.name
	end
	table.insert(confdata.eopt, option)
end

local function ShButton( caption, action2, tooltip, advanced )
	AddOption({
		type='button',
		name=caption,
		desc = tooltip or '',
		action = (type(action2) == 'string' and action2 or nil),
		OnChange = (type(action2) ~= 'string' and action2 or nil),
		key=caption,
		advanced = advanced,
	})
end

local function ShLabel( caption )
	AddOption({
		type='label',
		name=caption,
		value = caption,
		key=caption,
	})
end

-- SETUP MENU HERE

path='Game'

	ShButton( 'Pause/Unpause', 'pause' )
	ShLabel('') 
	ShButton( 'Last Message Position', 'lastmsgpos' )
	ShButton( 'Share Dialog...', 'sharedialog' ) 


path='Game/Screenshots'	
	ShButton( 'Save Screenshot (PNG)', 'screenshot', 'Find your screenshots under Spring/screenshots' ) 
	ShButton( 'Save Screenshot (JPG)', 'screenshot jpg', 'Find your screenshots under Spring/screenshots' ) 
	
--path='Game'
--	ShButton( 'Constructor Auto Assist', function() spSendCommands{"luaui togglewidget Constructor Auto Assist"} end ) 


path='Settings/Camera'
	ShLabel( 'Camera Type') 
	ShButton( 'Total Annihilation', 'viewta' ) 
	ShButton( 'FPS', 'viewfps' ) 
	ShButton( 'Free', 'viewfree' ) 
	ShButton( 'Rotatable Overhead', 'viewrot' ) 
	ShButton( 'Total War', 'viewtw' ) 
	ShButton( 'Flip the TA Camera', 'viewtaflip' ) 
	ShButton( 'Toggle advanced COFC camera', 'luaui togglewidget Combo Overhead/Free Camera (experimental)' ) 

path='Settings/Reset Settings'
	ShLabel( 'Reset graphic settings to minimum.')
	ShButton( 'Reset graphic settings',function()
					spSendCommands{"water 0",
						"Shadows 0",
						"maxparticles 100",
						"advshading 0",
						"grounddecals 0",
						'luaui disablewidget LupsManager',
						"luaui disablewidget Display DPS",
						"luaui disablewidget SelectionHalo",
						"luaui disablewidget SelectionCircle",
						"luaui disablewidget UnitShapes",
					}
				end,
				'Use this if your performance is poor'
			)
	ShLabel( 'Reset custom settings to default.')
	ShButton( 'Reset custom settings', function() WG.crude.ResetSettings() end )
	ShLabel( 'Reset hotkeys.')
	ShButton( 'Reset hotkeys',function() WG.crude.ResetKeys() end )


path='Settings'
	AddOption({
		name = 'Show Advanced Settings',
		type = 'bool',
		value = false,
	})

path='Settings/Interface/Interface Skin'
	AddOption({
		name = 'Skin Sets',
		type = 'list',
		OnChange = function (self)
			WG.crude.SetSkin( self.value );
		end,
		items = {
			{ key = 'Robocracy', name = 'Robocracy', },
			{ key = 'Carbon', name = 'Carbon', },
			{ key = 'DarkHive', name = 'DarkHive', },
		},
	})
	
path='Settings/Misc'
	ShButton( 'Widget List...', function() WG.crude.ShowWidgetList2() end, '', true )
	ShButton( 'Local Widget Config', function() spSendCommands{"luaui localwidgetsconfig"} end, '', true )
	ShButton( 'LuaUI TweakMode (Esc to exit)', 'luaui tweakgui', 'LuaUI TweakMode. Move and resize parts of the user interface. (Hit Esc to exit)' )

path='Settings/Mouse Cursor'
	ShButton('Toggle Grab Input', function() spSendCommands{"grabinput"} end, 'Mouse cursor won\'t be able to leave the window.' )
	AddOption({ 	
		name = 'Hardware Cursor',
		type = 'bool',
		springsetting = 'HardwareCursor',
		OnChange=function(self) spSendCommands{"hardwarecursor " .. (self.value and 1 or 0) } end, 
	} )


path='Settings/Video'
	ShLabel('Lups (Lua Particle System)')
	ShButton('Toggle Lups', function() spSendCommands{'luaui togglewidget LupsManager'} end )
	
	ShLabel('Various')
	AddOption({
		name = 'Shiny Units',
		type = 'bool',
		springsetting = 'AdvUnitShading',
		OnChange=function(self) spSendCommands{"advshading " .. (self.value and 1 or 0) } end, --needed as setconfigint doesn't apply change right away
	} )
	AddOption({ 	
		name = 'Ground Decals',
		type = 'bool',
		springsetting = 'GroundDecals',
		OnChange=function(self) spSendCommands{"grounddecals " .. (self.value and 1 or 0) } end, 
	} )

	AddOption({
		name = 'Maximum Particles (100 - 20,000)',
		type = 'number',
		valuelist = {100,500,1000,2000,5000,10000,20000},
		springsetting = 'MaxParticles',
		OnChange=function(self) Spring.SendCommands{"maxparticles " .. self.value } end, 
	} )
	
	ShLabel('View Radius')
	
	ShButton('Increase Radius', "increaseviewradius" )
	ShButton('Decrease Radius', "decreaseviewradius" )


	ShLabel('Trees')
	ShButton('Toggle View', 'drawtrees' )
	ShButton('See More Trees', 'moretrees' )
	ShButton('See Less Trees', 'lesstrees' )
	--{'Toggle Dynamic Sky', function(self) spSendCommands{'dynamicsky'} end },
	
	ShLabel('Water Settings')
	ShButton('Basic', function() spSendCommands{"water 0"} end )
	ShButton('Reflective', function() spSendCommands{"water 1"} end )
	ShButton('Reflective and Refractive', function() spSendCommands{"water 3"} end )
	ShButton('Dynamic', function() spSendCommands{"water 2"} end )
	ShButton('Bumpmapped', function() spSendCommands{"water 4"} end )

	ShLabel('Shadow Settings')
	ShButton('Disable Shadows', function() spSendCommands{"Shadows 0"} end )
	ShButton('Toggle Terrain Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); if (curShadow<2) then curShadow=2 else curShadow=1 end; spSendCommands{"Shadows "..curShadow} end )
	ShButton('Low Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 1024"} end )
	ShButton('Medium Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 2048"} end )
	ShButton('High Detail Shadows', function() local curShadow=Spring.GetConfigInt("Shadows"); curShadow=math.max(1,curShadow); spSendCommands{"Shadows " .. curShadow .. " 4096"} end )

path='Settings/View'

	ShLabel('Spectator View/Selection')
	ShButton('View Chosen Player', function() spSendCommands{"specfullview 0"} end )
	ShButton('View All', function() spSendCommands{"specfullview 1"} end )
	ShButton('Select Any Unit', function() spSendCommands{"specfullview 2"} end )
	ShButton('View All & Select Any', function() spSendCommands{"specfullview 3"} end )

	ShLabel('Other settings')
	
	AddOption({
		name = 'Brightness',
		type = 'number',
		min = 0, 
		max = 1, 
		step = 0.01,
		value = 1,
		OnChange = function(self) Spring.SendCommands{"luaui enablewidget Darkening", "luaui darkening " .. 1-self.value} end, 
	} )
	
	AddOption({
		name = 'Icon Distance',
		type = 'number',
		min = 1, 
		max = 1000,
		springsetting = 'UnitIconDist',
		OnChange = function(self) Spring.SendCommands{"disticon " .. self.value} end 
	} )
	
	ShLabel('')
	ShButton('Toggle DPS Display', function() spSendCommands{"luaui togglewidget Display DPS"} end, 'Shows RPG-style damage' )
	
path='Settings/View/Effects'

	ShButton('Night View', function() spSendCommands{'luaui togglewidget Night'} end )
					
	ShButton('Toggle Camera Shake', function() spSendCommands{'luaui togglewidget CameraShake'} end )
	
path='Settings/View/Map'	

	ShButton('VR Grid', function() spSendCommands{'luaui togglewidget External VR Grid'} end )
	ShButton('Map Extension', function() spSendCommands{'luaui togglewidget Map edge extension'} end )

path='Help'
	AddOption({
		type='text',
		name='Tips',
		value=[[Your Engineer/Overseer must be in power range in order to build something that requires power.
		
Pressing "O" while an Engineer is selected will turn on "Area Mex" mode, where you can just click and drag a circle and any metal spots within that circle will have a Metal Extractor automatically queued upon them. Put the Engineer on repeat and if one of the metal extractors is destroyed, the Engineer will go out and rebuild it.

All-Terrain units are stealthed to radar, but produce seismic signatures when moving. If you enable cloak on an All-Terrain unit and keep it perfectly still, it will be undetectable unless another unit bumps into it.

Light raiders also double as scouts. They have a huge line of sight vision and are able to detect the seismic signatures of All-Terrain units. Always include raiders with your army.

If your camera settings are messed up, you can reset the entire camera by pressing alt + ctrl + shift + middle click.]]
	})
	AddOption({
		type='text',
		name='Game Manual',
		value=[[The Basics

The game itself is quite simple as RTS games go, but there is a lot of complexity underneath the surface. It is of course based upon managing an economy while fighting other players with the eventual goal of domination as all RTS games are, but Evolution RTS goes about things a little differently.
The Interface
Minimap

The minimap is a small bird’s eye view of the entire game map. It will show you units on radar and their appropriate team’s colors. Orders such as move, attack, fight, etc, can be given on the minimap. Middle clicking anywhere on the minimap will instantly cause your game camera to be centered on that spot.
Resource Bars

The resource bars show the amount of income that you have at any given moment. They also show your total storage amounts, how much overflow you are sharing with your allies, and how much resource drain you are experiencing. The white bar depicts your metal resource and the yellow bar depicts your energy resource.
Commands Menu

The commands menu shows an overview of the current state of your selected unit(s). Commands with a colored bar underneath them can be toggled to different states. For example, in the illustration above the unit is on hold fire. Toggleable fire states are “Hold Fire”, “Return Fire” and “Fire at will”.
Build Menu

The unit build menu will be a central focus for the majority of the game. This is where you select what to build, and once you have clicked on a build picture, you will then need to place the structure. Factory buildmenus are very similar, however clicking on a unit in a factory buildmenu adds a unit to the buildqueue. Pay attention to the greyed out buildpictures. A greyed buildpicture indicates that there is not enough power available in the vicinity for the specified unit or structure to be built. The left and right arrows at the bottom will allow you to navigate multiple pages of buildings or units to build. Hover your mouse over a buildpic and useful information will appear in the tooltip.
Tooltips

The tooltip window displays important information about your currently selected units and anything that you hover your mouse over. This includes buildmenu pictures, command menu items, map features (trees/rocks/etc) and the map itself (will display terrain information). Be careful to pay attention to tooltip information as it can be quite helpful in your understanding of how something works.
Player List

The players list allows you to do many different things. It looks tiny, but it can do a lot! It shows a listing of your allies, enemies, and spectators. Next to the player name are several symbols. The first is your CPU usage. This is listed as a percentage. If your cpu usage is too high (generally because of an underpowered system), you could cause the game to slow down for everyone. The second is a “ping” indicator. Ping is the time it takes for a command to make a round trip from your computer to the server and back. Pings are listed in milliseconds. Generally you will want to make sure that your ping is at most 300 – 400. The lower your ping, the more responsive the server will feel to you. The buttons shown are for requesting units and resources from your allies. Hovering your mouse above any of the symbols or buttons will cause a little helper tooltip to be displayed showing you relevant information.


The Economy
The economy in Evolution RTS is based upon two resources (Metal and Energy) with a third facet (Power). Metal is obtained by placing Metal Extractors on the map upon patches of metal. Energy is obtained by building powerplants and fusion reactors. Power is obtained via powerplants and fusion reactors in a limited radius.


Metal Extractors	
When building metal extractors (Commonly referred to as “MEX”) you will immediately notice that upon click on the build picture for a metal extractor, the entire map surface will be marked with indicators for resource locations. Metal is used to produce units, whether they be Engineers for expanding your base, or attacking units, all require a certain amount of metal.


Metal Makers
Metal makers are buildings that convert energy into metal. In Evolution RTS, a single metal maker will produce +1 metal income at the cost of -20 energy drain. By default, your metal makers will shut themselves off and turn back on automatically if you start running low on energy.



Powerplants
As previously mentioned, powerplants not only provide energy, but the also provide a teching resource called “power”. We will get to power requirements next, but for the moment lets focus on energy. Energy is used for various functions within the game. The main function is that energy is used to power your units and defenses weapons fire. For each shot fired, that unit will drain a small amount of energy from your storage banks. If your storage banks of energy have been depleted, the unit will fail to fire. Some of the larger weapons require energy to stockpile a specific weapon of destruction, most notably, nukes. The energy consumption of these weapons is huge, and you will need a lot of energy structures to make sure that you have plenty of energy for your units to fire and your weapons of mass destruction to build.

Basic Powerplants provide +1 Energy and +1 Power

Geothermal Powerplants provide +7 Energy and +7 Power

Fusion Reactors provide +10 Energy and +10 Power



Power
Power is often referred to as a resource, but in actuality it isn’t a true resource. It is more of a teching requirement. There are no levels of tech trees in Evolution RTS, there is only the power that is required to build. You will notice that soon after starting a game, several items on your commander’s build menu are darkened. This means that you cannot build those items because there is not enough power available in the area to do so. As an example, the Light Defensive Turret requires +2 power in order to be built and to fire. This means that before you will be able to build a light turret, you need to have power in the area, and in order for it to keep firing, it must constantly be provided power (and energy). If it’s power requirement is lost, the defensive turret will cease to function.

Power requirements are listed in the tooltip (Bottom left of the screen) when you select a unit or place your mouse cursor over a build menu item.
Communism

The word communism is used to describe an economy function. It is important to know that when you are playing a teamgame, the metal income from every metal extractor is shared between each player. What this means is that if you place a metal extractor on a patch that gives 0.5 metal income and you have one ally, both players will receive 0.25 income instead of a single player receiving 0.5. However, metal income from metal makers is not shared.


Unit Technologies

Hover Factory
The hover plant is the “bread and butter” factory of units. What that means is that you will find the most variety in the hover factories. Hover factories feature 2 types of raiders, 2 types of skirmishers, 2 types of artillery and the only base assault unit in the game. Hovertanks are limited in what types of slopes they can traverse but can skim over the surface of water whereas all-terrain units must go around and amphibious units must go under the water. However, hovertanks do not possess any advanced innate abilities unlike all-terrain or amphibious units.


Amphibious Factory
The amphibious factory produces units geared for moving stealthily under water and are excellent for surprise attacks. They are also slightly faster than their hovertank counterparts. All amphibious units posses stealth which means that they will not show up on radar, but they will show up on sonar. Additionally, the light amphibious raider can attack underwater units and structures as well as hovertanks traversing the surface.


All-Terrain Factory
All-Terrain units are once again, exactly what they sound like. They move quickly on 4 legs over any terrain except water, however, they are slightly slower than hovertanks. All-Terrain tanks have the ability to cloak their units (-2 energy) and even their factory (-20 energy). Units will be forced to decloak upon attacking or building. All-Terrain units are perfect for surprise attacks over geographic obstructions.


Aircraft Factory
Aircraft often play a fundamental role in warfare. They are very fast and agile, have the ability to strike nearly anywhere at any time, but generally are fairly fragile. Aircraft are also more expensive to produce than their land based counterparts. Aircraft have very specialized roles in Evolution RTS. As examples, the air scout is extremely fast and difficult for enemy anti-air to shoot down. While it is simply a drone that provides line of sight and radar information, that information may alter your attack plans at a critical juncture, or it may unveil the nuke that your enemy was trying to conceal, giving you the chance to get some bombers in there and take care of it. Aircraft represent flexibility in the face of battle, use them well.
	]]
	})
	
	AddOption({
		type='text',
		name='Storyline',
		value=[[Act 1: Prehistory, the Cold War, and the Space War
The planet Iammas is a small, blue green planet orbiting a pale yellow star, itself orbited by two large moons: The Twin Eyes of Loz, the Goddess of War. These moons, pale white and gleaming in the skies of Iammas, were the heralds of war and blood.

Their tidal patterns, complex and extreme, would flood areas, then open up new land routes. They would change the topography of whole regions in a short decade…and bring the many tribes of Iammas into contact with one another. The Iamman people were a lizardlike people, bipedal, tailed, with slitted eyes and aquatic bent. They could swim as well as walk, and their bodies were tough and flexible.

With spear and blowgun, the Iammans fought. The fought for land, for the Gods, for simple brutal pleasure.

With bronze sword and shield, the Iammans fought. They fought for food, for mineral wealth, for slaves

With gunpowder and lines of battle, the Iammans fought. For republics, for monarchies, for spices and for trade routes.

With the coming of their tenth millennium, the Iammans had formed into two coalitions, both poised to unleash the newest and most deadly weapons onto one another: Nuclear, biological, and chemical weapons.

The Northern Coalition and the Southern World Order stood in this uneasy peace, even as the first Iamman stepped on the Moon.

It was only a short time before the war denied on the ground began in space.

In the vacume between the planets, Iamman blood crystallized and starships were pulped by cannon shells and laser blasts. The weapons had changed, and the field of battle had changed, but the simple truth of war had stayed the same: Young Immans were the ones who fought and the ones who died.

It was then that two inventions came to the fore, inventions that would completely change the field of battle. One was the K.T Shield, a device that could ward off deadly energy attacks and make a ship invisible (for short periods of time) and the other was the Mass Drive, a device that could allow a starship to bridge massive distances in the blink of an eye.

With these, the SWO triumphed and for the first time in ten thousand years, the Iamman people were at peace.


Act 2: Colonization, Martial Law, The Collapse.
The first Mass Drive capable star ships were scout vessels, exploring nearby systems for life. They found rocks. Rocks and lifeless planets, incapable of supporting anything. But then they found them. A string of six livable planets, in six star systems, spread in a crescent constellation called The Arm of Kala, the Goddess of Peace.

The Outer Colonies were created…and war came once more. The Colonies seethed with rebellion, and the SWO reacted as anyone would expect: They cracked down. Rebellion was crushed and the Colonies were placed under martial law.

It was then that the Collapse came.

The Iamman planet, like many others, has a magnetosphere. And like many others, the magnetosphere periodically shifts its polarity, temporarily dropping and leaving the planet vulnerable.

Normally, this would be a non-issue.

However, the Iamman star happened to have the single largest recorded solar flare at exactly the same time. A wash of radiation bathed Iammas. Computers crashed, the network collapsed, countless terrabytes of information was lost completely. The economy collapsed. Communication collapsed. Civilization collapsed as well, as a massive rise in cancer deaths resulted.

Chaos. Panic. War. Nuclear fire blossomed as panicked military officers believed they were under attack and fail-safes put in place centuries ago went into effect.

The Iammas homeworld was reduced to a dark age…

And the Outer Colonies?

They.

Did.

Nothing.


Act 3: The Unification War.
While Immas fell into chaos and darkness, the Outer Colonies reveled in their new found freedoms. They expanded, they built new cities, new colonies, new ships…new weapons. The first conflicts were minor, over viable planets that surrounded the Six Colonies.

But the Iamman people could never balance on the knife’s edge of peace.

A new war was brewing. A violent conflict, between the Six Colonies, each one convinced that it was in the right, each one sure of its own ability to defeat its enemies. But they need Generals. They need soldiers. They need you.
		
		]]
	})
	
	



return confdata


