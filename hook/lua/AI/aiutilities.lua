WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset ATUtils.lua' )

SCTAGetTransports = GetTransports
TASetupCheat = SetupCheat
function GetTransports(platoon, units)
    local aiBrain = platoon:GetBrain()
    if not aiBrain.SCTAAI then
        return SCTAGetTransports(platoon, units)
    end
    if not units then
        units = platoon:GetPlatoonUnits()
    end

    -- Check for empty platoon
    if table.getn(units) == 0 then
        return 0
    end

    local neededTable = GetNumTransports(units)
    local transportsNeeded = false
    if neededTable.Small > 0 or neededTable.Medium > 0 or neededTable.Large > 0 then
        transportsNeeded = true
    end


    local aiBrain = platoon:GetBrain()
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')

    -- Make sure more are needed
    local tempNeeded = {}
    tempNeeded.Small = neededTable.Small
    tempNeeded.Medium = neededTable.Medium
    tempNeeded.Large = neededTable.Large

    local location = platoon:GetPlatoonPosition()
    if not location then
        -- We can assume we have at least one unit here
        location = units[1]:GetCachePosition()
    end

    if not location then
        return 0
    end

    -- Determine distance of transports from platoon
    local transports = {}
    for _, unit in pool:GetPlatoonUnits() do
        if not unit.Dead and EntityCategoryContains(categories.TRANSPORTFOCUS, unit) and not unit:IsUnitState('Busy') and not unit:IsUnitState('TransportLoading') and table.getn(unit:GetCargo()) < 1 and unit:GetFractionComplete() == 1 then
            local unitPos = unit:GetPosition()
            local curr = {Unit = unit, Distance = VDist2(unitPos[1], unitPos[3], location[1], location[3]),
                           Id = unit.UnitId}
            table.insert(transports, curr)
        end
    end

    local numTransports = 0
    local transSlotTable = {}
    if table.getn(transports) > 0 then
        local sortedList = {}
        -- Sort distances
        for k = 1, table.getn(transports) do
            local lowest = -1
            local key, value
            for j, u in transports do
                if lowest == -1 or u.Distance < lowest then
                    lowest = u.Distance
                    value = u
                    key = j
                end
            end
            sortedList[k] = value
            -- Remove from unsorted table
            table.remove(transports, key)
        end

        -- Take transports as needed
        for i = 1, table.getn(sortedList) do
            if transportsNeeded and table.getn(sortedList[i].Unit:GetCargo()) < 1 and not sortedList[i].Unit:IsUnitState('TransportLoading') then
                local id = sortedList[i].Id
                aiBrain:AssignUnitsToPlatoon(platoon, {sortedList[i].Unit}, 'Scout', 'GrowthFormation')
                numTransports = numTransports + 1
                if not transSlotTable[id] then
                    transSlotTable[id] = GetNumTransportSlots(sortedList[i].Unit)
                end
                local tempSlots = {}
                tempSlots.Small = transSlotTable[id].Small
                tempSlots.Medium = transSlotTable[id].Medium
                tempSlots.Large = transSlotTable[id].Large
                -- Update number of slots needed
                while tempNeeded.Large > 0 and tempSlots.Large > 0 do
                    tempNeeded.Large = tempNeeded.Large - 1
                    tempSlots.Large = tempSlots.Large - 1
                    tempSlots.Medium = tempSlots.Medium - 2
                    tempSlots.Small = tempSlots.Small - 4
                end
                while tempNeeded.Medium > 0 and tempSlots.Medium > 0 do
                    tempNeeded.Medium = tempNeeded.Medium - 1
                    tempSlots.Medium = tempSlots.Medium - 1
                    tempSlots.Small = tempSlots.Small - 2
                end
                while tempNeeded.Small > 0 and tempSlots.Small > 0 do
                    tempNeeded.Small = tempNeeded.Small - 1
                    tempSlots.Small = tempSlots.Small - 1
                end
                if tempNeeded.Small <= 0 and tempNeeded.Medium <= 0 and tempNeeded.Large <= 0 then
                    transportsNeeded = false
                end
            end
        end
    end

    if transportsNeeded then
        ReturnTransportsToPool(platoon:GetSquadUnits('Scout'), false)
        return false, tempNeeded.Small, tempNeeded.Medium, tempNeeded.Large
    else
        platoon.UsingTransport = true
        return numTransports, 0, 0, 0
    end
end

