--[[   Morph Definition File

Morph parameters description
local morphDefs = {		--beginig of morphDefs
	unitname = {		--unit being morphed
		into = 'newunitname',		--unit in that will morphing unit morph into
		time = 12,			--time required to complete morph process (in seconds)
		--require = 'requnitname',	--unit requnitname must be present in team for morphing to be enabled
		energy = 10,			--required metal for morphing process     note: if you ommit M and/or E costs, morph costs the
		energy = 10,			--required energy for morphing process		difference in costs between unitname and newunitname
		xp = 0.07,			--required experience for morphing process (will be deduced from unit xp after morph, default=0)
		rank = 1,			--required unit rank for morphing to be enabled, if ommited, morph doesn't require rank
		tech = 2,			--required tech level of a team for morphing to be enabled (1,2,3), if ommited, morph doesn't require tech
		cmdname = 'Ascend',		--if ommited will default to "Upgrade"
		texture = 'MyIcon.dds',		--if ommited will default to [newunitname] buildpic, textures should be in "LuaRules/Images/Morph"
		text = 'Description',		--if ommited will default to "Upgrade into a [newunitname]", else it's "Description"
						--you may use "$$unitname" and "$$into" in 'text', both will be replaced with human readable unit names 
	},
}				--end of morphDefs
--]]
--------------------------------------------------------------------------------


local devolution = (-1 > 0)

local energyCost_ecommander = 200
local timeToBuild_ecommander = energyCost_ecommander * 0.10

local energyCost_ecommandercloak = 200
local timeToBuild_ecommandercloak = energyCost_ecommandercloak * 0.10

local energyCost_ecommandershield = 200
local timeToBuild_ecommandershield = energyCost_ecommandershield * 0.10

local energyCost_ecommanderbuild = 200
local timeToBuild_ecommanderbuild = energyCost_ecommanderbuild * 0.10

local energyCost_ecommanderfactory = 200
local timeToBuild_ecommanderfactory = energyCost_ecommanderfactory * 0.10

local energyCost_ecommanderbattle = 200
local timeToBuild_ecommanderbattle = energyCost_ecommanderbattle * 0.10

local energyCost_factory_up1 = 1200
local timeToBuild_factory_up1 = energyCost_factory_up1 * 0.10

local energyCost_etech2 = 1200
local timeToBuild_etech2 = energyCost_etech2 * 0.10

local energyCost_etech3 = 4000
local timeToBuild_etech3 = energyCost_etech3 * 0.10

local energyCost_elightturret2 = 150
local timeToBuild_elightturret2 = energyCost_elightturret2 * 0.10

local energyCost_eheavyturret2 = 250
local timeToBuild_eheavyturret2 = energyCost_eheavyturret2 * 0.10

local energyCost_euwturret = 100
local timeToBuild_euwturret = energyCost_euwturret * 0.10

local energyCost_emetalextractor_up1 = 400
local timeToBuild_emetalextractor_up1 = energyCost_emetalextractor_up1 * 0.10

local energyCost_eorb = 300
local timeToBuild_eorb = energyCost_eorb * 0.10


local morphDefs = {
	ecommander = 	{
		{
			into = 'ecommandercloak',
			time = timeToBuild_ecommandercloak,
			cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Morph to Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Morph to Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Morph to Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains x2 buildpower.',
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Morph to Factory Overseer: Gains the ability to build all raider and riot tanks anywhere.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Morph to Battle Overseer: Stun ability recharge doubled, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech1]],
		},
	},
	
	ecommandercloak = 	{
		{
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Basic 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Morph back to the original Overseer.',
		},
	},
	
	ecommandershield = 	{
		{
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Basic 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Morph back to the original Overseer.',
		},
	},
	
	ecommanderbuild = 	{
		{
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Basic 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Morph back to the original Overseer.',
		},
	},
	
	ecommanderfactory = 	{
		{
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Basic 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Morph back to the original Overseer.',
		},
	},
	ecommanderbattle = 	{
		{
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Basic 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Morph back to the original Overseer.',
		},
	},
	
