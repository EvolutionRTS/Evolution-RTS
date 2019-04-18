function gadget:GetInfo()
    return {
        name = "Instant Unload",
        desc = "Allows Flood load & unload",
        author = "aZaremoth, unload support added by MaDDoX",
        date = "March, 2015",
        license = "Public Domain, or the least-restrictive license your country allows.",
        layer = 1,
        enabled = true,
    }
end
------------------------------------------------------------------------
include("LuaRules/Configs/customcmds.h.lua")
--- [Deprecated] new lua core is added)
--VFS.Include("LuaRules/Utilities/utilities_emul.lua")
--VFS.Include("LuaRules/Utilities/ClampPosition.lua")
VFS.Include("gamedata/evotools.lua")


if gadgetHandler:IsSyncedCode() then

--------------------------------------------------------------------------------
--region  SYNCED
--------------------------------------------------------------------------------

--local GiveClampedOrderToUnit = Spring.Utilities.GiveClampedOrderToUnit
local CMD_INSERT 		= CMD.INSERT
local CMD_MOVE			= CMD.MOVE
local CMD_REMOVE        = CMD.REMOVE
local CMD_WAIT			= CMD.WAIT
local CMD_STOP			= CMD.STOP
local CMD_GUARD			= CMD.GUARD
local CMD_LOAD_ONTO		= CMD.LOAD_ONTO
local CMD_SET_WANTED_MAX_SPEED = CMD.SET_WANTED_MAX_SPEED   -- 70
local CMD_UNLOAD_UNIT   = 81 --CMD.UNLOAD_UNIT   --81
local CMD_UNLOAD_UNITS  = 80 --CMD.UNLOAD_UNITS  --80
local CMD_LOAD_UNITS	= CMD.LOAD_UNITS
local CMD_OPT_INTERNAL 	= CMD.OPT_INTERNAL
local CMD_OPT_SHIFT 	= CMD.OPT_SHIFT

local loadtheseunits = {}               --// { [unitID] = transportID, ... }
    --- Whenever an unload is registered, this table holds which transports are moving towards unload range
local transportstounload = {}             --// { [transportID]={ x, y, z, r }, ... } || r == nil  =>  unload click
local passengermovingtoload = {}
local transportmovingtoload = {}          --// { [transportID]=f, ...} || f = frame after when it should be tracked
    --- 'Assignable' changes after a load command is registered, transportcapacity only changes after actual loading
local currentassignablecapacity = {}    --// { [transportID] = number, ...} should be made global in Initialize()
local currenttransportcapacity = {}
local unitisintransport = {}
local passengers = {}                   --// [transportID]={ [0]=passengerUID1, [1]=passengerUID2, ... }
local queueMovePassengers = {}      --// { [unitID] = frame, ... }
local queuedMoveCommands = {}       --// { unitID=unitID, shift=shift, pos={x,y,z}}

local spGetAllUnits = Spring.GetAllUnits
local spGetGameFrame = Spring.GetGameFrame
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitDefID    = Spring.GetUnitDefID
local spGetUnitTeam = Spring.GetUnitTeam
local spGetUnitMoveTypeData = Spring.GetUnitMoveTypeData
local spGetUnitsInCylinder = Spring.GetUnitsInCylinder
local spUnitAttach = Spring.UnitAttach
local spUnitDetach = Spring.UnitDetach
local spUnitDetachFromAir = Spring.UnitDetachFromAir
local spSetUnitLoadingTransport = Spring.SetUnitLoadingTransport
local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetUnitsInCylinder = Spring.GetUnitsInCylinder

local mcSetPosition         = Spring.MoveCtrl.SetPosition
--local mcSetRotation         = Spring.MoveCtrl.SetRotation
local mcDisable             = Spring.MoveCtrl.Disable
local mcEnable              = Spring.MoveCtrl.Enable

local function sqr (x)
    return math.pow(x, 2)
end

function gadget:Initialize()
    _G.currentassignablecapacity = currentassignablecapacity   --// making it global for unsynced access via SYNCED table
    local allUnits = spGetAllUnits()
    for i = 1, #allUnits do
        local unitID    = allUnits[i]
        local unitDefID = spGetUnitDefID(unitID)
        gadget:UnitCreated(unitID, unitDefID)
    end
end

