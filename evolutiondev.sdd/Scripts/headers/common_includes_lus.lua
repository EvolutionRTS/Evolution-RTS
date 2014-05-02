common = {

	CustomEmitter = function (unitID, pieceName, effectName)
		--Spring.Echo(unitID, pieceName, effectName)
		local x,y,z,dx,dy,dz	= Spring.GetUnitPiecePosDir(unitID,pieceName)
				
		Spring.SpawnCEG(effectName, x,y,z, dx, dy, dz)
	end,

    setSFXoccupy = function (setSFXoccupy_argument)
		Spring.Echo(type(setSFXoccupy_argument))
		Spring.Echo("common.setSFXoccupy is being called", setSFXoccupy_argument)
		Spring.Echo(setSFXoccupy_argument == 1, setSFXoccupy_argument == 2)
		Spring.Echo(setSFXoccupy_argument == 4, setSFXoccupy_argument == 3, setSFXoccupy_argument == 0)
            if setSFXoccupy_argument == 1 or setSFXoccupy_argument == 2 then
				Move(base, y_axis, 0, 50)
				SetUnitValue(COB.UPRIGHT, 1)
				Spring.Echo("Setting Upright: 1")
            elseif setSFXoccupy_argument == 4 or setSFXoccupy_argument == 3 or setSFXoccupy_argument == 0 then
				SetUnitValue(COB.UPRIGHT, 0)
				Spring.Echo("Setting Upright: 0")
			end
    end,
	
	DirtTrail = function ()
		while isMoving do
			common.CustomEmitter(unitID, dirt, "dirt") -- Second argument is the piece name, third argument needs to be a string because it will be the name of the CEG effect used
			Sleep(400)
		end
	end,
}
return common