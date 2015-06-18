local topic = {
	["details"] = {
		sectionTitle = "Gameplay",
	},
	["article"]	= {
		{ --page
			["details"] = {
				pageTitle = "Basics",
			},
			["sections"] = {-- sections
				{
					text	= [[Crash Course:
					
Metal is used to make units and structures.

Energy is only used for units to fire, shields, nukes etc.

Energy is not used for building, but you will need tons of it because it is often depleted by units firing their weapons in battles, or shields powering up or simply used by metal makers when converting energy to metal (it's also used to build nukes).

Without energy, your units can't fire. Along those lines, build storage. Storage buildings increase the total amount of metal and energy that you can store, and so in that way act like capacitors for your army. Storage buildings are quite possibly the most important buildings in your base.

In order to tech up, put generators next to your factories.

Basic generators give you 5 supply, 1 power (in a radius) and 1 energy. Geothermal generators give you 20 supply 7 power and 7 energy. Advanced generators give you 30 supply, 10 power and 10 energy.

Generators give you supply. The supply cap is 200/200. Generators say how much supply, power, and energy they give you in the unit descriptions that pop up when you mouse-over them on the build menu. You need supply in order to build units.

Power is used to tech up. The generators have graphics around them when you place them for building. That graphic is a visualization of the radius in which power is supplied. Place generators so that they are near your factory, and the power they provide will unlock higher tech units within the factory.

In this way, teching up is easy, but if you lose your generators, then you will lose the tech that the generator was allowing you to build.

Engineers, ORBs, and Overseers do not use supply. Make as many as you would like. It's a good idea to have many on hand so that you always have workers available, and they will assist with other construction projects.

ORBs are field repair units. They repair everything in a huge radius for 10hp every second, as long as what they are repairing is out of combat (for free).

Metal Makers are good. They are not as efficient as metal extractors, but they can help use your excess energy while supplying you additional income. Each Metal Maker uses 5 energy to produce 0.5 metal (The same income as a metal extractor).

However, if you are using metal makers, remember that you need energy in order for your units to fire, so build storage so that you have a buffer zone.

There are 5 tech paths:

Hover, Amphibious, All Terrain, Air and Destroyers

Hover can of course go over water and are moderately good in all situations.

Amphibious units are extremely fast, very high damage output, but have very weak armor. Amphibious units are stealthed to radar.

All Terrains units can of course go everywhere except water. They are the slowest of the 3 main technologies (Hover/Amphibious/All-Terrain), but have good firepower and solid damage output and good armor. All Terrain units can cloak. All Terrain units can't be automatically targeted when cloaked, but you can see them via seismic indicators, so you can force fire at them if you want. Cloaking All Terrain units uses a lot of energy (2 per unit). The best way to use them is to cloak them right before a fight so that you get the first shot in the battle. It can make the difference between winning and losing a battle.

Destroyer units are end-game units. They are extremely powerful and deal critical amounts of damage, but they can be brought down by surrounding them and focusing your fire. Make sure that if you are using them, you keep them protected.

This might seem like a lot to take in, but the game and the gameplay itself is quite simple really. I hope that this crash course has been helpful!
					
					]],
					textColor 	= {0.9,0.9,0.9,1.0},
					fontShadow	= false,
					--thumbImage	= "bitmaps/ui/loadingscreen/princess.png",
					backgroundColor	= {0.5,0.1,0.5,0.0},
					--backgroundImage1	= "bitmaps/ui/loadingscreen/horizon2.png",
				},
			}
		},
		{ --page
			["details"] = {
				pageTitle = "Resources",
			},
			["sections"] = {-- sections
				{
					text	= [[Metal:

Metal is used solely for construction projects, whether you are trying to build a turret, factory, generator, tank, aircraft, etc, Metal is what is used for that construction project. More metal income means that you can build more things simultaneously, faster.

Metal can be obtained via the following methods:

Metal Extractor (MEX)

Metal Maker
					]],
					textColor 	= {0.9,0.9,0.9,1.0},
					fontShadow	= false,
					--thumbImage	= "bitmaps/ui/loadingscreen/princess.png",
					backgroundColor	= {0.5,0.1,0.5,0.0},
					--backgroundImage1	= "bitmaps/ui/loadingscreen/horizon2.png",
				},
				{
					text	= [[Energy:

Energy is used specifically for utilitarian purposes. Those purposes include, Units firing, Recharging shields, Building Nuclear Missiles, Building anti-nukes, Cloaking, synthesizing metal, etc.

Energy is extremely important. The same buildings that provide energy also provide you with Power and Supply. The most basic reasons of why energy is so important is the fact that your units require it in order to fire their weapons. As a result, if you get in the middle of a battle and run out of energy, your units will no longer be able to fire, and that might not only cost you the battle, it might also cost you the game!

Energy can be obtained via the following methods:

Basic Generator

Geothermal Generator

Advanced Generator
					]],
					textColor 	= {0.9,0.9,0.9,1.0},
					fontShadow	= false,
					--thumbImage	= "bitmaps/ui/loadingscreen/princess.png",
					backgroundColor	= {0.5,0.1,0.5,0.0},
					--backgroundImage1	= "bitmaps/ui/loadingscreen/horizon2.png",
				},
				{
					text	= [[Storage:

Storage buildings are excellent tools to help buffer your Metal and Energy reserves. When your Metal and Energy reserves are full, any excess is wasted (if in a 1v1 game, otherwise it spills over to your allies in team games), so it makes a lot of sense to have a large buffer zone for your resources. It can also help with Metal stalling with large construction projects, and more importantly, it can allow you to have much greater staying power in a large battle where your units are using tons of energy in order to keep fighting.

Resource storage can be obtained via:

Storage Facility
					]],
					textColor 	= {0.9,0.9,0.9,1.0},
					fontShadow	= false,
					--thumbImage	= "bitmaps/ui/loadingscreen/princess.png",
					backgroundColor	= {0.5,0.1,0.5,0.0},
					--backgroundImage1	= "bitmaps/ui/loadingscreen/horizon2.png",
				},
			}
		},
		{ --page
			["details"] = {
				pageTitle = "Power",
			},
			["sections"] = {-- sections
				{
					text	= [[Overview:

Power is used by factories to unlock attack units, it is provided by the same buildings that produce Energy and Supply. They are Basic Generator, Geothermal Generator, and Advanced Generator. Generators can only give Power to factories that are close to them, this is indicated by the blue circle you see when you are placing a generator. If the blue circle touches the center of a factory, then the generator will be able to give Power to that factory once it is completed.

Tips:

Use Basic Generators to unlock units, start building Advanced Generators only when all units are unlocked. Advanced Generators are not meant for unlocking units due to how long it takes just to build one.

Geothermal Generator can only be placed on spots that have smoke coming out of it, you can find these spots easier if you try to place a Geothermal Generator. If you can place a Geothermal Generator near your start position, it is a good idea to build it rather than Basic Generators as you get to start with most units unlocked.
					]],
					textColor 	= {0.9,0.9,0.9,1.0},
					fontShadow	= false,
					--thumbImage	= "bitmaps/ui/loadingscreen/princess.png",
					backgroundColor	= {0.5,0.1,0.5,0.0},
					--backgroundImage1	= "bitmaps/ui/loadingscreen/horizon2.png",
				},
			}
		},
	}
}

return topic