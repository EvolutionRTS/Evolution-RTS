local base = piece 'base' 
local link = piece 'link' 
local engine1 = piece 'engine1' 
local engine2 = piece 'engine2' 
local wingsfront = piece 'wingsfront' 
local wingsrear = piece 'wingsrear' 
local tail = piece 'tail' 


local  Static_Var_1, unitviewer, statechg_DesiredState, statechg_StateChanging, moving

smokePiece = { base }

-- Signal definitions
local SIG_MOVE = 4
local flame = 1024+0


function SmokeUnit()
	local spGetUnitIsCloaked = Spring.GetUnitIsCloaked
	
	if not (smokePiece and smokePiece[1]) then 
		return 
	end
	while (GetUnitValue(COB.BUILD_PERCENT_LEFT) ~= 0) do
		Sleep(400) 
	end
	--Smoke loop
	while true do
		--How is the unit doing?
		local healthPercent = GetUnitValue(COB.HEALTH)
		if (healthPercent < 66) and not spGetUnitIsCloaked(unitID) then -- only smoke if less then 2/3rd health left
			EmitSfx(smokePiece[math.random(1,#smokePiece)], SMOKEPUFF)
		end
		Sleep(8*healthPercent + math.random(100,200))
	end
end

local function Thrust()

   while  true  do
   
      if moving then    
      
              EmitSfx( engine1,  flame )
              EmitSfx( engine2,  flame )
                end
        Sleep( 5)    
   end
end

function script.StartMoving()

        moving=1
end
   
function script.StopMoving()
   
        moving=false
end

function script.MoveRate(rate)

  if rate == 0 then
    Turn( tail , x_axis, math.rad(-90.000000), math.rad(150.000000) )
 	Turn( wingsfront , x_axis, math.rad(-90.000000), math.rad(150.000000) )
 	Turn( wingsrear , x_axis, math.rad(-90.000000), math.rad(150.000000) )
  elseif rate == 1 then
 	Turn( wingsfront , x_axis, math.rad(-70.005495), math.rad(150.000000) )
 	Turn( wingsrear , x_axis, math.rad(-70.005495), math.rad(150.000000) )
  elseif rate == 2 then
    Turn( tail , x_axis, 0, math.rad(150.000000) )
 	Turn( wingsfront , x_axis, 0, math.rad(150.000000) )
 	Turn( wingsrear , x_axis, 0, math.rad(150.000000) )
  end

end
function script.Create()

        Static_Var_1 = 0
   unitviewer = false

--   Turn( engine1 , y_axis, math.rad(180) )
--   Turn( engine2 , y_axis, math.rad(180) )
   Turn( tail , x_axis, math.rad(-90) )
         Turn( wingsfront , x_axis, math.rad(-90) )
         Turn( wingsrear , x_axis, math.rad(-90) )
--   StartThread(Thrust)
   -- StartThread(SmokeUnit)
end

function script.QueryTransport()

  return 1
end

function script.BeginTransport(Func_Var_1)

   Move( link , y_axis, 0.000000 - Func_Var_1  )
end


function script.Killed(severity, corpsetype) -- how it explodes 
 

	--explode base type EXPLODE_ON_HIT
    Explode( base, SFX.EXPLODE_ON_HIT )
	--explode engine1 type EXPLODE_ON_HIT
    Explode( engine1, SFX.EXPLODE_ON_HIT )
--[[
	explode engine2 type EXPLODE_ON_HIT
	explode wingsfront type EXPLODE_ON_HIT
	explode wingsrear type EXPLODE_ON_HIT
	explode tail type EXPLODE_ON_HIT
--]]
	return 1 
end 
