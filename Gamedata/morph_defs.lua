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

local energyCost_ecommander = 100
local timeToBuild_ecommander = energyCost_ecommander * 0.10

local energyCost_ecommanderhealer = 100
local timeToBuild_ecommanderhealer = energyCost_ecommanderhealer * 0.10

local energyCost_ecommandercloak = 100
local timeToBuild_ecommandercloak = energyCost_ecommandercloak * 0.10

local energyCost_ecommandershield = 100
local timeToBuild_ecommandershield = energyCost_ecommandershield * 0.10

local energyCost_ecommanderbuild = 100
local timeToBuild_ecommanderbuild = energyCost_ecommanderbuild * 0.10

local energyCost_ecommanderfactory = 100
local timeToBuild_ecommanderfactory = energyCost_ecommanderfactory * 0.10

local energyCost_ecommanderbattle = 3000
local timeToBuild_ecommanderbattle = energyCost_ecommanderbattle * 0.10

local energyCost_ecommandermeteor = 6000
local timeToBuild_ecommandermeteor = energyCost_ecommandermeteor * 0.10

local energyCost_eradar2_up1 = 450
local timeToBuild_eradar2_up1 = energyCost_eradar2_up1 * 0.10

local energyCost_factory_up1 = 600
local timeToBuild_factory_up1 = energyCost_factory_up1 * 0.10

local energyCost_etech2 = 600
local timeToBuild_etech2 = energyCost_etech2 * 0.10

local energyCost_etech3 = 2000
local timeToBuild_etech3 = energyCost_etech3 * 0.10

local energyCost_zarmtech1 = 300
local timeToBuild_zarmtech1 = energyCost_zarmtech1 * 0.10

local energyCost_zarmtech2 = 600
local timeToBuild_zarmtech2 = energyCost_zarmtech2 * 0.10

local energyCost_zarmtech3 = 2000
local timeToBuild_zarmtech3 = energyCost_zarmtech3 * 0.10

local energyCost_zespire4 = 200
local timeToBuild_zespire4 = energyCost_zespire4 * 0.10

local energyCost_zespire5 = 200
local timeToBuild_zespire5 = energyCost_zespire5 * 0.10

local energyCost_elightturret2 = 75
local timeToBuild_elightturret2 = energyCost_elightturret2 * 0.10

local energyCost_eheavyturret2 = 125
local timeToBuild_eheavyturret2 = energyCost_eheavyturret2 * 0.10

local energyCost_euwturret = 50
local timeToBuild_euwturret = energyCost_euwturret * 0.10

local energyCost_eflakturret = 60 * 10
local timeToBuild_eflakturret = energyCost_eflakturret / 10

-- energycost = time * rate
-- time = energycost / rate

local energyCost_emetalextractor_up1 = 60 * 2
local timeToBuild_emetalextractor_up1 = energyCost_emetalextractor_up1 / 2

local energyCost_emetalextractor_up2 = 300 * 25
local timeToBuild_emetalextractor_up2 = energyCost_emetalextractor_up2 / 25

local energyCost_emetalextractor_up3 = 480 * 50
local timeToBuild_emetalextractor_up3 = energyCost_emetalextractor_up3 / 50

local energyCost_zmex_up1 = 1200
local timeToBuild_zmex_up1 = energyCost_zmex_up1 * 0.10

local energyCost_xmetalextractor = 1200
local timeToBuild_xmetalextractor = energyCost_xmetalextractor * 0.10

local energyCost_eorb = 150
local timeToBuild_eorb = energyCost_eorb * 0.10

local energyCost_eartyturret = 400
local timeToBuild_eartyturret = energyCost_eartyturret * 0.10

local energyCost_ehbotturret = 0
local timeToBuild_ehbotturret = 2

local energyCost_ehbot = 0
local timeToBuild_ehbot = 10

local energyCost_eartytanksauration = 150
local timeToBuild_eartytanksauration = energyCost_eartytanksauration * 0.10

local energyCost_kargannethturret = 0
local timeToBuild_kargannethturret = 2

local energyCost_karganneth = 0
local timeToBuild_karganneth = 10