function gadget:UnitCreated(unitID, unitDefID) --, team, builderID
    unitisintransport[unitID] = false
    passengermovingtoload[unitID] = false
    if not UnitDefs[unitDefID].isTransport then
        --Spring.Echo(" Not a transport! ")
        return end
    local transportcapacity = tonumber(UnitDefs[unitDefID].transportCapacity)
    if transportcapacity == nil then
        transportcapacity = 0
    end
    currenttransportcapacity[unitID] = transportcapacity
    currentassignablecapacity[unitID] = transportcapacity
    --_G.currentassignablecapacity = currentassignablecapacity
    --Spring.Echo("Assignable capacity table count: "..pairs_len(currentassignablecapacity))
    transportmovingtoload[unitID] = nil
end

-- Can this unit be transported?
local function canBeTransported(unitDefID)
    return tobool(UnitDefs[unitDefID].cantBeTransported) == false
end

-- Does this unit has available transport capacity?
local function hasAssignableCapacity(unitID)
    --Spring.Echo("Current assignable capacity: ",tostring(currentassignablecapacity[unitID]))
    return currentassignablecapacity[unitID] and tonumber(currentassignablecapacity[unitID]) > 0
end

local function hasCurrentCapacity(unitID)
    return currenttransportcapacity[unitID] and tonumber(currenttransportcapacity[unitID]) > 0
end

local function CancelLoad(unitID)
    for pUnitID, transporterID in pairs(loadtheseunits) do
        if pUnitID == unitID                            -- passenger received STOP/MOVE
                or transporterID == unitID then         -- transporter received STOP/MOVE
            currentassignablecapacity[transporterID] = currentassignablecapacity[transporterID] + 1
            -- Spring.Echo(currentassignablecapacity[transporterID])
            loadtheseunits[pUnitID] = nil
        end
    end
end

