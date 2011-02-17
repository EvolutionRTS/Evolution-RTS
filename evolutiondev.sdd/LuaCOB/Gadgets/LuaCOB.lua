
function gadget:GetInfo()
	return {
		name = "LuaCOB",
		desc = "LuaCOB stuff",
		author = "lurker",
		date = "January 2008",
		license = "Public domain",
		layer = 1,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then

function frame() return Spring.GetGameFrame() end

function gadget:Initialize()
	gadgetHandler:RegisterGlobal("frame", frame)
end

end
