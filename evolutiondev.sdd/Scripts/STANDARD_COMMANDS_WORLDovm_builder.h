// Argh's Standard Commands Script
// This script is released under the terms of the  PURE license.

#ifndef STANDARD_COMMANDS_PURE_H_
#define STANDARD_COMMANDS_PURE_H_
//
// Vector-based special effects
//
#define	SFXTYPE_WAKE1		3  	// Calls Spring to show a standard FX if the Unit is over water (may show on water surface if on land, use with detection methods) 
//
// Point-based (piece origin) special effects
//
#define SHATTER			1	// Has odd effects in S3O, due to triangular models.  Use with caution.
#define EXPLODE_ON_HIT		2	// DOES NOT WORK PROPERLY IN SPRING, REFERENCE ONLY
#define FALL			4	// The piece will fall due to gravity, based partially on myGravity value
#define SMOKE			8	// Creates 1 "smoke" particle each frame at the Piece's center, using standard values, as of Spring 0.75b2
#define FIRE			16	// Creates one "flame" and one "smoke" particle at the Piece's center, using standard values, as of Spring 0.75b2
#define BITMAPONLY		32	// DOES NOT WORK PROPERLY IN SPRING, REFERENCE ONLY
//
// Bitmap Explosion Types
//
#define BITMAP_PURE		10000001	//This is for any call to a BITMAP event, however it's not really necessary.  Just for helping out older conversion mods. 
//
// Indices for SET/GET value
#define ACTIVATION		1	// SET or GET, used by all scripts that call Activate() through UI or BOS command
#define STANDINGMOVEORDERS	2	// SET or GET, now works in 0.75b to SET all states (Hold Position, Manuever, Roam).  Values 0, 1, 2
#define STANDINGFIREORDERS	3	// SET or GET, now works in 0.75b to SET all states (Hold Fire, Fire at Will, Fire Back).  Values 0, 1, 2
#define HEALTH			4	// GET or SET, in 0.74b or above.  Can set the hitpoints of the relevant Unit.  Use carefully, can create odd behaviors.
#define INBUILDSTANCE		5	// SET or GET, used to tell Spring that a Factory is now able to build objects and emit nano-particles.
#define BUSY			6	// SET or GET, will operate in Spring to pause loading state, for flying transports only.
#define PIECE_XZ			7	// GET, for position calculation, returns two values, XZ, in packed coordinates.
#define PIECE_Y			8	// GET, for position calculation, returns one value, Y.  Good for height changes.
#define UNIT_XZ			9	// GET, for position calculation of Unit, reads from centroid of Base.
#define UNIT_Y			10	// GET, for position calculation of Unit, reads from centroid of Base.
#define UNIT_HEIGHT		11	// GET, for position calculation of Unit, reads from Unit's current height value.
#define XZ_ATAN			12	// GET atan of packed x,z coords.  Good for angular changes over time.  Not fast math, use with care.
#define XZ_HYPOT			13	// GET hypot of packed x,z coords.  Good for angular changes over time.  Not fast math, use with care.
#define ATAN			14	// GET ordinary two-parameter atan, as integer.  Runs most efficiently if sent raw values- i.e., 182 instead of <1.0>
#define HYPOT			15	// GET ordinary two-parameter hypot, as integer.  Runs most efficiently if sent raw values- i.e., 65536 instead of [1.0]
#define GROUND_HEIGHT		16	// GET, asks Spring for value of GROUND_HEIGHT based on map values
#define BUILD_PERCENT_LEFT		17	// GET, returns a value from Spring stating how much of the Unit has been built.  Only returns every SlowUpdate, however.
#define YARD_OPEN			18	// SET or GET.  Spring defines squares as "open" or "closed" for pathfinding purposes based on that state.
#define BUGGER_OFF		19	// SET or GET, causes Units around the Unit if SET to 1 to try to move a minimum distance away, when invoked!
#define ARMORED			20	// SET or GET.  Turns on the Armored state.  Uses value of Armor defined in unit FBI, which is a float multiple of health.
#define IN_WATER   			28	// GET only.  If model centroid Y < 0, then returns TRUE (0 Y is the water level).  Better detection methods exist.
#define CURRENT_SPEED  		29	// SET or GET.  Can return the current velocity in raw format.  Useful for checking acceleration values, etc.
#define VETERAN_LEVEL  		32	// SET or GET.  Can make units super-accurate, or keep them inaccurate, and also effects hitpoints.  Use with care!
#define MAX_ID			70	// GET only.  Returns maximum number of units - 1
#define MY_ID              		71	// GET only.  Returns ID of current unit
#define UNIT_TEAM	         		72	// GET only.  Returns team of unit given with parameter
#define UNIT_BUILD_PERCENT_LEFT	73	// GET only.  Like BUILD_PERCENT_LEFT, but comes with a unit parameter.
#define UNIT_ALLIED		74	// GET only.  Is this unit allied to the unit of the current COB script? 1 = allied, 0 = not allied
#define MAX_SPEED 			75	// SET only.  Alters MaxVelocity for the given unit.  Can be SET to anything lower than the max. speed in FBI, value of 1 == 0
#define CLOAKED			76	//SET or GET.  GETs current status of cloak.
#define WANT_CLOAK		77	//SET or GET.  GETs current value of WANT_CLOAK (1 or 0)
#define GROUND_WATER_HEIGHT	78	//GET only.  Returns negative values if unit is over water.
#define UPRIGHT			79	//SET or GET.  Can allow you to SET the upRight state of a Unit.
#define POW			80	//GET the power of a number
#define PRINT			81	//Special, read below:

