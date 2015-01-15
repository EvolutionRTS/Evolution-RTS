
function gadget:GetInfo()
	return {
		name	= 'Lego Atlas Loader',
		desc	= 'Forces the Lego v2 atlas to be loaded',
		author	= 'Bluestone',
		date	= '',
		license	= 'GNU GPL v3',
		layer	= 0, 
		enabled	= true,
	}
end

-- this is a bit of a hack!

if gadgetHandler:IsSyncedCode() then return false end

local n = 0
local ATLASUNIT = UnitDefNames["ecommander"].id

function gadget:DrawWorld()
    n  = n + 1

    if n==1 then
        gl.PushMatrix()
            gl.Translate(-1000, -1000, -1000)
            gl.UnitShape(ATLASUNIT, 0)
        gl.PopMatrix()
    end
    
    if n>1 then
        gadgetHandler:RemoveGadget()
    end

end