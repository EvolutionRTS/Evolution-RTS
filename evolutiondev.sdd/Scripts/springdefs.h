//==============================================================================
//
// Constants and macros for Spring /units/*.BOS
//
// Made by merging the exptype.h and sfxtype.h that are tradionally shipped with Scriptor
// Which are themselves edited from the ones inside Cavedog's Totala1.hpi
// And the #define from https://spring.clan-sy.com/svn/spring/trunk/rts/Sim/Units/COB/CobInstance.cpp
//
//==============================================================================

#ifndef SPRING_SCRIPTS_H
#define SPRING_SCRIPTS_H


// To use with the "emit-sfx" command:

// Vector-based special effects
#define SFXTYPE_VTOL			0
#define SFXTYPE_THRUST			1
#define	SFXTYPE_WAKE1			2
#define	SFXTYPE_WAKE2			3
#define	SFXTYPE_REVERSEWAKE1	4
#define	SFXTYPE_REVERSEWAKE2	5

// Point-based (piece origin) special effects
#define SFXTYPE_POINTBASED	256
#define SFXTYPE_WHITESMOKE	(SFXTYPE_POINTBASED | 1)
#define SFXTYPE_BLACKSMOKE	(SFXTYPE_POINTBASED | 2)
#define SFXTYPE_SUBBUBBLES	(SFXTYPE_POINTBASED | 3)
// TA:K sfx, maybe not implemented in Spring
#define SFXTYPE_SMALLDAMAGEFLAME	(SFXTYPE_POINTBASED | 4)
#define SFXTYPE_MEDIUMDAMAGEFLAME	(SFXTYPE_POINTBASED | 5)
#define SFXTYPE_LARGEDAMAGEFLAME	(SFXTYPE_POINTBASED | 6)

// Probably not implemented in Spring, TA:K stuff
#define PLAYSOUND_PRIORITY_BATTLE		4

// Probably not implemented in Spring, probably TA:K stuff
#define SFXOCCUPY_AIR		5 // SFX Occupy States

// To use with the "explode" command:
#define SHATTER			1		// The piece will shatter instead of remaining whole
#define EXPLODE_ON_HIT	2		// The piece will explode when it hits the ground
#define FALL			4		// The piece will fall due to gravity instead of just flying off
#define SMOKE			8		// A smoke trail will follow the piece through the air
#define FIRE			16		// A fire trail will follow the piece through the air
#define BITMAPONLY		32		// The piece will not fly off or shatter or anything.  Only a bitmap explosion will be rendered.
#define BITMAP1			256
#define BITMAP2			512
#define BITMAP3			1024
#define BITMAP4			2048
#define BITMAP5			4096
#define BITMAPNUKE		8192
#define BITMAPMASK		16128	// Mask of the possible bitmap bits

// Probably not implemented in Spring, TA:K stuff
#define EXPTYPE_SMALLEXPLOSION	256
#define EXPTYPE_MEDIUMEXPLOSION	512
#define EXPTYPE_LARGEEXPLOSION	1024
#define EXPTYPE_XLARGEEXPLOSION	2048
#define EXPTYPE_BLOODEXPLOSION	4096
#define EXPTYPE_SMALLSMOKE		8192
#define EXPTYPE_MEDIUMSMOKE		16384
#define EXPTYPE_XLARGESMOKE		65536

// Probably not implemented in Spring, TA:K stuff (DT stands for Damage Type)
#define DT_FIRE					2
#define DT_EXPLOSION			3
#define DT_PARALYZER			4

// Indices for set/get value
#define ACTIVATION           1  // set or get
#define STANDINGMOVEORDERS   2  // set or get
#define STANDINGFIREORDERS   3  // set or get
#define HEALTH               4  // get (0-100%)
#define INBUILDSTANCE        5  // set or get
#define BUSY                 6  // set or get (used by misc. special case missions like transport ships)
#define PIECE_XZ             7  // get
#define PIECE_Y              8  // get
#define UNIT_XZ              9  // get
#define UNIT_Y              10  // get
#define UNIT_HEIGHT         11  // get
#define XZ_ATAN             12  // get atan of packed x,z coords
#define XZ_HYPOT            13  // get hypot of packed x,z coords
#define ATAN                14  // get ordinary two-parameter atan
#define HYPOT               15  // get ordinary two-parameter hypot
#define GROUND_HEIGHT       16  // get land height, 0 if below water
#define BUILD_PERCENT_LEFT  17  // get 0 = unit is built and ready, 1-100 = How much is left to build
#define YARD_OPEN           18  // set or get (change which plots we occupy when building opens and closes)
#define BUGGER_OFF          19  // set or get (ask other units to clear the area)
#define ARMORED             20  // set or get