/*Prints the value of up to 4 vars / static-vars into the Spring chat.  Very useful for debugging.  

Usage is:

var myTest;
myTest = GET POW (262144, 32768);
GET PRINT (myTest)

Would return:
"Value 1: 131072, 2: 0, 3: 0, 4: 0" to the Chat interface.*/

#define HEADING			82	//SET and GET.  Allows unit HEADING to be returned, SET to value of previous HEADING every frame to keep units from turning.
#define TARGET_ID			83	//GET.  Returns ID of currently targeted Unit.  -1 if none, -2 if force-fire, -3 if Intercept, -4 if the Weapon doesn't exist.
#define LAST_ATTACKER_ID		84	//GET.  Returns ID of last Unit to attack, or -1 if never attacked.  Could theoretically be used to implement special control over weapon systems for a Unit, but I have never seen this done yet.

#define LOS_RADIUS			85	//SET.  SETs the LOS Radius (per Ground).  Could be used in conjunction with Activate().
#define AIR_LOS_RADIUS		86	//SET.  SETs the LOS Radius (per Air).  Could be used in conjunction with Activate().
#define RADAR_RADIUS          		87 	// SET or GET, just like the Unit def.
#define JAMMER_RADIUS          	88 	// SET or GET, just like the Unit def.
#define SONAR_RADIUS          		89 	// SET or GET, just like the Unit def.
#define SONAR_JAM_RADIUS       	90 	// SET or GET, just like the Unit def.
#define SEISMIC_RADIUS          		91 	// SET or GET, just like the Unit def.
#define DO_SEISMIC_PING		92	//GET (GET DO_SEISMIC_PING(size)) Emits a Seismic Ping.  Can be seen by all players regardless of LOS.
#define CURRENT_FUEL          		93 	// SET or GET, Fuel level is currently (0.75b2) being used for Aircraft only- when 0, Aircraft return to an Air Repair location.  Could be used for dynamic fuel based on time of flight (as opposed to weapons use) or for more detailed control over weapons than Spring's defaults.

