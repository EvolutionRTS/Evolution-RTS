function gadget:GetInfo()
return {
	name      = "Buttons",
	desc      = "Sets icons for buttons",
	author    = "Smoth",
	date      = "july, 2009",
	license   = "public domain",
	layer     = -5,
	enabled   = false  --  loaded by default?
	}
end

	
if (gadgetHandler:IsSyncedCode()) then

local cmdbuttonDefs = {}
local cmdID

	if VFS.FileExists("LuaRules/Configs/cmdbuttons.lua") then
		cmdbuttonDefs = VFS.Include("LuaRules/Configs/cmdbuttons.lua")
		else
			error("missing file: LuaRules/Configs/cmdbuttons.lua")
	end

	function gadget:UnitGiven(u, ud, team)
		gadget:UnitFinished(u,ud,team)
	end

	function gadget:UnitCreated(u, ud, team)
		gadget:UnitFinished(u,ud,team)
	end

	function gadget:UnitFinished(u, ud, team)
		
		for CMDBTN,CMDBTNID in pairs(cmdbuttonDefs) do
			cmdID = Spring.FindUnitCmdDesc(u, CMD[CMDBTN] )

			if ( cmdID and cmdbuttonDefs[CMDBTN].texture ) then
				Spring.EditUnitCmdDesc(u, cmdID, { texture = cmdbuttonDefs[CMDBTN].texture,} )
			end
			
			if ( cmdID and CMDBTN == "DGUN" and ud == UnitDefNames.juagg.id ) then
				Spring.EditUnitCmdDesc(u, cmdID, {name="Barrage", tooltip="FIRE ALL GUNS", texture="bitmaps/ui/abilities/barrage.png",} )
			end

		end	
	end -- end unit finished

	-- function gadget:AllowCommand(u, ud, team, cmd, param, opts)
		-- if cmd == CMD.REPEAT then

			-- cmdID = Spring.FindUnitCmdDesc(u, CMD.REPEAT )	
			
			-- Spring.Echo(Spring.GetUnitStates(u)["repeat"])
				-- if	( Spring.GetUnitStates(u)["repeat"] == true ) then
					-- Spring.Echo("REPEAT on!")
					-- Spring.EditUnitCmdDesc(u, cmdID, { "bitmaps/ui/repeaton.png", onlyTexture=true, } )
				-- else	
					-- Spring.Echo("REPEAT off!")
					-- Spring.EditUnitCmdDesc(u, cmdID, { "bitmaps/ui/repeatoff.png", onlyTexture=true, } )
				-- end
			-- return CMD[CMDBTN]	
			-- end -- end repeat hanlder	
	-- end -- end allow command

end
