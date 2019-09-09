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

local energyCost_ecommandermeteor = 12000
local timeToBuild_ecommandermeteor = energyCost_ecommandermeteor * 0.01

local energyCost_factory_up1 = 1200
local timeToBuild_factory_up1 = energyCost_factory_up1 * 0.10

local energyCost_etech2 = 1200
local timeToBuild_etech2 = energyCost_etech2 * 0.10

local energyCost_etech3 = 4000
local timeToBuild_etech3 = energyCost_etech3 * 0.10

local energyCost_zlair = 0
local timeToBuild_zlair = 200

local energyCost_zhive = 0
local timeToBuild_zhive = 500

local energyCost_zespire4 = 0
local timeToBuild_zespire4 = 40

local energyCost_zespire5 = 0
local timeToBuild_zespire5 = 40

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

local energyCost_eartyturret = 800
local timeToBuild_eartyturret = energyCost_eartyturret * 0.10

local energyCost_ehbotturret = 0
local timeToBuild_ehbotturret = 2

local energyCost_ehbot = 0
local timeToBuild_ehbot = 10

local energyCost_eartytanksauration = 300
local timeToBuild_eartytanksauration = energyCost_eartytanksauration * 0.10

local energyCost_kargannethturret = 0
local timeToBuild_kargannethturret = 2

local energyCost_karganneth = 0
local timeToBuild_karganneth = 10

local morphDefs = {
	ecommander = {
		{
		into = 'ecommandercloak',
		time = timeToBuild_ecommandercloak,
		cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Evolve into Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
			require = [[tech2]],
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Evolve into Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
			require = [[tech2]],
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains 4x buildpower.',
			require = [[tech2]],
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Evolve into Factory Overseer: Gains the ability to build all raider, riot, and MBTs anywhere, gains 8x buildpower.',
			require = [[tech2]],
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Loses EMP ability, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech2]],
		},
	},
	
	ecommandercloak = {
	    {
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Evolve into Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains 4x buildpower.',
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Evolve into Factory Overseer: Gains the ability to build all raider, riot, and MBTs anywhere, gains 8x buildpower.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Loses EMP ability, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech1]],
		},
	},
	
	ecommandershield = {
	    {
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
		},
		{
			into = 'ecommandercloak',
			time = timeToBuild_ecommandercloak,
			cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Evolve into Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains 4x buildpower.',
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Evolve into Factory Overseer: Gains the ability to build all raider, riot, and MBTs anywhere, gains 8x buildpower.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Loses EMP ability, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech1]],
		},
	},
	
	ecommanderbuild = {
	    {
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
		},
		{
			into = 'ecommandercloak',
			time = timeToBuild_ecommandercloak,
			cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Evolve into Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Evolve into Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Evolve into Factory Overseer: Gains the ability to build all raider, riot, and MBTs anywhere, gains 8x buildpower.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Loses EMP ability, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech1]],
		},
	},
	
	ecommanderfactory = {
	    {
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
		},
		{
			into = 'ecommandercloak',
			time = timeToBuild_ecommandercloak,
			cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Evolve into Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Evolve into Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains x4 buildpower.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Loses EMP ability, gains a machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech1]],
		},
	},
	ecommanderbattle = {
	    {
			into = 'ecommandermeteor',
			time = timeToBuild_ecommandermeteor,
			cmdname = [[Meteor 
Overseer]],
			energy = energyCost_ecommandermeteor,
			metal = 0,
			text = 'Evolve into Meteor Overseer: Overseer can call down devastating meteor showers.',
			require = [[tech3]],
		},
	    {
			into = 'ecommander',
			time = timeToBuild_ecommander,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommander,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
		},
		{
			into = 'ecommandercloak',
			time = timeToBuild_ecommandercloak,
			cmdname = [[Cloaking 
Overseer]],
			energy = energyCost_ecommandercloak,
			metal = 0,
			text = 'Evolve into Cloaking Overseer: Gains a large cloaking field which also cloaks the Overseer.',
		},
		{
			into = 'ecommandershield',
			time = timeToBuild_ecommandershield,
			cmdname = [[Shield
Overseer]],
			energy = energyCost_ecommandershield,
			metal = 0,
			text = 'Evolve into Shielded Overseer: Gains a large shield which does not cost energy to maintain.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Stun ability AOE halved, Stun recharge halved, gains 4x buildpower.',
		},
		{
			into = 'ecommanderfactory',
			time = timeToBuild_ecommanderfactory,
			cmdname = [[Factory
Overseer]],
			energy = energyCost_ecommanderfactory,
			metal = 0,
			text = 'Evolve into Factory Overseer: Gains the ability to build all raider, riot, and MBTs anywhere, gains 8x buildpower.',
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
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
			cmdname = [[Evolve]],
			energy = energyCost_factory_up1,
			metal = 0,
			text = [[+15% damage/hp buff, +15% faster reload, -5% speed]],
			require = [[tech3]],
		},
	},