#define WEAPON_AIM_ABORTED  21 // Not implemented in Spring, TAK stuff
#define WEAPON_READY        22 // Not implemented in Spring, TAK stuff
#define WEAPON_LAUNCH_NOW   23 // Not implemented in Spring, TAK stuff
#define FINISHED_DYING      26 // Not implemented in Spring, TAK stuff
#define ORIENTATION         27 // Not implemented in Spring, TAK stuff
#define IN_WATER            28
#define CURRENT_SPEED       29
#define MAGIC_DEATH         31 // Not implemented in Spring, TAK stuff
#define VETERAN_LEVEL       32
#define ON_ROAD             34

#define MAX_ID                    70
#define MY_ID                     71
#define UNIT_TEAM                 72
#define UNIT_BUILD_PERCENT_LEFT   73
#define UNIT_ALLIED               74
#define MAX_SPEED                 75
#define CLOAKED                   76
#define WANT_CLOAK                77
#define GROUND_WATER_HEIGHT       78 // get land height, negative if below water
#define UPRIGHT                   79 // set or get
#define POW                       80 // get
#define PRINT                     81 // get, so multiple args can be passed
#define HEADING                   82 // get
#define TARGET_ID                 83 // get
#define LAST_ATTACKER_ID          84 // get
#define LOS_RADIUS                85 // set or get
#define AIR_LOS_RADIUS            86 // set or get
#define RADAR_RADIUS              87 // set or get
#define JAMMER_RADIUS             88 // set or get
#define SONAR_RADIUS              89 // set or get
#define SONAR_JAM_RADIUS          90 // set or get
#define SEISMIC_RADIUS            91 // set or get
#define DO_SEISMIC_PING           92 // get
#define CURRENT_FUEL              93 // set or get
#define TRANSPORT_ID              94 // get
#define SHIELD_POWER              95 // set or get
#define STEALTH                   96 // set or get
#define CRASHING                  97 // set or get, returns whether aircraft isCrashing state
#define CHANGE_TARGET             98 // set, the value it's set to determines the affected weapon
#define CEG_DAMAGE                99 // set
#define COB_ID                   100 // get
#define PLAY_SOUND               101 // get, so multiple args can be passed
#define KILL_UNIT                102 // get KILL_UNIT(unitId, SelfDestruct=true, Reclaimed=false)
#define ALPHA_THRESHOLD          103 // set or get
#define SET_WEAPON_UNIT_TARGET   106 // get (fake set)
#define SET_WEAPON_GROUND_TARGET 107 // get (fake set)
#define LUA0 110
#define LUA1 111
#define LUA2 112
#define LUA3 113
#define LUA4 114
#define LUA5 115
#define LUA6 116
#define LUA7 117
#define LUA8 118
#define LUA9 119
#define FLANK_B_MODE             120 // set or get
#define FLANK_B_DIR              121 // set or get, set is through get for multiple args
#define FLANK_B_MOBILITY_ADD     122 // set or get
#define FLANK_B_MAX_DAMAGE       123 // set or get
#define FLANK_B_MIN_DAMAGE       124 // set or get
#define WEAPON_RELOADSTATE       125 // get (with fake set)
#define WEAPON_RELOADTIME        126 // get (with fake set)
#define WEAPON_ACCURACY          127 // get (with fake set)
#define WEAPON_SPRAY             128 // get (with fake set)
#define WEAPON_RANGE             129 // get (with fake set)
#define WEAPON_PROJECTILE_SPEED  130 // get (with fake set)

// NOTE: shared variables use codes [1024 - 5119]

#endif // SPRING_SCRIPTS_H
