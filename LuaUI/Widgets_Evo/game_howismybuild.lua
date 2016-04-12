----------------------------------------
----------version 1.2----------------
----------------------------------------
    function widget:GetInfo()
      return {
        name      = "How is my build",
        desc      = "Prints info about build timings and income to /LuaUI/Widgets/buildsaves and saves each match.",
        author    = "Tumulten & vvoop",
        date      = "Mar 7, 2014",
        license   = "GNU GPL, v2 or later",
        layer     = 0,
        enabled   = true
      }
    end
     
    local myTeamID = Spring.GetMyTeamID
    local teamResources = Spring.GetTeamResources
    local workingUnits = {}
    local dataArray = {}
    local logDir="LuaUI/Widgets/buildsaves/"
    local file
    local fileName 
     
    function widget:Initialize()
			Spring.CreateDir(logDir);
            fileName = logDir.. Game.mapName.. "_".. tostring(os.date("%Y-%m-%d_%H;%M")) ..".log"
            file = io.open(fileName, "w");
            local header = string.format("%35s%17s%17s%17s%17s",
                    "Name: ", "Start time: ","Finish time: ","Metal income: ","Energy income: ")
            file:write(header.."\n")
            file:write("------------------------------------------------------------------------------------------------------------\n")
			file:close()
    end
     
    function widget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
            if unitTeam == myTeamID() and UnitDefs[unitDefID].isImmobile then
                    local unitTime = getGameTime()
                    local unitM, unitMI = getResource("metal")
                    local unitE, unitEI = getResource("energy")
                    workingUnits[unitID] = { unitTime = getGameTime(), unitM = unitM, unitMI = unitMI, unitE = unitE, unitEI = unitEI }
            end
    end
     
    function widget:UnitFinished(unitID, unitDefID, unitTeam)
            if unitTeam == myTeamID() and UnitDefs[unitDefID].isImmobile then
                    if workingUnits[unitID] ~= nil then
                            local finishTime = formatTime(getGameTime())
                            local finishM, finishMI = getResource("metal")
                            local finishE, finishEI = getResource("energy")
                            local startTime = formatTime(workingUnits[unitID].unitTime)
                            local startM,startMI = workingUnits[unitID].unitM, workingUnits[unitID].unitMI
                            local startE,startEI = workingUnits[unitID].unitE, workingUnits[unitID].unitEI
                            local body = string.format("%35s%17s%17s%17s%17s",
                            UnitDefs[unitDefID].humanName.." ", startTime.." ",finishTime.." ",startMI.." ",startEI.." ")
							file = io.open(fileName, "a");
                            file:write(body.."\n")
                            file:close()
     
                            local oneRow = {name = UnitDefs[unitDefID].humanName, startTime = startTime, finishTime = finishTime, startMI = startMI,startEI = startEI }
                            table.insert(dataArray, oneRow)
                    end            
            end
    end
     
    function getData()
            return dataArray
    end
    function getGameTime()
            local secs = math.floor(Spring.GetGameSeconds())
            return secs
    end
     
    function formatTime(sec)
            return string.format("%.2d:%.2d:%.2d", sec/(60*60), sec/60%60, sec%60)
    end
     
    function getResource(resource)
            local currentLevel, storage, pull, income, expense, share = teamResources(myTeamID(), resource)
            return math.floor(currentLevel), math.floor(income)
    end
     
    function widget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
            workingUnits[unitID]=nil
    end