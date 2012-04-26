-- $Id: icon_generator.lua 4354 2009-04-11 14:32:28Z licho $
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
--  Icon Generator Config File
--

--// Info
if (info) then
  local ratios      = {["5to4"]=(4/5)} --{["16to10"]=(10/16), ["1to1"]=(1/1), ["5to4"]=(4/5)} --, ["4to3"]=(3/4)}
  local resolutions = {{128,128}} --{{128,128},{64,64}}
  local schemes     = {""}

  return schemes,resolutions,ratios
end

-----------------------------------------------------------------------
-----------------------------------------------------------------------

--// filename ext
imageExt = ".png"

--// render into a fbo in 4x size
renderScale = 4

--// faction colors (check (and needs) LuaRules/factions.lua)
factionTeams = {
  arm     = 0,   --// arm
  core    = 1,   --// core
  chicken = 2,   --// chicken
  unknown = 2,   --// unknown
}
factionColors = {
  arm     = {0.05, 0.96, 0.95},   --// arm
  core    = {0.05, 0.96, 0.95},   --// core
  chicken = {1.0,0.8,0.2},   --// chicken
  unknown = {1.0, 0, 0},   --// unknown
}


-----------------------------------------------------------------------
-----------------------------------------------------------------------

--// render options textured
textured = (scheme~="bw")
lightAmbient = {1.1,1.1,1.1}
lightDiffuse = {0.4,0.4,0.4}
lightPos     = {-0.2,0.4,0.5}

--// Ambient Occlusion & Outline settings
aoPower     = ((scheme=="bw") and 1.5) or 1
aoContrast  = ((scheme=="bw") and 2.5) or 1
aoTolerance = 0
olContrast  = ((scheme=="bw") and 5) or 10
olTolerance = 0

--// halo (white)
halo  = false --(scheme~="bw")


-----------------------------------------------------------------------
-----------------------------------------------------------------------

--// backgrounds
background = true
local function Greater30(a)     return a>30;  end
local function GreaterEq15(a)   return a>=15; end
local function GreaterZero(a)   return a>0;   end
local function GreaterEqZero(a) return a>=0;  end
local function GreaterFour(a)   return a>4;   end
local function LessEqZero(a)    return a<=0;  end
local function IsCoreOrChicken(a)
	if a then return a.chicken
	else return false end
end
backgrounds = {


  
  {check={},                                                 texture="LuaRules/Images/IconGenBkgs/transparent.png"},
}


-----------------------------------------------------------------------
-----------------------------------------------------------------------

--// default settings for rendering
--//zoom   := used to make all model icons same in size (DON'T USE, it is just for auto-configuration!)
--//offset := used to center the model in the fbo (not in the final icon!) (DON'T USE, it is just for auto-configuration!)
--//rot    := facing direction
--//angle  := topdown angle of the camera (0 degree = frontal, 90 degree = topdown)
--//clamp  := clip everything beneath it (hide underground stuff)
--//scale  := render the model x times as large and then scale down, to replaces missing AA support of FBOs (and fix rendering of very tine structures like antennas etc.))
--//unfold := unit needs cob to unfolds
--//move   := send moving cob events (works only with unfold)
--//attack := send attack cob events (works only with unfold)
--//shotangle := vertical aiming, useful for arties etc. (works only with unfold+attack)
--//wait   := wait that time in gameframes before taking the screenshot (default 300) (works only with unfold)
--//border := free space around the final icon (in percent/100)
--//empty  := empty model (used for fake units in CA)
--//attempts := number of tries to scale the model to fit in the icon

defaults = {border=0.05, angle=45, rot="right", clamp=-10000, scale=1.5, empty=false, attempts=10, wait=120, zoom=1.0, offset={0,0,0},};


-----------------------------------------------------------------------
-----------------------------------------------------------------------

--// per unitdef settings
unitConfigs = {
  [UnitDefNames.eartytank.id]  = { wait = 30 },
  [UnitDefNames.ebasefactory.id]  = { wait = 30 },
  [UnitDefNames.ebomber.id]  = { wait = 30 },
  [UnitDefNames.efatso2.id]  = { wait = 30 },
  [UnitDefNames.efighter.id]  = { wait = 30 },
  [UnitDefNames.eflametank.id]  = { wait = 30 },
  [UnitDefNames.efusion2.id]  = { wait = 30 },
  [UnitDefNames.egeothermal.id]  = { wait = 30 },
  [UnitDefNames.egunship2.id]  = { wait = 30 },
  [UnitDefNames.eheavytank3.id]  = { wait = 30 },
  [UnitDefNames.eheavyturret2.id]  = { wait = 30 },
  [UnitDefNames.ejammer2.id]  = { wait = 30 },
  [UnitDefNames.elighttank3.id]  = { wait = 30 },
  [UnitDefNames.elightturret2.id]  = { wait = 30 },
  [UnitDefNames.emediumtank3.id]  = { wait = 30 },
  [UnitDefNames.emetalextractor.id]  = { wait = 30 },
  [UnitDefNames.emissiletank.id]  = { wait = 30 },
  [UnitDefNames.eradar2.id]  = { wait = 30 },
  [UnitDefNames.eriottank2.id]  = { wait = 30 },
  [UnitDefNames.escout.id]  = { wait = 30 },
  [UnitDefNames.esolar2.id]  = { wait = 30 },
  [UnitDefNames.estorage.id]  = { wait = 30 },
  [UnitDefNames.etransport.id]  = { wait = 30 },
}

for i=1,#UnitDefs do
  if (UnitDefs[i].canFly) then
    if (unitConfigs[i]) then
      if (unitConfigs[i].unfold ~= false) then
        unitConfigs[i].unfold = true
        unitConfigs[i].move   = true
      end
    else
      unitConfigs[i] = {unfold = true, move = true}
    end
  elseif (UnitDefs[i].canKamikaze) then
    if (unitConfigs[i]) then
      if (not unitConfigs[i].border) then
        unitConfigs[i].border = 0.156
      end
    else
      unitConfigs[i] = {border = 0.156}
    end
  end
end