function gadget:AllowCommand(unitID, unitDefID, unitTeam, cmdID, cmdParams, cmdOptions)
    local ud = UnitDefs[unitDefID]
    local transportcapacity = ud.transportCapacity or 0
    local loadingradius = ud.loadingRadius

    --Spring.Echo("CMD ID: "..cmdID.." for unit: "..unitID)

    if transportstounload[unitID] ~= nil
            and cmdID ~= CMD_SET_WANTED_MAX_SPEED and cmdID ~= 1 then   -- 1 == CMD_INSERT (+others)
        --Spring.Echo("Unload canceled by cmdID: "..cmdID)
        transportstounload[unitID] = nil
        --currentassignablecapacity[unitID] = currentassignablecapacity[unitID] + 1
    end

    --if cmdID ~= CMD_SET_WANTED_MAX_SPEED and cmdID ~= 1 then -- 1 == CMD_INSERT (+others) then
    -- If transporter or unit to be loaded is moved or stop, cancel load
    if cmdID == CMD_MOVE or cmdID == CMD_STOP then
        if loadtheseunits[unitID] ~= nil then
            --Spring.Echo("Canceling passenger load of "..unitID)
            CancelLoad(unitID)
        end
        if transportmovingtoload[unitID] then
            if spGetGameFrame() > transportmovingtoload[unitID] then
                --Spring.Echo("Canceling transporter load of "..unitID)
                transportmovingtoload[unitID] = nil
                CancelLoad(unitID)
            end
        end
    end

    --TODO: Set radius when cmdID == UNLOAD_UNITS
    if cmdID == CMD_UNLOAD_UNIT or cmdID == CMD_UNLOAD_UNITS then
        --Spring.Echo(DebugiTable(cmdParams))
        local x = cmdParams[1] -- x position of click
        local y = cmdParams[2] -- y-position of click
        local z = cmdParams[3] -- z-position of click
        --local r = cmdParams[4] -- radius of the unload circle
        transportstounload[unitID] = { x = x, y = y, z = z, r = nil }
        --Spring.Echo("Added ttu: "..unitID)
        return true
    -- Any command issued between issue-unload and actual unload has to update currentassignablecapacity
    end

    if cmdID == CMD_LOAD_ONTO then -- (76) LOAD ONTO a TRANSPORT, checks if can be transported
        local transportID = cmdParams[1]            --Spring.Echo("load command registered")

        if canBeTransported(unitDefID) and hasAssignableCapacity(transportID)
                and not unitisintransport[unitID] and not loadtheseunits[unitID] then
            Spring.GiveOrderToUnit(unitID, CMD_GUARD, {transportID}, {})
            loadtheseunits[unitID] = transportID
            currentassignablecapacity[transportID] = currentassignablecapacity[transportID] - 1
            --Spring.Echo("Current assignable capacity: "..currentassignablecapacity[transportID])
            passengermovingtoload[unitID] = true
        else
            return false
        end
    end

    -- LOAD UNITS     // check if it's a transporter
    if cmdID == CMD_LOAD_UNITS and transportcapacity > 0 then   --(75)
        --Spring.Echo("Taking load command")
        if hasCurrentCapacity(unitID) and hasAssignableCapacity(unitID) then
            local MyTeam = spGetUnitTeam(unitID)
            local movetype = (spGetUnitMoveTypeData(unitID)).name
            local tx, ty, tz = spGetUnitPosition(unitID) -- transport position
            local x = cmdParams[1] -- x is passenger's unitID if only oneclicked, or the x-position of center of the load circle
            local y = cmdParams[2] -- y-position of center of the load circle
            local z = cmdParams[3] -- z-position of center of the load circle
            local r = cmdParams[4] -- radius of the load circle
            ------------------------------------BUNKER----------------------------------------------------
            if movetype == [[static]] then --is it a bunker?
                if (r == nil) then	-------- load a single unit
                    local xUnitDefID = spGetUnitDefID(x)
                    local xTeam = spGetUnitTeam(x)
                    if canBeTransported(xUnitDefID) and xTeam == MyTeam
                            and currentassignablecapacity[unitID] > 0 and (unitisintransport[x] == false)
                            and (loadtheseunits[x] == nil) then
                        loadtheseunits[x] = unitID
                        currentassignablecapacity[unitID] = (currentassignablecapacity[unitID] - 1)
                        -- Spring.Echo(currentassigablecapacity[unitID])
                        passengermovingtoload[x] = true
                        spGiveOrderToUnit(x, CMD_MOVE, {tx,ty,tz}, {})
                    end
                else -------- load multiple units
                    local UnitsAroundCommand = Spring.GetUnitsInCylinder(x,z,r)
                    for _,cUnitID in ipairs(UnitsAroundCommand) do -- check all units in transport pick-up >c<ircle
                        local cTeam = spGetUnitTeam(cUnitID)
                        if ((cUnitID ~= unitID) and (cTeam == MyTeam)) then
                            local cUnitDefID = spGetUnitDefID(cUnitID)
                            if tobool(UnitDefs[cUnitDefID].cantBeTransported ) == false
                                    and (currentassignablecapacity[unitID] > 0)
                                    and (unitisintransport[cUnitID] == false)
                                    and (loadtheseunits[cUnitID] == nil) then
                                loadtheseunits[cUnitID] = unitID
                                currentassignablecapacity[unitID] = (currentassignablecapacity[unitID] - 1)
                                -- Spring.Echo(currentassigablecapacity[unitID])
                                passengermovingtoload[cUnitID] = true
                                spGiveOrderToUnit(cUnitID, CMD_MOVE, {tx,ty,tz}, {})
                                --							Spring.GiveOrderToUnit(unitID, CMD_WAIT, {}, {})
                            end
                        end
                    end
                end
                ------------------------------------MOBILE----------------------------------------------------
            else
                -- else, it is mobile
                --transportmovingtoload[unitID] = true -- the transporter will receive a move order anyway
                transportmovingtoload[unitID] = spGetGameFrame()+1     -- start tracking it in n frames
                -- load single unit
                if r == nil then
                    local xUnitDefID = spGetUnitDefID(x)
                    local xTeam = spGetUnitTeam(x)
                    if canBeTransported(xUnitDefID)
                            and xTeam == MyTeam and currentassignablecapacity[unitID] > 0
                            and not unitisintransport[x] and loadtheseunits[x] == nil then
                        loadtheseunits[x] = unitID
                        currentassignablecapacity[unitID] = currentassignablecapacity[unitID] - 1
                        --Spring.Echo("New current assignablecapacity: "..currentassignablecapacity[unitID])
                        passengermovingtoload[x] = true
                        local px, py, pz = spGetUnitPosition(x) -- passenger position
                        queuedMoveCommands[#queuedMoveCommands+1] = { unitID=unitID,
                                                                      shift=cmdOptions.shift,
                                                                      pos={x=px,y=py,z=pz}
                        }
                        --if cmdOptions.shift then
                        --    spGiveOrderToUnit(unitID, CMD_INSERT, {-1, CMD_MOVE, CMD_OPT_INTERNAL, px,py,pz }, {"alt"} )
                        --else
                        --    spGiveOrderToUnit(unitID, CMD_MOVE, {px,py,pz}, {})
                        --end
                    end
                else -- load multiple units
                    local UnitsAroundCommand = spGetUnitsInCylinder(x,z,r)
                    --GiveOrderToUnit(unitID,CMD_INSERT,{-1,CMD_CAPTURE,CMD_OPT_INTERNAL+1,unitID2},{"alt"});
                    --GiveOrderToUnit(unitID,CMD_INSERT,{cmd.tag,CMD_CAPTURE,CMD_OPT_INTERNAL+1,unitID2},{});
                    --GiveOrderToUnit(unitID,CMD_INSERT,{0,CMD_STOP,0},{"alt"});
                    queuedMoveCommands[#queuedMoveCommands+1] = { unitID=unitID,
                                                                  shift=cmdOptions.shift,
                                                                  pos={x=x,y=y,z=z}
                                                                }
                    for _,cUnitID in ipairs(UnitsAroundCommand) do -- check all units in transport pick-up >c<ircle
                        local cTeam = spGetUnitTeam(cUnitID)
                        if (cUnitID ~= unitID) and (cTeam == MyTeam) then
                            local cUnitDefID = spGetUnitDefID(cUnitID)
                            if canBeTransported(cUnitDefID)
                                    and currentassignablecapacity[unitID] > 0
                                    and unitisintransport[cUnitID] == false
                                    and loadtheseunits[cUnitID] == nil then
                                loadtheseunits[cUnitID] = unitID
                                currentassignablecapacity[unitID] = currentassignablecapacity[unitID] - 1
                                -- Spring.Echo(currentassigablecapacity[unitID])
                                passengermovingtoload[cUnitID] = true
                                spGiveOrderToUnit(unitID, CMD_REMOVE, {CMD_MOVE}, {"alt"})
                                spGiveOrderToUnit(cUnitID, CMD_MOVE, {x,y,z}, {})
                            end
                        end
                    end
                end
            end
            return true
        else
            return false end
    end

    return true

