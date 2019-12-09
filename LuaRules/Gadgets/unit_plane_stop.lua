function gadget:GetInfo()
    return {
        name      = "Plane Stop",
        desc      = "Fighters and Bombers set to flight mode freeze mid-air when stopped",
        author    = "MaDDoX",
        date      = "6 Dec 2019",
        license   = "GNU GPL, v2 or later",
        layer     = 0,
        enabled   = true  --  loaded by default?
    }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (not gadgetHandler:IsSyncedCode()) then
    return
end

VFS.Include("gamedata/taptools.lua")

local EditUnitCmdDesc = Spring.EditUnitCmdDesc
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spGetUnitCmdDescs = Spring.GetUnitCmdDescs
local spGetUnitDefID = Spring.GetUnitDefID
local InsertUnitCmdDesc = Spring.InsertUnitCmdDesc
local GiveOrderToUnit = Spring.GiveOrderToUnit
local SetUnitNeutral = Spring.SetUnitNeutral

local trackedUnits = {
    -- [UnitDefNames["armfig"].id] = true,
    -- [UnitDefNames["corveng"].id] = true,
    -- [UnitDefNames["armthund"].id] = true,
    -- [UnitDefNames["corshad"].id] = true,
    -- [UnitDefNames["armhawk"].id] = true,
    -- [UnitDefNames["corvamp"].id] = true,
    -- [UnitDefNames["armpnix"].id] = true,
    -- [UnitDefNames["armaap"].id] = true,
    -- [UnitDefNames["armplat"].id] = true
}

local planes = {}
local planesToPause, pausedPlanes, planesToUnpause = {}, {}, {}
local planeDestinations = {}

local CMD_STOP = CMD.STOP
local CMD_MOVE = CMD.MOVE
local CMD_IDLEMODE = CMD.IDLEMODE

--TODO: Check if spawning (by group) fires UnitFinished, if not enable this
--function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
--end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    planes[unitID] = nil
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if trackedUnits[unitDefID] then
        local uDefID = spGetUnitDefID(unitID)
        local uDef = UnitDefs[uDefID]
        planes[unitID] = uDef
        Spring.Echo("Alt: "..tostring(uDef.wantedHeight))
        --GiveOrderToUnit(unitID, CMD.IDLEMODE, { planes[builderID].landAt }, { })
    end
end

local function isSetToFly(unitID)
    local cmdIdleModeId = spFindUnitCmdDesc(unitID, CMD_IDLEMODE)
    if not cmdIdleModeId then
        return false end
    local cmdIdleModeDesc = spGetUnitCmdDescs(unitID, cmdIdleModeId, cmdIdleModeId)[1]
    if istable(cmdIdleModeDesc.params) then
        return cmdIdleModeDesc.params[1] == "0"    -- If equal "0" ==> Fly
    else
        return false end
end

function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
    local planeuDefID = planes[unitID]
    if planeuDefID then
        --DebugTable(cmdOptions)
        if cmdID == CMD_MOVE then
            --for i = 1, #cmdParams do
            --  Spring.Echo("   param "..i..": "..cmdParams[i])
            --end
            planeDestinations[unitID] = { x = cmdParams[1], y = cmdParams[2], z = cmdParams[3]}
        end
        if cmdID == CMD_STOP and not cmdOptions.shift then --TODO: And flyState == fly
            if isSetToFly(unitID) and not pausedPlanes[unitID] then
                local x, y, z = Spring.GetUnitPosition(unitID)
                local velx, vely, velz= Spring.GetUnitVelocity(unitID)
                planesToPause[unitID] = { wantedHeight = planeuDefID.wantedHeight,
                                          targetPos = { x = x, y = y, z = z },
                                          sourceVel = { x = velx, y = vely, z = velz }
                                        }
            else
                if pausedPlanes[unitID] then
                    planesToUnpause[unitID] = planeuDefID end
            end
        else
            if pausedPlanes[unitID] then
                planesToUnpause[unitID] = planeuDefID end
        end
    end
    return true
end

local function sign(num)
    return num/math.abs(num)
end

