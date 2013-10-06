--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
    return {
        name      = "Obedient constructors",
        desc      = "Cancel constructor's orders when it has a fight order and new order given",
        author    = "[teh]decay",
        date      = "5 oct 2013",
        license   = "GNU GPL, v2 or later",
        version   = 2,
        layer     = 5,
        enabled   = true --  loaded by default?
    }
end

-- project page on github: https://github.com/jamerlan/unit_obedient_constructors

--Changelog
-- v2 [teh]decay - fixed bug when only one constructor executes order


local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetMyTeamId = Spring.GetMyTeamID
local spGetTeamUnits = Spring.GetTeamUnits
local spGetUnitDefID = Spring.GetUnitDefID
local spGetSelectedUnits = Spring.GetSelectedUnits
local spGetCommandQueue = Spring.GetCommandQueue

local spFightCMD = CMD.FIGHT
local spGuardCMD = CMD.GUARD

-------------------------------------------------------------------------------
function widget:CommandNotify(id, params, options)
    local units = spGetSelectedUnits()

    for i, unit_id in ipairs(units) do
        local commands = spGetCommandQueue(unit_id)
--        Spring.Echo("cmds:" .. table.tostring(commands))
--        Spring.Echo("cmds size:" .. #commands)
--        Spring.Echo("")

        local containsFightOrder = false

        for i, command in ipairs(commands) do
            if command.id == spFightCMD or command.id == spGuardCMD then
                containsFightOrder = true
            end
        end

        local unitDefID = Spring.GetUnitDefID(unit_id)
        local ud = UnitDefs[unitDefID]
        if containsFightOrder and UnitDefs[unitDefID]["canReclaim"] and not ud.isFactory then
            local options2 = {}
--            if options.shift then options2[#options2+1] = 'shift' end
            if options.alt then options2[#options2+1] = 'alt' end
            if options.ctrl then options2[#options2+1] = 'ctrl' end
            if options.right then options2[#options2+1] = 'right' end
            if options.meta then options2[#options2+1] = 'meta' end
            spGiveOrderToUnit(unit_id, id, params, options2)
        else
            local options2 = {}
            for option, enabled in pairs(options) do if enabled then options2[#options2+1] = tostring(option) end end
            spGiveOrderToUnit(unit_id, id, params, options2)
        end
    end

    return true
end

function widget:PlayerChanged(playerID)
    local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
    if spec then
        widgetHandler:RemoveWidget()
        return false
    end
end


function widget:Initialize()
    local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
    if spec then
        widgetHandler:RemoveWidget()
        return false
    end

    return true
end

--------------------------------------------------------------------------------
function table.val_to_str ( v )
    if "string" == type( v ) then
        v = string.gsub( v, "\n", "\\n" )
        if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
            return "'" .. v .. "'"
        end
        return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
    else
        return "table" == type( v ) and table.tostring( v ) or
                tostring( v )
    end
end

function table.key_to_str ( k )
    if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
        return k
    else
        return "[" .. table.val_to_str( k ) .. "]"
    end
end

function table.tostring( tbl )
    local result, done = {}, {}
    for k, v in ipairs( tbl ) do
        table.insert( result, table.val_to_str( v ) )
        done[ k ] = true
    end
    for k, v in pairs( tbl ) do
        if not done[ k ] then
            table.insert( result,
                table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
        end
    end
    return "{" .. table.concat( result, "," ) .. "}"
end