----------------------------------------------------------
----------------------------------------------------------
	
	-- elightturret2 = 	{
		-- {
			-- into = 'elightturret2_up1',
			-- time = timeToBuild_elightturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_elightturret2,
			-- metal = 0,
			-- text = [[+20% damage/hp buff, +15% faster reload]],
			-- require = [[tech1]],
		-- },
	-- },	
	-- elightturret2_up1 = 	{
		-- {
			-- into = 'elightturret2_up2',
			-- time = timeToBuild_elightturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_elightturret2,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech2]],
		-- },
	-- },
	-- elightturret2_up2 = 	{
		-- {
			-- into = 'elightturret2_up3',
			-- time = timeToBuild_elightturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_elightturret2,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech3]],
		-- },
	-- },

	-- eheavyturret2 = 	{
		-- {
			-- into = 'eheavyturret2_up1',
			-- time = timeToBuild_eheavyturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_eheavyturret2,
			-- metal = 0,
			-- text = [[+20% damage/hp buff, +15% faster reload]],
			-- require = [[tech1]],
		-- },
	-- },	
	-- eheavyturret2_up1 = 	{
		-- {
			-- into = 'eheavyturret2_up2',
			-- time = timeToBuild_eheavyturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_eheavyturret2,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech2]],
		-- },
	-- },
	-- eheavyturret2_up2 = 	{
		-- {
			-- into = 'eheavyturret2_up3',
			-- time = timeToBuild_eheavyturret2,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_eheavyturret2,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech3]],
		-- },
	-- },
	
	-- euwturret = 	{
		-- {
			-- into = 'euwturret_up1',
			-- time = timeToBuild_euwturret,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_euwturret,
			-- metal = 0,
			-- text = [[+20% damage/hp buff, +15% faster reload]],
			-- require = [[tech1]],
		-- },
	-- },	
	-- euwturret_up1 = 	{
		-- {
			-- into = 'euwturret_up2',
			-- time = timeToBuild_euwturret,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_euwturret,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech2]],
		-- },
	-- },
	-- euwturret_up2 = 	{
		-- {
			-- into = 'euwturret_up3',
			-- time = timeToBuild_euwturret,
			-- cmdname = [[Evolve]],
			-- energy = energyCost_euwturret,
			-- metal = 0,
			-- text = [[+15% damage/hp buff, +15% faster reload]],
			-- require = [[tech3]],
		-- },
	-- },
	eartyturret = 	{
		{
			into = 'eartyturret_up1',
			time = timeToBuild_eartyturret,
			cmdname = [[Evolve]],
			energy = energyCost_eartyturret,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, Increased AOE]],
			require = [[tech3]],
		},
	},	
	eartyturret_up1 = 	{
		{
			into = 'eartyturret_up2',
			time = timeToBuild_eartyturret,
			cmdname = [[Evolve]],
			energy = energyCost_eartyturret,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, Increased AOE]],
			require = [[tech3]],
		},
	},
	eartyturret_up2 = 	{
		{
			into = 'eartyturret_up3',
			time = timeToBuild_eartyturret,
			cmdname = [[Evolve]],
			energy = energyCost_eartyturret,
			metal = 0,
			text = [[+20% damage/hp buff, +15% faster reload, Increased AOE]],
			require = [[tech3]],
		},
	},
	
