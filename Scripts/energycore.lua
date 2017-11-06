local base = piece "base"
local f = 0
local x = ((math.floor((math.random()*180)/90))*90)* math.pi / 180
local z = ((math.floor((math.random()*180)/90))*90)* math.pi / 180
local y = ((math.floor((math.random()*180)/90))*90)* math.pi / 180

function script.Create()
	Turn (base, x_axis, x, x/1.25)
	Turn (base, z_axis, z, z/1.25)
	Turn (base, y_axis, y, y/1.25)
end

function Sink()
	StartThread(MoveDown)
end

function MoveDown()
	while f > -900 do
		Move(base, 2, f)
		f = f - 0.05
		Sleep(1)
	end
end