end

function gadget:UnitIdle(unitID, unitDefID, unitTeam)
    for mpUnitID, _ in pairs(passengermovingtoload) do -- remove arrived passengers
        if (unitID == mpUnitID) then
            passengermovingtoload[mpUnitID] = false	-- passenger arrived at pick-up point or was stopped
        end
    end
    for mtUnitID, _ in pairs(transportmovingtoload) do -- remove arrived passengers
        if (unitID == mtUnitID) then
            transportmovingtoload[mtUnitID] = nil	-- transport arrived at pick-up point or was stopped
        end
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, team, attacker)
    local transporterID = loadtheseunits[unitID]
    if transporterID then
        currentassignablecapacity[transporterID] = (currentassignablecapacity[transporterID] + 1)	-- remove dead unit from assigned units list
        -- Spring.Echo(currentassigablecapacity[transporterID])
    end
    loadtheseunits[unitID] = nil
    transportstounload[unitID] = nil
    passengermovingtoload[unitID] = nil
    for pUnitID, tunitID in pairs(loadtheseunits) do	-- check if transporter was killed
        if (unitID == tunitID) then
            loadtheseunits[pUnitID] = nil
            transportmovingtoload[unitID] = nil
        end
    end
end

local function ShowUnit (unitID, enable)
    Spring.SetUnitNoDraw (unitID, not enable)
    Spring.SetUnitNoSelect (unitID, not enable)
    Spring.SetUnitNoMinimap (unitID, not enable)
    return
end

function gadget:UnitLoaded(unitID, unitDefID, unitTeam, transportID, transportTeam)
    unitisintransport[unitID] = true
    if passengers[transportID] == nil then
        passengers[transportID] = {}
    end
    table.insert(passengers[transportID], unitID)
    if currenttransportcapacity[transportID] then
        currenttransportcapacity[transportID] = currenttransportcapacity[transportID] - 1
    else
        --Spring.Echo("current transport capacity not initialized for "..transportID)
    end
end