----------------------------------------------------------
----------------------------------------------------------
	
	ehbotengineer = 	{
		{
			into = 'ehbotengineer_turret',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotpeewee = 	{
		{
			into = 'ehbotpeewee_turret',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotthud = 	{
		{
			into = 'ehbotthud_turret',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotsniper = 	{
		{
			into = 'ehbotsniper_turret',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotrocko = 	{
		{
			into = 'ehbotrocko_turret',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotkarganneth = 	{
		{
			into = 'ehbotkarganneth_turret',
			time = timeToBuild_kargannethturret,
			cmdname = [[Deploy]],
			energy = energyCost_kargannethturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
-- And back again
	ehbotengineer_turret = 	{
		{
			into = 'ehbotengineer',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotpeewee_turret = 	{
		{
			into = 'ehbotpeewee',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotthud_turret = 	{
		{
			into = 'ehbotthud',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotsniper_turret = 	{
		{
			into = 'ehbotsniper',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotrocko_turret = 	{
		{
			into = 'ehbotrocko',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotkarganneth_turret = 	{
		{
			into = 'ehbotkarganneth',
			time = timeToBuild_karganneth,
			cmdname = [[Retract]],
			energy = energyCost_karganneth,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up1 = 	{
		{
			into = 'ehbotpeewee_turret_up1',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotthud_up1 = 	{
		{
			into = 'ehbotthud_turret_up1',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotsniper_up1 = 	{
		{
			into = 'ehbotsniper_turret_up1',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotrocko_up1 = 	{
		{
			into = 'ehbotrocko_turret_up1',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotkarganneth_up1 = 	{
		{
			into = 'ehbotkarganneth_turret_up1',
			time = timeToBuild_kargannethturret,
			cmdname = [[Deploy]],
			energy = energyCost_kargannethturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
-- And back again
	ehbotpeewee_turret_up1 = 	{
		{
			into = 'ehbotpeewee_up1',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotthud_turret_up1 = 	{
		{
			into = 'ehbotthud_up1',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotsniper_turret_up1 = 	{
		{
			into = 'ehbotsniper_up1',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotrocko_turret_up1 = 	{
		{
			into = 'ehbotrocko_up1',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotkarganneth_turret_up1 = 	{
		{
			into = 'ehbotkarganneth_up1',
			time = timeToBuild_karganneth,
			cmdname = [[Retract]],
			energy = energyCost_karganneth,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up2 = 	{
		{
			into = 'ehbotpeewee_turret_up2',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotthud_up2 = 	{
		{
			into = 'ehbotthud_turret_up2',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotsniper_up2 = 	{
		{
			into = 'ehbotsniper_turret_up2',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotrocko_up2 = 	{
		{
			into = 'ehbotrocko_turret_up2',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotkarganneth_up2 = 	{
		{
			into = 'ehbotkarganneth_turret_up2',
			time = timeToBuild_kargannethturret,
			cmdname = [[Deploy]],
			energy = energyCost_kargannethturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
-- And back again
	ehbotpeewee_turret_up2 = 	{
		{
			into = 'ehbotpeewee_up2',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotthud_turret_up2 = 	{
		{
			into = 'ehbotthud_up2',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotsniper_turret_up2 = 	{
		{
			into = 'ehbotsniper_up2',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotrocko_turret_up2 = 	{
		{
			into = 'ehbotrocko_up2',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotkarganneth_turret_up2 = 	{
		{
			into = 'ehbotkarganneth_up2',
			time = timeToBuild_karganneth,
			cmdname = [[Retract]],
			energy = energyCost_karganneth,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	

----------------------------------------------------------
----------------------------------------------------------
	
	ehbotpeewee_up3 = 	{
		{
			into = 'ehbotpeewee_turret_up3',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotthud_up3 = 	{
		{
			into = 'ehbotthud_turret_up3',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotsniper_up3 = 	{
		{
			into = 'ehbotsniper_turret_up3',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
	ehbotrocko_up3 = 	{
		{
			into = 'ehbotrocko_turret_up3',
			time = timeToBuild_ehbotturret,
			cmdname = [[Deploy]],
			energy = energyCost_ehbotturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},
	ehbotkarganneth_up3 = 	{
		{
			into = 'ehbotkarganneth_turret_up3',
			time = timeToBuild_kargannethturret,
			cmdname = [[Deploy]],
			energy = energyCost_kargannethturret,
			metal = 0,
			text = 'Evolve into a stationary turret that gains 25% range.',
		},
	},	
-- And back again
	ehbotpeewee_turret_up3 = 	{
		{
			into = 'ehbotpeewee_up3',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotthud_turret_up3 = 	{
		{
			into = 'ehbotthud_up3',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotsniper_turret_up3 = 	{
		{
			into = 'ehbotsniper_up3',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	ehbotrocko_turret_up3 = 	{
		{
			into = 'ehbotrocko_up3',
			time = timeToBuild_ehbot,
			cmdname = [[Retract]],
			energy = energyCost_ehbot,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},
	ehbotkarganneth_turret_up3 = 	{
		{
			into = 'ehbotkarganneth_up3',
			time = timeToBuild_karganneth,
			cmdname = [[Retract]],
			energy = energyCost_karganneth,
			metal = 0,
			text = 'Retract to mobile state.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	etech1 = 	{
		{
			into = 'etech2',
			time = timeToBuild_etech2,
			cmdname = [[Tech 2
Evolution]],
			energy = energyCost_etech2,
			metal = 0,
			text = 'Evolve into a Tech Level 2 Facility.',
		},
	},	
	etech2 = 	{
		{
			into = 'etech3',
			time = timeToBuild_etech3,
			cmdname = [[Tech 3
Evolution]],
			energy = energyCost_etech3,
			metal = 0,
			text = 'Evolve into a Tech Level 3 Facility.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	zhatch = 	{
		{
			into = 'zhatch_up1',
			time = timeToBuild_zlair,
			cmdname = [[Lair
Evolution]],
			energy = energyCost_zlair,
			metal = 0,
			text = 'Evolve into a Lair.',
		},
	},	
	zhatch_up1 = 	{
		{
			into = 'zhatch_up2',
			time = timeToBuild_zhive,
			cmdname = [[Hive
Evolution]],
			energy = energyCost_zhive,
			metal = 0,
			text = 'Evolve into a Hive.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	zespire1 = 	{
		{
			into = 'zespire4',
			time = timeToBuild_zespire4,
			cmdname = [[Evolve]],
			energy = energyCost_zespire4,
			metal = 0,
			require = [[tech2]],
			text = 'Evolve into a Budding Energy Spire.',
		},
	},	
	zespire4 = 	{
		{
			into = 'zespire5',
			time = timeToBuild_zespire5,
			cmdname = [[Evolve]],
			energy = energyCost_zespire5,
			metal = 0,
			require = [[tech3]],
			text = 'Evolve into a Mature Energy Spire.',
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------
	
	eorb = 	{
		{
			into = 'eorb_up1',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[Evolve]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, Increased Buildspeed, Increased Healing Rate]],
			require = [[tech1]],
		},
	},	
	eorb_up1 = 	{
		{
			into = 'eorb_up2',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[Evolve]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, Increased Buildspeed, Increased Healing Rate]],
			require = [[tech2]],
		},
	},	
	eorb_up2 = 	{
		{
			into = 'eorb_up3',
			--require = 'etech1',
			time = timeToBuild_eorb,
			cmdname = [[Evolve]],
			energy = energyCost_eorb,
			metal = 0,
			text = [[+15% hp buff, Increased Buildspeed, Increased Healing Rate]],
			require = [[tech3]],
		},
	},	
	
----------------------------------------------------------
----------------------------------------------------------

	eartytank = 	{
		{
			into = 'eartytank_saturation',
			--require = 'etech1',
			time = timeToBuild_eartytanksauration,
			cmdname = [[Evolve]],
			energy = energyCost_eartytanksauration,
			metal = 0,
			text = [[HellFury Long-Range Saturation Artillery]],
			require = [[tech2]],
		},
	},
	eartytank_up1 = 	{
		{
			into = 'eartytank_saturation_up1',
			--require = 'etech1',
			time = timeToBuild_eartytanksauration,
			cmdname = [[Evolve]],
			energy = energyCost_eartytanksauration,
			metal = 0,
			text = [[HellFury Long-Range Saturation Artillery]],
			require = [[tech2]],
		},
	},
	eartytank_up2 = 	{
		{
			into = 'eartytank_saturation_up2',
			--require = 'etech1',
			time = timeToBuild_eartytanksauration,
			cmdname = [[Evolve]],
			energy = energyCost_eartytanksauration,
			metal = 0,
			text = [[HellFury Long-Range Saturation Artillery]],
			require = [[tech2]],
		},
	},
	eartytank_up3 = 	{
		{
			into = 'eartytank_saturation_up3',
			--require = 'etech1',
			time = timeToBuild_eartytanksauration,
			cmdname = [[Evolve]],
			energy = energyCost_eartytanksauration,
			metal = 0,
			text = [[HellFury Long-Range Saturation Artillery]],
			require = [[tech2]],
		},
	},
	
----------------------------------------------------------
--Shotguns
----------------------------------------------------------
	
	eriottank2 = 	{
		{
			into = 'eriottank2_shotgun',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eriottank2_shotgun = 	{
		{
			into = 'eriottank2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eriottank2_up1 = 	{
		{
			into = 'eriottank2_shotgun_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eriottank2_shotgun_up1 = 	{
		{
			into = 'eriottank2_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eriottank2_up2 = 	{
		{
			into = 'eriottank2_shotgun_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eriottank2_shotgun_up2 = 	{
		{
			into = 'eriottank2_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eriottank2_up3 = 	{
		{
			into = 'eriottank2_shotgun_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eriottank2_shotgun_up3 = 	{
		{
			into = 'eriottank2_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eallterrriot = 	{
		{
			into = 'eallterrriot_shotgun',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eallterrriot_shotgun = 	{
		{
			into = 'eallterrriot',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eallterrriot_up1 = 	{
		{
			into = 'eallterrriot_shotgun_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eallterrriot_shotgun_up1 = 	{
		{
			into = 'eallterrriot_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eallterrriot_up2 = 	{
		{
			into = 'eallterrriot_shotgun_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eallterrriot_shotgun_up2 = 	{
		{
			into = 'eallterrriot_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eallterrriot_up3 = 	{
		{
			into = 'eallterrriot_shotgun_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eallterrriot_shotgun_up3 = 	{
		{
			into = 'eallterrriot_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eamphibriot = 	{
		{
			into = 'eamphibriot_shotgun',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eamphibriot_shotgun = 	{
		{
			into = 'eamphibriot',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eamphibriot_up1 = 	{
		{
			into = 'eamphibriot_shotgun_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eamphibriot_shotgun_up1 = 	{
		{
			into = 'eamphibriot_up1',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eamphibriot_up2 = 	{
		{
			into = 'eamphibriot_shotgun_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eamphibriot_shotgun_up2 = 	{
		{
			into = 'eamphibriot_up2',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	
	eamphibriot_up3 = 	{
		{
			into = 'eamphibriot_shotgun_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			Shotgun]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
		},
	},
	eamphibriot_shotgun_up3 = 	{
		{
			into = 'eamphibriot_up3',
			--require = 'etech1',
			time = 2,
			cmdname = [[Evolve
			EMP]],
			energy = 0,
			metal = 0,
			text = [[Shotgun]],
			require = [[tech1]],
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