----------------------------------------------------------
----------------------------------------------------------
--Economy
	emetalextractor = 	{
		{
			into = 'emetalextractor_up1',
			--require = 'etech2',
			time = timeToBuild_emetalextractor_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_emetalextractor_up1,
			metal = 0,
			text = [[x2 Metal Extraction rate]],
			require = [[tech1]],
		},
	},
	emetalextractor_up1 = 	{
		{
			into = 'emetalextractor_up2',
			--require = 'etech2',
			time = timeToBuild_emetalextractor_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_emetalextractor_up1,
			metal = 0,
			text = [[x3 Metal Extraction rate]],
			require = [[tech2]],
		},
	},
	emetalextractor_up2 = 	{
		{
			into = 'emetalextractor_up3',
			--require = 'etech2',
			time = timeToBuild_emetalextractor_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_emetalextractor_up1,
			metal = 0,
			text = [[x4 Metal Extraction rate]],
			require = [[tech3]],
		},
	},
	
----------------------------------------------------------
----------------------------------------------------------
--Factories	
	ebasefactory = 	{
		{
			into = 'ebasefactory_up1',
			--require = 'etech1',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech1]],
		},
	},
	ebasefactory_up1 = 	{
		{
			into = 'ebasefactory_up2',
			--require = 'etech2',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech2]],
		},
	},
	ebasefactory_up2 = 	{
		{
			into = 'ebasefactory_up3',
			--require = 'etech3',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},

	eminifac = 	{
		{
			into = 'eminifac_up1',
			--require = 'etech1',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech1]],
		},
	},
	eminifac_up1 = 	{
		{
			into = 'eminifac_up2',
			--require = 'etech2',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech2]],
		},
	},
	eminifac_up2 = 	{
		{
			into = 'eminifac_up3',
			--require = 'etech3',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},
	
	eamphibfac = 	{
		{
			into = 'eamphibfac_up1',
			--require = 'etech1',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech1]],
		},
	},
	eamphibfac_up1 = 	{
		{
			into = 'eamphibfac_up2',
			--require = 'etech2',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech2]],
		},
	},
	eamphibfac_up2 = 	{
		{
			into = 'eamphibfac_up3',
			--require = 'etech3',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},
	
	eairplant = 	{
		{
			into = 'eairplant_up1',
			--require = 'etech1',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech1]],
		},
	},
	eairplant_up1 = 	{
		{
			into = 'eairplant_up2',
			--require = 'etech2',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech2]],
		},
	},
	eairplant_up2 = 	{
		{
			into = 'eairplant_up3',
			--require = 'etech3',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},
	
	ehbotfac = 	{
		{
			into = 'ehbotfac_up1',
			--require = 'etech1',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech1]],
		},
	},
	ehbotfac_up1 = 	{
		{
			into = 'ehbotfac_up2',
			--require = 'etech2',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech2]],
		},
	},
	ehbotfac_up2 = 	{
		{
			into = 'ehbotfac_up3',
			--require = 'etech3',
			time = timeToBuild_factory_up1,
			cmdname = [[Upgrade]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},

----------------------------------------------------------
----------------------------------------------------------
	
	elightturret2 = 	{
		{
			into = 'elightturret2_up1',
			--require = 'etech1',
			time = timeToBuild_elightturret2,
			cmdname = [[upgrade]],
			energy = energyCost_elightturret2,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	elightturret2_up1 = 	{
		{
			into = 'elightturret2_up2',
			--require = 'etech2',
			time = timeToBuild_elightturret2,
			cmdname = [[upgrade]],
			energy = energyCost_elightturret2,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},
	elightturret2_up2 = 	{
		{
			into = 'elightturret2_up3',
			--require = 'etech3',
			time = timeToBuild_elightturret2,
			cmdname = [[upgrade]],
			energy = energyCost_elightturret2,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},

	eheavyturret2 = 	{
		{
			into = 'eheavyturret2_up1',
			--require = 'etech1',
			time = timeToBuild_eheavyturret2,
			cmdname = [[upgrade]],
			energy = energyCost_eheavyturret2,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	eheavyturret2_up1 = 	{
		{
			into = 'eheavyturret2_up2',
			--require = 'etech2',
			time = timeToBuild_eheavyturret2,
			cmdname = [[upgrade]],
			energy = energyCost_eheavyturret2,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},
	eheavyturret2_up2 = 	{
		{
			into = 'eheavyturret2_up3',
			--require = 'etech3',
			time = timeToBuild_eheavyturret2,
			cmdname = [[upgrade]],
			energy = energyCost_eheavyturret2,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},
	
	euwturret = 	{
		{
			into = 'euwturret_up1',
			--require = 'etech1',
			time = timeToBuild_euwturret,
			cmdname = [[upgrade]],
			energy = energyCost_euwturret,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	euwturret_up1 = 	{
		{
			into = 'euwturret_up2',
			--require = 'etech2',
			time = timeToBuild_euwturret,
			cmdname = [[upgrade]],
			energy = energyCost_euwturret,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},
	euwturret_up2 = 	{
		{
			into = 'euwturret_up3',
			--require = 'etech3',
			time = timeToBuild_euwturret,
			cmdname = [[upgrade]],
			energy = energyCost_euwturret,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},
	
----------------------------------------------------------
----------------------------------------------------------
	
	ehbotengineer = 	{
		{
			into = 'ehbotengineer_turret',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotpeewee = 	{
		{
			into = 'ehbotpeewee_turret',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotthud = 	{
		{
			into = 'ehbotthud_turret',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotsniper = 	{
		{
			into = 'ehbotsniper_turret',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotrocko = 	{
		{
			into = 'ehbotrocko_turret',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotkarganneth = 	{
		{
			into = 'ehbotkarganneth_turret',
			time = 40,
			cmdname = [[Deploy]],
			energy = 400,
			metal = 0,
			text = 'Morph into a stationary turret that gains 2x health.',
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up1 = 	{
		{
			into = 'ehbotpeewee_turret_up1',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotthud_up1 = 	{
		{
			into = 'ehbotthud_turret_up1',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotsniper_up1 = 	{
		{
			into = 'ehbotsniper_turret_up1',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotrocko_up1 = 	{
		{
			into = 'ehbotrocko_turret_up1',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotkarganneth_up1 = 	{
		{
			into = 'ehbotkarganneth_turret_up1',
			time = 40,
			cmdname = [[Deploy]],
			energy = 400,
			metal = 0,
			text = 'Morph into a stationary turret that gains 2x health.',
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up2 = 	{
		{
			into = 'ehbotpeewee_turret_up2',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotthud_up2 = 	{
		{
			into = 'ehbotthud_turret_up2',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotsniper_up2 = 	{
		{
			into = 'ehbotsniper_turret_up2',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotrocko_up2 = 	{
		{
			into = 'ehbotrocko_turret_up2',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotkarganneth_up2 = 	{
		{
			into = 'ehbotkarganneth_turret_up2',
			time = 40,
			cmdname = [[Deploy]],
			energy = 400,
			metal = 0,
			text = 'Morph into a stationary turret that gains 2x health.',
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up3 = 	{
		{
			into = 'ehbotpeewee_turret_up3',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotthud_up3 = 	{
		{
			into = 'ehbotthud_turret_up3',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotsniper_up3 = 	{
		{
			into = 'ehbotsniper_turret_up3',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},	
	ehbotrocko_up3 = 	{
		{
			into = 'ehbotrocko_turret_up3',
			time = 12.5,
			cmdname = [[Deploy]],
			energy = 50,
			metal = 0,
			text = 'Morph into a stationary turret that gains 4x health.',
		},
	},
	ehbotkarganneth_up3 = 	{
		{
			into = 'ehbotkarganneth_turret_up3',
			time = 40,
			cmdname = [[Deploy]],
			energy = 400,
			metal = 0,
			text = 'Morph into a stationary turret that gains 2x health.',
		},
	},	
	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_turret = 	{
		{
			into = 'ehbotpeewee_turret_up1',
			--require = 'etech1',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	ehbotthud_turret = 	{
		{
			into = 'ehbotthud_turret_up1',
			--require = 'etech1',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	ehbotsniper_turret = 	{
		{
			into = 'ehbotsniper_turret_up1',
			--require = 'etech1',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},	
	ehbotrocko_turret = 	{
		{
			into = 'ehbotrocko_turret_up1',
			--require = 'etech1',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech1]],
		},
	},
	ehbotkarganneth_turret = 	{
		{
			into = 'ehbotkarganneth_turret_up1',
			time = 80,
			cmdname = [[Upgrade]],
			energy = 800,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[endbringer]],
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_turret_up1 = 	{
		{
			into = 'ehbotpeewee_turret_up2',
			--require = 'etech2',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},	
	ehbotthud_turret_up1 = 	{
		{
			into = 'ehbotthud_turret_up2',
			--require = 'etech2',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},	
	ehbotsniper_turret_up1 = 	{
		{
			into = 'ehbotsniper_turret_up2',
			--require = 'etech2',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},	
	ehbotrocko_turret_up1 = 	{
		{
			into = 'ehbotrocko_turret_up2',
			--require = 'etech2',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech2]],
		},
	},
	ehbotkarganneth_turret_up1 = 	{
		{
			into = 'ehbotkarganneth_turret_up2',
			time = 80,
			cmdname = [[Upgrade]],
			energy = 800,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[endbringer]],
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_turret_up2 = 	{
		{
			into = 'ehbotpeewee_turret_up3',
			--require = 'etech3',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},	
	ehbotthud_turret_up2 = 	{
		{
			into = 'ehbotthud_turret_up3',
			--require = 'etech3',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},	
	ehbotsniper_turret_up2 = 	{
		{
			into = 'ehbotsniper_turret_up3',
			--require = 'etech3',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},	
	ehbotrocko_turret_up2 = 	{
		{
			into = 'ehbotrocko_turret_up3',
			--require = 'etech3',
			time = 12.5,
			cmdname = [[Upgrade]],
			energy = 50,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[tech3]],
		},
	},
	ehbotkarganneth_turret_up2 = 	{
		{
			into = 'ehbotkarganneth_turret_up3',
			time = 80,
			cmdname = [[Upgrade]],
			energy = 800,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload]],
			require = [[endbringer]],
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	etech1 = 	{
		{
			into = 'etech2',
			time = timeToBuild_etech2,
			cmdname = [[Tech 2
Upgrade]],
			energy = energyCost_etech2,
			metal = 0,
			text = 'Morph into a Tech Level 2 Facility.',
		},
	},	
	etech2 = 	{
		{
			into = 'etech3',
			time = timeToBuild_etech3,
			cmdname = [[Tech 3
Upgrade]],
			energy = energyCost_etech3,
			metal = 0,
			text = 'Morph into a Tech Level 3 Facility.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	eorb = 	{
		{
			into = 'eorb_up1',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[upgrade]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, 2x Buildspeed, 2x Healing Rate, Larger BuildRange/HealRange]],
			require = [[tech1]],
		},
	},	
	eorb_up1 = 	{
		{
			into = 'eorb_up2',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[upgrade]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, 2x Buildspeed, 2x Healing Rate, Larger BuildRange/HealRange]],
			require = [[tech2]],
		},
	},	
	eorb_up2 = 	{
		{
			into = 'eorb_up3',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[upgrade]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, 2x Buildspeed, 2x Healing Rate, Larger BuildRange/HealRange]],
			require = [[tech3]],
		},
	},	
	
}

--
-- Here's an example of why active configuration
-- scripts are better then static TDF files...
--

--
-- devolution, babe  (useful for testing)
--
if (devolution) then
  local devoDefs = {}
  for src,data in pairs(morphDefs) do
    devoDefs[data.into] = { into = src, time = 10, energy = 1, energy = 1 }
  end
  for src,data in pairs(devoDefs) do
    morphDefs[src] = data
  end
end


return morphDefs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