function gadget:UnitUnloaded(unitID, unitDefID, unitTeam, transportID, transportTeam)
    unitisintransport[unitID] = false
    if not currenttransportcapacity[transportID] or not currentassignablecapacity[transportID] then
        --Spring.Echo("Warning: Transport info was not initialized")
        return
    end
    currenttransportcapacity[transportID] = (currenttransportcapacity[transportID] + 1)
    currentassignablecapacity[transportID] = (currentassignablecapacity[transportID] + 1)

    ipairs_remove(passengers[transportID], unitID)

    local ttu = transportstounload[transportID]   --transport to unload

    if not ttu then
        --Spring.Echo("no ttu - transport to unload")
        return
    else
        --Spring.Echo("Has transport to unload")
    end

    --Spring.SetUnitPosition ( unitID, ttu.x, ttu.z )
    --Spring.Echo("Unload registered, assignable capacity: "..currentassignablecapacity[transportID])
    ShowUnit(unitID, false)
    -- We have to the move control by 10 frames after unload, or else it twitches and fails.
    -- PS.: This was found by shameless trial and error. No idea if it's an engine bug or expected behavior.
    queueMovePassengers[#queueMovePassengers +1]={ unitID = unitID, frame = spGetGameFrame()+10,
                                                   clickPos = { x = ttu.x, y = ttu.y, z = ttu.z, r = ttu.r }}
    transportstounload[transportID] = nil
end

function gadget:GameFrame(f)
    for i, data in ipairs(queueMovePassengers) do
        local unitID = tonumber(data.unitID)
        local frame = tonumber(data.frame)
        local clickPos = data.clickPos
        if f >= frame then
            --Spring.Echo("showing")
            local px, py, pz = spGetUnitPosition(unitID)
            --Spring.SetUnitPosition ( unitID, px, pz )
            --Spring.Echo("Moving: "..unitID)
            mcEnable(unitID)
            mcSetPosition( unitID, px, clickPos.y, pz ) -- clickPos.y || px
            mcDisable(unitID)
            ShowUnit(unitID, true)
            table.remove(queueMovePassengers, i)
        end
    end

    if f % 2 < .1 then
        for transpUID, clickPos in pairs(transportstounload) do
            local tx, ty, tz = spGetUnitPosition(transpUID)
            local transportuDef = UnitDefs[spGetUnitDefID(transpUID)]
            local minUnloadDistance = tonumber(transportuDef.loadingRadius) / 2 or 150
            local distance = math.sqrt(sqr(tx-clickPos.x) + sqr(ty-clickPos.y) + sqr(tz- clickPos.z))
            --Spring.Echo("current/min: "..distance.." / "..minUnloadDistance)
            if distance <= minUnloadDistance then
                -- actually unload all (for now) units
                --TODO: check if it's a ground transport, use spUnitDetach then
                --TODO: Disable unit collisions, if needed ( Spring.SetUnitLoadingTransport(passengerID, transportID) )
                if passengers[transpUID] and passengers[transpUID][1] then
                    local passengerUID = passengers[transpUID][1]
                    --Spring.Echo("Detaching passenger ID: " ..passengerUID)
                    --UnitDetachFromAir
                    spSetUnitLoadingTransport(passengerUID, transpUID)
                    spUnitDetach(passengerUID)   -- Test: only one for now   --TODO: go across all units in the table

                    --Spring.MoveCtrl.SetGroundOffset(passengerUID, -20)
                    --mcDisable(passengerUID)
                    --ipairs_remove(unloadtheseunits[transpUID], passengerUID)
                end
            end
        end
    end

    --if f % 32 > .1 then     -- Run below code every 32 frames
    --   end

    for passengerUID, transpUID in pairs(loadtheseunits) do
        local x, y, z = spGetUnitPosition(transpUID) -- transport position
        local transportuDef = UnitDefs[spGetUnitDefID(transpUID)]
        --local transportcapacity = transportuDef.transportCapacity
        local loadingradius = tonumber(transportuDef.loadingRadius) or 300
        local UnitsAroundTransport = spGetUnitsInCylinder(x,z,loadingradius)
        for _, thisuID in ipairs(UnitsAroundTransport) do
            local thisUDID = spGetUnitDefID(thisuID)
            if thisuID == passengerUID and canBeTransported(thisUDID) then
                -- Actually "load" the unit:
                --Spring.GetUnitPieceMap ( number unitID ) -> { "piecename1" = pieceNum1, ... , "piecenameN" = pieceNumN }
                spUnitAttach(transpUID, passengerUID, 0)          -- Currently only attach to the 'root' object
                spSetUnitLoadingTransport(transpUID, thisuID)
                loadtheseunits[passengerUID] = nil
                --if (Spring.UnitScript.GetScriptEnv(unitID) == nil) then -- cob/bos compatibility
                --    Spring.CallCOBScript( unitID, "TransportPickup", pUnitID)
                --else
                --    Spring.UnitScript.CallAsUnit(unitID,(Spring.UnitScript.GetScriptEnv(unitID).script.TransportPickup),pUnitID)
                --end
                local pud = UnitDefs[spGetUnitDefID(passengerUID)]
                local prepairSpeed = pud.repairSpeed
                if (prepairSpeed > 0) then -- builder units will automatically repair the transport / bunker
                    spGiveOrderToUnit(passengerUID, CMD_GUARD, { transpUID }, {})
                end
            end
        end
        -- check if passengers AND transport are still on the run, if not remove from pick-up list
        local transporterID = loadtheseunits[passengerUID]
        local assignablecapacity = currentassignablecapacity[transporterID]
        if not passengermovingtoload[passengerUID]
                and not transportmovingtoload[transporterID]
                and assignablecapacity then
            currentassignablecapacity[transporterID] = assignablecapacity + 1
            -- Spring.Echo(currentassigablecapacity[transporterID])
            loadtheseunits[passengerUID] = nil
        end
    end

    for i, data in ipairs(queuedMoveCommands) do
        local unitID = tonumber(data.unitID)
        local shift = data.shift
        local x,y,z = tonumber(data.pos.x), tonumber(data.pos.y), tonumber(data.pos.z)
        if shift then
            --Spring.Echo("Has Shift")
            spGiveOrderToUnit(unitID, CMD_INSERT, {-1, CMD_MOVE, CMD_OPT_INTERNAL, x,y,z }, {"alt"} )
        else
            spGiveOrderToUnit(unitID, CMD_MOVE, {x,y,z}, {})
        end
        table.remove(queuedMoveCommands, i)
    end