#define TRANSPORT_ID		94	// GET.  Returns ID of the Transport the Unit is in.  -1 if not loaded.
#define SHIELD_POWER		95	// GET / SET.  Manipulates Shield, if Unit has one, good for timed Shield disruptions.  Set to 0 every frame if you want to keep a Shield down for some reason.
#define STEALTH                   		96 	// set or get
#define CRASHING                  		97 	// set or get, returns whether aircraft isCrashing state
#define CHANGE_TARGET            	 98 	// set, the value it's set to determines the affected weapon
#define CEG_DAMAGE                	99 	// set
#define COB_ID                   		100 	// get
#define PLAY_SOUND		101	//GET only.  Plays sounds via these instructions:

/*
1) Adds a new get call, PLAY_SOUND, to play a sound that can be heard only by allies, enemy, in los, etc.
2) changes get health to allow a unit ID to be passed
3) adds a call to create() at the end of ReloadCOB

GET PLAY_SOUND(sound number, volume, who hears the sound, where to play the sound)

To set up sounds to use with GET PLAY_SOUND, put a function like this near the top of your bos:
Sounds()
{
play-sound ("movement", 10);
play-sound ("pew", 10);
play-sound ("reporting", 10);
}
The sound number is based on the order the sounds appear, staring from 0. To call the songs by name, add #defines like this:
Sounds()
{
play-sound ("movement", 10);
#define movement 0
play-sound ("pew", 10);
#define pew 1
play-sound ("reporting", 10);
#define reporting 2
}

To actually call the sound, you use a line such as this:
GET PLAY_SOUND (pew, 655360);

1) sound number - as above

2) volume - similar to the volume for play-sound, more affecting the distance where it is audible than actual volume
- given as a float multiplied by 65536

3) who hears the sound
0 = anyone with the unit in ALOS
1 = anyone with the unit in LOS
2 = anyone with the unit in ALOS or radar
3 = anyone with the unit in LOS or radar
4 = everyone
5 = the unit's allies
6 = the unit's team
7 = the unit's enemies

4) where to play the sound
- if 0, the sound is played from the unit's position
- if 1, the sound is played directly from the speakers, the same way unit replies are*/

#define KILL_UNIT			102	//GET.  Kills the Unit this frame.  Supplying no unit number kills the calling unit (for convenience). Returns zero if the target doesn't exist.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////LuaCOB
#define LUA0			110  // All are SET / GET, for passing args to LuaCOB interface.
#define LUA1			111
#define LUA2			112
#define LUA3			113
#define LUA4			114
#define LUA5			115
#define LUA6			116
#define LUA7			117
#define LUA8			118
#define LUA9			119
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define FLANK_B_MODE             	120 	// set or get
#define FLANK_B_DIR              		121	 // set or get, set is through get for multiple args
#define FLANK_B_MOBILITY_ADD     	122 	// set or get
#define FLANK_B_MAX_DAMAGE       	123 	// set or get
#define FLANK_B_MIN_DAMAGE       	124 	// set or get

//Weapon Modifications, via COB
/*All of these use the first param (starting at 1) as the weapon index whereby positive means read and negative means write the second param to the value. 
In the latter case the previous value is returned.*/
#define WEAPON_RELOADSTATE 	125 //(frame number of the next shot/burst)
#define WEAPON_RELOADTIME 	126 //(in frames)
#define WEAPON_ACCURACY 		127
#define WEAPON_SPRAY 		128
#define WEAPON_RANGE 		129
#define WEAPON_PROJECTILESPEED 	130

/////////////////////////////////////////////////////////////////////////////////////////Signal Definitions below.  Can be any power-of-two for OTA, may in Spring be any integer.
#define SIG_AIM1		2
#define SIG_AIM2		4
#define SIG_AIM3		8
#define SIG_AIM4		16
#define SIG_AIM5		32
//////////////////////////////////////////////////////////////////////////////////////////////////////////////LuaCOB, standard calls (mod-specific, this needs to be hacked by designer, unfortunately poorly documented by me)
lua_PlayUnitSound() { return 0; }
lua_PlayLocalSound() { return 0; }
lua_PlayWorldSound() { return 0; }
#endif // STANDARD_COMMANDS_PURE_H_