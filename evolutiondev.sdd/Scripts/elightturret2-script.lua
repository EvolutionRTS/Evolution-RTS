local base = piece 'base' 
local turret = piece 'turret' 
local barrel1 = piece 'barrel1' 
local firepoint1 = piece 'firepoint1' 
local firepoint2 = piece 'firepoint2' 
local sfxpoint1 = piece 'sfxpoint1' 

 -- these are the pieces of the model

local CanFire, shooting_num

-- Signal definitions
local SIG_AIM = 2 -- this is a aim define <- o_O This is a kill flag


-- Custom SFX
local GDMARTY = 1024+0

-- function script.SmokeUnit()

	-- var healthpercent, sleeptime, smoketype
	-- while  true  do
	
		-- healthpercent =  select(1, Spring.GetUnitHealth(unitID) ) / select(2, Spring.GetUnitHealth(unitID) )
		-- if  healthpercent < 66  then
		
			-- smoketype = SFXTYPE_BLACKSMOKE
			-- if  1, 66 ) < healthpercent  then
				-- smoketype = SFXTYPE_WHITESMOKE
			-- EmitSfx( base,  smoketype )
		-- end
		-- sleeptime = healthpercent * 50
		-- if  sleeptime < 200  then
			-- sleeptime = 200
		-- Sleep(sleeptime)
	-- end
-- end

local function cannotfire()

   while  true  do
   
      if not CanFire then
      
		EmitSfx( sfxpoint1,  1025 )
	  end
	Sleep(1500)
   end
end

function script.Create() -- tells it what to do on creation

	CanFire=false
	shooting_num=1
	while  
	select(5, Spring.GetUnitHealth(unitID)) < 1  do
		Sleep(400)
	end
--	StartThread(function script.SmokeUnit)
	StartThread(cannotfire)
end

local function RestoreAfterDelay() -- restore function to turn the turret and so forth back to start

	Sleep(3000)
	Turn( turret , y_axis, 0, math.rad(60) )
	Turn( barrel1 , x_axis, 0, math.rad(30) )
end

function script.AimWeapon1(heading, pitch) -- aiming animation and firing authorization

	Signal( SIG_AIM)
	SetSignalMask( SIG_AIM)
	while not CanFire do
		Sleep(200)
	end
	Turn( turret , y_axis, math.rad(heading ), math.rad(225) )
	Turn( barrel1 , x_axis, 0, math.rad(150) )
	WaitForTurn(turret, y_axis)
	WaitForTurn(barrel1, x_axis)
	StartThread(RestoreAfterDelay)
	return (1)
end

function script.FireWeapon1() -- what do while firing, fires 1 barrel then the next , and resets

	
         if shooting_num==1 then
         
         	EmitSfx( firepoint2,  GDMARTY )
         end

         if shooting_num==2 then
         
         	EmitSfx( firepoint1,  GDMARTY )
         end
	
   shooting_num=shooting_num+1

            if  shooting_num == 3 then
              
            	shooting_num=1
            end
	
end

function script.AimFromWeapon1() -- where it aims the weapon from

	return barrel1
end

function script.QueryWeapon1() -- where the shot is created at


	 if shooting_num==1 then 
       
     	return firepoint1     
     end

     if shooting_num==2 then
        
     	return firepoint2
     end
	
end

local function TechLost()

	CanFire=false
	Signal( SIG_AIM)
	
end

local function TechGranted()

	CanFire=true
end

function script.Killed(severity, corpsetype) -- how it explodes

	if  severity <= 25  then
	
		Explode(turret, SFX.BITMAPONLY)
		Explode(barrel1, SFX.BITMAPONLY)
		return (0)
	end
	if  severity <= 80  then
	
		Explode(turret, SFX.BITMAPONLY)
		Explode(barrel1, SFX.SHATTER)
		return (0)
	end
	if  severity <= 99  then
	
		Explode(turret, SFX.BITMAPONLY)
		Explode(barrel1, SFX.SHATTER)
		return (0)
	end
	Explode(turret, SFX.FALL + SFX.SMOKE  + SFX.FIRE  + SFX.EXPLODE_ON_HIT )
	Explode(barrel1, SFX.SHATTER + SFX.EXPLODE_ON_HIT )
	return (0)
end