end

--------------------------------------------------------------------------------
--endregion  END SYNCED
--------------------------------------------------------------------------------
else
--------------------------------------------------------------------------------
--region  UNSYNCED
--------------------------------------------------------------------------------

local morphUnits

local spGetGameFrame = Spring.GetGameFrame
local glBlending = gl.Blending
local glDepthTest = gl.DepthTest
local glPushMatrix     = gl.PushMatrix
local glPopMatrix      = gl.PopMatrix
local glTranslate      = gl.Translate
local glBlending       = gl.Blending
local glDepthTest      = gl.DepthTest
local glBillboard      = gl.Billboard
local glColor          = gl.Color
local glText           = gl.Text
local GL_LEQUAL        = GL.LEQUAL
local GL_ONE           = GL.ONE
local GL_SRC_ALPHA     = GL.SRC_ALPHA
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
local spGetLocalTeamID = Spring.GetLocalTeamID
local spGetUnitTeam    = Spring.GetUnitTeam
local GetSpectatingState = Spring.GetSpectatingState
local spGetUnitViewPosition = Spring.GetUnitViewPosition
local spIsUnitInView = Spring.IsUnitInView
local UItextColor = {1.0, 1.0, 0.6, 1.0}
local UItextSize = 14.0

local snext = snext

function gadget:DrawWorld()
    if not snext(SYNCED.currentassignablecapacity) then
        return --//no transports to draw
    end

    glBlending(GL_SRC_ALPHA, GL_ONE)
    glDepthTest(GL_LEQUAL)

    --- [BEGIN] Draw Transports current assignable capacity
    --Spring.Echo("Len: "..pairs_len(SYNCED.currentassignablecapacity))
    local localTeam = spGetLocalTeamID()
    for unitID, capacity in pairsByKeys(SYNCED.currentassignablecapacity) do
        --local capacity = SYNCED.currentassignablecapacity[unitID]
        if spIsUnitInView(unitID) and spGetUnitTeam(unitID) == localTeam then
            local ux, uy, uz = spGetUnitViewPosition(unitID)
            glPushMatrix()
            glTranslate(ux, uy, uz)
            glBillboard()
            glColor(UItextColor)
            glText("Capacity Remaining: " .. capacity, 0.0, -50.0, UItextSize, "cno")
            glPopMatrix()
        end
    end
    --- [END] Draw Transports current assignable capacity

    glDepthTest(false)
    glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

    --TODO: WIP, assign click pos to synced events (if needed)
    --local mx, my = Spring.GetMouseState()
    --local _, pos = Spring.TraceScreenRay(mx, my, true)
    --if pos then
    --
    --end
end

--------------------------------------------------------------------------------
--endregion  END UNSYNCED
--------------------------------------------------------------------------------
end