local morphDefs = {
	ecommander = {
		{
		into = 'ecommanderhealer',
		time = timeToBuild_ecommanderhealer,
		cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommanderhealer,
			metal = 0,
			text = 'Evolve into Healer Overseer: Overseer has a very strong AOE heal in it\'s immediate vicinity.',
			require = [[tech2]],
		},
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
			require = [[tech2]],
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Gains 16x buildpower and larger build radius.',
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
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light Units. No longer grants supply.',
			require = [[tech2]],
		},
	},
	
	ecommandercloak = {
	    {
			into = 'ecommanderhealer',
			time = timeToBuild_ecommanderhealer,
			cmdname = [[Healer 
	Overseer]],
			energy = energyCost_ecommanderhealer,
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Gains 16x buildpower and larger build radius.',
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
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
		},
	},
	
	ecommandershield = {
	    {
		into = 'ecommanderhealer',
		time = timeToBuild_ecommanderhealer,
		cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommanderhealer,
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
			text = 'Evolve into Builder Overseer: Gains 16x buildpower and larger build radius.',
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
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
		},
	},
	
	ecommanderbuild = {
	    {
			into = 'ecommanderhealer',
			time = timeToBuild_ecommanderhealer,
			cmdname = [[Healer 
	Overseer]],
			energy = energyCost_ecommanderhealer,
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
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
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
		},
	},
	
	ecommanderfactory = {
	    {
			into = 'ecommanderhealer',
			time = timeToBuild_ecommanderhealer,
			cmdname = [[Healer 
	Overseer]],
			energy = energyCost_ecommanderhealer,
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Gains 16x buildpower and larger build radius.',
		},
		{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
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
			into = 'ecommanderhealer',
			time = timeToBuild_ecommanderhealer,
			cmdname = [[Healer 
Overseer]],
			energy = energyCost_ecommanderhealer,
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Gains 16x buildpower.',
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
	
	ecommanderhealer = {
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
		into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
			require = [[tech2]],
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
			text = 'Evolve into Shielded Overseer: Gains a large shield which recharges quickly.',
		},
		{
			into = 'ecommanderbuild',
			time = timeToBuild_ecommanderbuild,
			cmdname = [[Builder
Overseer]],
			energy = energyCost_ecommanderbuild,
			metal = 0,
			text = 'Evolve into Builder Overseer: Gains 16x buildpower.',
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
	
	ecommandermeteor = {
			{
			into = 'ecommanderbattle',
			time = timeToBuild_ecommanderbattle,
			cmdname = [[Battle
Overseer]],
			energy = energyCost_ecommanderbattle,
			metal = 0,
			text = 'Evolve into Battle Overseer: Upgraded machinegun that does heavy damage to Light units and Buildings. No longer grants supply.',
		},
	},
	
----------------------------------------------------------
----------------------------------------------------------
--Radar
	eradar2 = 	{
		{
			into = 'eradar2_up1',
			--require = 'etech2',
			time = timeToBuild_eradar2_up1,
			cmdname = [[Evolve to Tech2]],
			energy = energyCost_eradar2_up1,
			metal = 0,
			text = [[Increases Radar/Sensing Range]],
			require = [[tech2]],
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
			cmdname = [[Evolve 2x Income]],
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
			time = timeToBuild_emetalextractor_up2,
			cmdname = [[Evolve 4x Income]],
			energy = energyCost_emetalextractor_up2,
			metal = 0,
			text = [[x4 Metal Extraction rate]],
			require = [[tech2]],
		},
	},
	emetalextractor_up2 = 	{
		{
			into = 'emetalextractor_up3',
			--require = 'etech2',
			time = timeToBuild_emetalextractor_up3,
			cmdname = [[Evolve 8x Income]],
			energy = energyCost_emetalextractor_up3,
			metal = 0,
			text = [[x8 Metal Extraction rate]],
			require = [[tech3]],
		},
	},
	zmex = 	{
		{
			into = 'zmex_up3',
			--require = 'etech2',
			time = timeToBuild_zmex_up1,
			cmdname = [[Evolve 2x Income]],
			energy = energyCost_zmex_up1,
			metal = 0,
			text = [[x2 Metal Extraction rate]],
			require = [[tech2]],
		},
	},
----------------------------------------------------------
----------------------------------------------------------
--Factories	

----------------------------------------------------------
----------------------------------------------------------
	
	elaserbattery = 	{
		{
			into = 'eflakturret',
			time = timeToBuild_eflakturret,
			cmdname = [[Evolve Flak Turret]],
			energy = energyCost_eflakturret,
			metal = 0,
			text = [[Evolve Projectile Based Flak with more Range and AOE Damage]],
			require = [[tech2]],
		},
	},	
	
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
	
	zarm = 	{
		{
			into = 'zarm_up1',
			time = timeToBuild_zarmtech1,
			cmdname = [[Evolve Tech 1]],
			energy = energyCost_zarmtech1,
			metal = 0,
			text = 'Evolve Tech 1',
		},
	},	
	zarm_up1 = 	{
		{
			into = 'zarm_up2',
			time = timeToBuild_zarmtech2,
			cmdname = [[Evolve Tech 2]],
			energy = energyCost_zarmtech2,
			metal = 0,
			text = 'Evolve Tech 2',
		},
	},	
	zarm_up2 = 	{
		{
			into = 'zarm_up3',
			time = timeToBuild_zarmtech3,
			cmdname = [[Evolve Tech 3]],
			energy = energyCost_zarmtech3,
			metal = 0,
			text = 'Evolve Tech 3',
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