function gadget:GameFrame(f)
    --if f%20 > 0.001 then
    --    return end
    for unitID, data in pairs(planesToPause) do
        --planesToPause[unitID] = nil
        --Spring.Echo("Pausing Plane: "..tostring(unitID))
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxAcc", 0)
        --        Spring.MoveCtrl.SetAirMoveTypeData(unitID, "myGravity", 0)
        --local x,y,z=Spring.GetUnitVectors(unitID)
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxPitch", 0)
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxElevator", 0)
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxRudder", 0)
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxAileron", 0)
        local posx, posy, posz = Spring.GetUnitPosition(unitID)
        --        local velx, vely, velz= Spring.GetUnitVelocity(unitID)
        --        local currentAlt = posy - Spring.GetGroundHeight(posx, posz)
        local relativeHeight = Spring.GetGroundHeight(posx, posz) + data.wantedHeight
        --           Spring.SetUnitVelocity(unitID, 0, vely + sign(wantedAlt - currentAlt), 0)
        --Spring.SetUnitVelocity(unitID, math.random(-0.5,0.5), 0, math.random(-0.5,0.5))
        --Spring.SetUnitVelocity(unitID, 0, 0, 0)
        --local dirx, diry, dirz = Spring.GetUnitDirection(unitID)
        --local h = math.asin(-dirx / math.sqrt(dirx*dirx + dirz*dirz))
            --local rotx, roty, rotz = Spring.GetUnitRotation(unitID)
        local targetRotY = roty
        local dest = planeDestinations[unitID]
        if dest then
            --rotx = math.deg(math.atan2(px, pz))
                --roty = math.deg(math.atan2(px, pz))
            --rotz = math.deg(math.atan2(py, px))
                --local dirx, dirz = dest.x - posx, dest.z - posz
                --        --targetRotY = math.asin(-dirx / math.sqrt(dirx*dirx + dirz*dirz))
                --targetRotY = math.atan2(dirz, dirx) --|| todeg => * 180 / math.pi
            --targetRotY = math.max(-2.5, (math.min(2.5, targetRotY)))
                --Spring.Echo("rot Y: "..dy.." target rot Y: "..py)
            local rx, ry, rz = Spring.GetUnitRotation(unitID)       -- source Direction
            local px, py, pz = dest.x - posx, dest.y - posy, dest.z - posz
            Spring.SetUnitDirection(unitID, px, py, pz)             -- apply target Direction
            local trx, try, trz = Spring.GetUnitRotation(unitID)    -- read back target Rotation
            Spring.SetUnitRotation(unitID, lerp(rx, trx, 0.1), lerp(ry, try, 0.1), lerp(rz, trz, 0.1))
        end
            --Spring.SetUnitRotation(unitID, 0, targetRotY, 0)
                --Spring.SetUnitRotation(unitID, rotx, roty, rotz)
        --Spring.SetUnitRotation(unitID, lerp(rotx, 0, 0.1),
        --        --roty,
        --        lerp(roty, targetRotY, 0.1),
        --        lerp(rotz, 0, 0.1))

        Spring.MoveCtrl.Enable(unitID)
        Spring.MoveCtrl.SetPosition(unitID, lerp(posx, data.targetPos.x + data.sourceVel.x * 10, 0.1),
                lerp(posy, relativeHeight, 0.025),
                lerp(posz, data.targetPos.z + data.sourceVel.z * 10, 0.1))

        ----if math.abs(currentAlt - wantedAlt) > 10 then
        ----    --Spring.SetUnitVelocity(unitID, velx, vely +sign(wantedAlt - currentAlt), velz)
        ----end
        --
        --if diry > 0 then
        --end
        pausedPlanes[unitID] = true
    end
    for unitID, uDef in pairs(planesToUnpause) do
        Spring.MoveCtrl.Disable(unitID)
        planesToPause[unitID] = nil
        planesToUnpause[unitID] = nil
        pausedPlanes[unitID] = nil

        Spring.Echo("Unpausing Plane: "..tostring(unitID))
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "maxAcc", uDef.maxAcc)
        --Spring.MoveCtrl.SetAirMoveTypeData(unitID, "myGravity", uDef.myGravity)
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--function gadget:GetInfo()
--    return {
--        name = "Zeppelin Physics",
--        desc = "Forces Zeppelin-type units to obey their cruisealt and prevents them from pitching",
--        author = "Анархид",
--        date = "2.2.2009",
--        license = "None",
--        layer = 50,
--        enabled = true
--    }
--end

zeppelinuDefs ={}
zeppelin={}

--SYNCED
--if (gadgetHandler:IsSyncedCode()) then
--
--    function gadget:Initialize()
--        for id,unitDef in pairs(UnitDefs) do
--            if unitDef.myGravity == 0 and
--                    unitDef.maxElevator == 0 then
--                Spring.Echo(unitDef.name.." is a zeppelin with cruisealt "..unitDef.wantedHeight)
--                zeppelinuDefs[id]={
--                    pitch=unitDef.maxPitch,
--                    alt=unitDef.wantedHeight,
--                    name= unitDef.name,
--                }
--            end
--        end
--    end
--
--    function gadget:UnitCreated(UnitID, whatever)
--        local uDefID = Spring.GetUnitDefID(UnitID);
--        if zeppelinuDefs[uDefID] then
--            zeppelin[UnitID]= uDefID
--        end
--    end
--
--    function gadget:UnitDestroyed(UnitID, whatever)
--        local uDefID = Spring.GetUnitDefID(UnitID);
--        if zeppelinuDefs[uDefID] then
--            zeppelin[UnitID]=nil
--        end
--    end
--
--    local function sign(num)
--        return num/math.abs(num)
--    end
--
--    function gadget:GameFrame(f)
--        if f%20<1 then
--            for unitID, uDefID in pairs(zeppelin) do
--                local x,y,z=Spring.GetUnitVectors(unitID)
--                local ux, uy, uz= Spring.GetUnitPosition(unitID)
--                local vx, vy, vz= Spring.GetUnitVelocity(unitID)
--                local dirx, diry, dirz = Spring.GetUnitDirection(unitID)
--                local altitude = uy - Spring.GetGroundHeight(ux,uz)
--                local wanted= zeppelinuDefs[uDefID].alt
--                if math.abs(altitude-wanted)>10 then
--                    Spring.SetUnitVelocity(unitID, vx, vy+sign(wanted-altitude), vz)
--                end
--
--                if diry>0 then
--                    local h = math.asin(-dirx / math.sqrt(dirx*dirx + dirz*dirz))
--                    Spring.SetUnitRotation(unitID,0,h,0)
--                end
--            end--for
--        end--iff
--    end--fn
--
--end--sync