function SCTAEngineerMoveWithSafePath(aiBrain, unit, destination)
    if not destination then
        return false
    end

    local result, bestPos = false
    result, bestPos = AIAttackUtils.CanGraphTo(unit, destination, 'Land')
    if not result then
        result, bestPos = AIAttackUtils.CanGraphTo(unit, destination, 'Amphibious')
        if not result and not SUtils.CheckForMapMarkers(aiBrain) then
            result, bestPos = unit:CanPathTo(destination)
        end
    end

    local pos = unit:GetPosition()
    -- If we're here, we haven't used transports and we can path to the destination
    if result then
        if EntityCategoryContains(categories.AMPHIBIOUS, unit) then
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Air', unit:GetPosition(), destination, 10)
        if path then
            local pathSize = table.getn(path)
            -- Move to way points (but not to destination... leave that for the final command)
            for widx, waypointPath in path do
                if pathSize ~= widx then
                    IssueMove({unit}, waypointPath)
                end
            end
        end
        -- If there wasn't a *safe* path (but dest was pathable), then the last move would have been to go there directly
        -- so don't bother... the build/capture/reclaim command will take care of that after we return
        return true
        end
    else
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Amphibious', unit:GetPosition(), destination, 10)
        if path then
            local pathSize = table.getn(path)
            -- Move to way points (but not to destination... leave that for the final command)
            for widx, waypointPath in path do
                if pathSize ~= widx then
                    IssueMove({unit}, waypointPath)
                end
            end
        end
        -- If there wasn't a *safe* path (but dest was pathable), then the last move would have been to go there directly
        -- so don't bother... the build/capture/reclaim command will take care of that after we return
        return true
    end
    return false
end

function SCTAEngineerMoveWithSafePathAir(aiBrain, unit, destination)
    if not destination then
        return false
    end
    --local PlanName = unit.PlatoonHandle.PlanName
    --LOG('*PlatoonName3', PlanName)
    local result, bestPos = false
    result, bestPos = AIAttackUtils.CanGraphTo(unit, destination, 'Air')
    -- If we're here, we haven't used transports and we can path to the destination
    if result then
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Air', unit:GetPosition(), destination, 10)
        if path then
            local pathSize = table.getn(path)
            -- Move to way points (but not to destination... leave that for the final command)
            for widx, waypointPath in path do
                if pathSize ~= widx then
                    IssueMove({unit}, waypointPath)
                end
            end
        end
        -- If there wasn't a *safe* path (but dest was pathable), then the last move would have been to go there directly
        -- so don't bother... the build/capture/reclaim command will take care of that after we return
        return true
    end

    return false
end

function SCTAEngineerMoveWithSafePathNaval(aiBrain, unit, destination)
    if not destination then
        return false
    end
    local result, bestPos = false
    result, bestPos = AIAttackUtils.CanGraphTo(unit, destination, 'Water')
    if not result and not SUtils.CheckForMapMarkers(aiBrain) then
        result, bestPos = unit:CanPathTo(destination)
    end
    -- If we're here, we haven't used transports and we can path to the destination
    if result then
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Water', unit:GetPosition(), destination, 10)
        if path then
            local pathSize = table.getn(path)
            -- Move to way points (but not to destination... leave that for the final command)
            for widx, waypointPath in path do
                if pathSize ~= widx then
                    IssueMove({unit}, waypointPath)
                end
            end
        end
        -- If there wasn't a *safe* path (but dest was pathable), then the last move would have been to go there directly
        -- so don't bother... the build/capture/reclaim command will take care of that after we return
        return true
    end
    return false
end

function SCTAEngineerMoveWithSafePathLand(aiBrain, unit, destination)
    if not destination then
        return false
    end
    --local PlanName = unit.PlatoonHandle.PlanName
    --LOG('*PlatoonName2', PlanName)
    local result, bestPos = false
    result, bestPos = AIAttackUtils.CanGraphTo(unit, destination, 'Land')
    if not result and not SUtils.CheckForMapMarkers(aiBrain) then
        result, bestPos = unit:CanPathTo(destination)
    end
    local pos = unit:GetPosition()
    local result, bestPos = unit:CanPathTo(destination)

    -- If we're here, we haven't used transports and we can path to the destination
    if result then
        local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Land', pos, destination)
        if path then
            local pathSize = table.getn(path)
            -- Move to way points (but not to destination... leave that for the final command)
            for widx, waypointPath in path do
                if pathSize ~= widx then
                    IssueMove({unit}, waypointPath)
                end
            end
        end
        -- If there wasn't a *safe* path (but dest was pathable), then the last move would have been to go there directly
        -- so don't bother... the build/capture/reclaim command will take care of that after we return
        return true
    end
    return false
end

function SetupCheat(aiBrain, cheatBool)
    if not aiBrain.SCTAAI then
        return TASetupCheat(aiBrain, cheatBool)
    end

    if cheatBool then
        aiBrain.CheatEnabled = true

        local buffDef = Buffs['CheatBuildRate']
        local buffAffects = buffDef.Affects
        buffAffects.BuildRate.Mult = tonumber(ScenarioInfo.Options.BuildMult)

        buffDef = Buffs['CheatIncome']
        buffAffects = buffDef.Affects
        buffAffects.EnergyProduction.Mult = tonumber(ScenarioInfo.Options.CheatMult)
        buffAffects.MassProduction.Mult = tonumber(ScenarioInfo.Options.CheatMult)
        buffAffects.ProductionPerSecondEnergyMax.Mult = tonumber(ScenarioInfo.Options.CheatMult)
        buffAffects.ProductionPerSecondEnergyMin.Mult = tonumber(ScenarioInfo.Options.CheatMult)

        local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        for _, v in pool:GetPlatoonUnits() do
            -- Apply build rate and income buffs
            ApplyCheatBuffs(v)
        end

    end
end