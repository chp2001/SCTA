local TAutils = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua')
WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset platoon.lua' )

--[[buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
baseTmplDefault = import('/lua/BaseTemplates.lua')
buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]]


SCTAAIPlatoon = Platoon
Platoon = Class(SCTAAIPlatoon) {
    EngineerBuildAISCTA = function(self)
        local aiBrain = self:GetBrain()
        local platoonUnits = self:GetPlatoonUnits()
        local armyIndex = aiBrain:GetArmyIndex()
        local x,z = aiBrain:GetArmyStartPos()
        local cons = self.PlatoonData.Construction
        local buildingTmpl, buildingTmplFile, baseTmpl, baseTmplFile, baseTmplDefault
        local eng
        --LOG('*SCTAEXPANSIONTA', self.PlatoonData.LocationType)
        for k, v in platoonUnits do
            if not v.Dead and EntityCategoryContains(categories.ENGINEER - categories.STATIONASSISTPOD, v) then --DUNCAN - was construction
                IssueClearCommands({v})
                if not eng then
                    eng = v
                else
                    IssueGuard({v}, eng)
                end
            end
        end

        if not eng or eng.Dead then
            coroutine.yield(1)
            self:PlatoonDisband()
            return
        end

        --DUNCAN - added
        if eng:IsUnitState('Building') or eng:IsUnitState('Upgrading') then
           return
        end
            local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
            local factionIndex = cons.FactionIndex or FactionToIndex[eng.factionCategory]

            buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
            baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
            baseTmplDefault = import('/lua/BaseTemplates.lua')
            buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
            baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]
    

        --LOG('*AI DEBUG: EngineerBuild AI ' .. eng.Sync.id)

        if self.PlatoonData.NeedGuard then
            eng.NeedGuard = true
        end

        -------- CHOOSE APPROPRIATE BUILD FUNCTION AND SETUP BUILD VARIABLES --------
        local reference = false
        local refName = false
        local buildFunction
        local closeToBuilder
        local relative
        local baseTmplList = {}

        -- if we have nothing to build, disband!
        if not cons.BuildStructures then
            --[[local pos = self:GetPlatoonPosition()
            local gtime = GetGameTimeSeconds()
        if gtime < 600 then
            local ents = TAutils.TAAIGetReclaimablesAroundLocation(aiBrain, locationType) or {}
            local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
            if ents and econ.MassStorageRatio < 0.5 then
                coroutine.yield(1)
                return self:IdleEngineerSCTA()
            end
            else]]
        coroutine.yield(1)
        self:PlatoonDisband()
        return
        end
        if cons.NearUnitCategory then
            self:SetPrioritizedTargetList('support', {ParseEntityCategory(cons.NearUnitCategory)})
            local unitNearBy = self:FindPrioritizedUnit('support', 'Ally', false, self:GetPlatoonPosition(), cons.NearUnitRadius or 50)
            --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." attempt near: ", cons.NearUnitCategory)
            if unitNearBy then
                reference = table.copy(unitNearBy:GetPosition())
                -- get commander home position
                --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." Near unit: ", cons.NearUnitCategory)
                if cons.NearUnitCategory == 'COMMAND' and unitNearBy.CDRHome then
                    reference = unitNearBy.CDRHome
                end
            else
                reference = table.copy(eng:GetPosition())
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.OrderedTemplate then
            relativeTo = table.copy(eng:GetPosition())
            --LOG('relativeTo is'..repr(relativeTo))
            relative = true
            local tmpReference = aiBrain:FindPlaceToBuild('T2EnergyProduction', 'uab1201', baseTmplDefault['BaseTemplates'][factionIndex], relative, eng, nil, relativeTo[1], relativeTo[3])
            if tmpReference then
                reference = eng:CalculateWorldPositionFromRelative(tmpReference)
            else
                return
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.Wall then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100
            relative = false
            reference = AIUtils.GetLocationNeedingWalls(aiBrain, 200, 4, 'STRUCTURE - WALLS', cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            table.insert(baseTmplList, 'Blank')
            buildFunction = AIBuildStructures.WallBuilder
        elseif cons.NearBasePatrolPoints then
            relative = false
            reference = AIUtils.GetBasePatrolPoints(aiBrain, cons.Location or 'MAIN', cons.Radius or 100)
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            for k,v in reference do
                table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, v))
            end
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
        elseif cons.FireBase and cons.FireBaseRange then
            --DUNCAN - pulled out and uses alt finder
            reference, refName = AIUtils.AIFindFirebaseLocation(aiBrain, cons.LocationType, cons.FireBaseRange, cons.NearMarkerType,
                                                cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType,
                                                cons.MarkerUnitCount, cons.MarkerUnitCategory, cons.MarkerRadius)
            if not reference or not refName then
                self:PlatoonDisband()
                return
            end

        elseif cons.NearMarkerType and cons.ExpansionBase then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100

            if cons.NearMarkerType == 'Expansion Area' then
                reference, refName = AIUtils.AIFindExpansionAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            else
                --DUNCAN - use my alternative expansion finder on large maps below a certain time
                local mapSizeX, mapSizeZ = GetMapSize()
                if GetGameTimeSeconds() <= 780 and mapSizeX > 512 and mapSizeZ > 512 then
                    reference, refName = AIUtils.AIFindFurthestStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    if not reference or not refName then
                        reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                            (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    end
                else
                    reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                end
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            end

            -- If moving far from base, tell the assisting platoons to not go with
            if cons.FireBase or cons.ExpansionBase then
                local guards = eng:GetGuards()
                for k,v in guards do
                    if not v.Dead and v.PlatoonHandle then
                        v.PlatoonHandle:PlatoonDisband()
                    end
                end
            end
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, eng, cons)
            end
            relative = false
            if reference and aiBrain:GetThreatAtPosition(reference , 1, true, 'AntiSurface') > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            --buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
            buildFunction = AIBuildStructures.AIBuildBaseTemplate
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiSurface'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and (cons.NearMarkerType == 'Rally Point' or cons.NearMarkerType == 'Protected Experimental Construction') then
            --DUNCAN - add so experimentals build on maps with no markers.
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if not reference then
                reference = pos
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType then
            --WARN('*Data weird for builder named - ' .. self.BuilderName)
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            if not cons.BaseTemplate and (cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, (cons.ExpansionRadius or 100), cons.ExpansionTypes, nil, cons)
            end
            if reference and aiBrain:GetThreatAtPosition(reference, 1, true) > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        else
            table.insert(baseTmplList, baseTmpl)
            relative = true
            reference = true
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        end
        if cons.BuildClose then
            closeToBuilder = eng
        end
        if cons.BuildStructures[1] == 'T1Resource' or cons.BuildStructures[1] == 'T2Resource' or cons.BuildStructures[1] == 'T3Resource' then
            relative = true
            closeToBuilder = eng
            local guards = eng:GetGuards()
            for k,v in guards do
                if not v.Dead and v.PlatoonHandle and aiBrain:PlatoonExists(v.PlatoonHandle) then
                    v.PlatoonHandle:PlatoonDisband()
                end
            end
        end

        --LOG("*AI DEBUG: Setting up Callbacks for " .. eng.Sync.id)
        self.SetupEngineerCallbacksSCTA(eng)

        -------- BUILD BUILDINGS HERE --------
        for baseNum, baseListData in baseTmplList do
            for k, v in cons.BuildStructures do
                if aiBrain:PlatoonExists(self) then
                    if not eng.Dead then
                        local faction = TAutils.TAGetEngineerFaction(eng)
                        if aiBrain.CustomUnits[v] and aiBrain.CustomUnits[v][faction] then
                            local replacement = SUtils.GetTemplateReplacement(aiBrain, v, faction, buildingTmpl)
                            if replacement then
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, replacement, baseListData, reference, cons.NearMarkerType)
                            else
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                            end
                        else
                            buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                        end
                    else
                        if aiBrain:PlatoonExists(self) then
                            self:PlatoonDisband()
                            return
                        end
                    end
                end
            end
        end

        -- wait in case we're still on a base
        local count = 0
        while not eng.Dead and eng:IsUnitState('Attached') and count < 2 do
            coroutine.yield(60)
            count = count + 1
        end

        if not eng.Dead and not eng:IsUnitState('Building') then
            return self.SCTAProcessBuildCommand(eng, false)
        end
    end,

    EngineerBuildAISCTANaval = function(self)
        local aiBrain = self:GetBrain()
        local platoonUnits = self:GetPlatoonUnits()
        local armyIndex = aiBrain:GetArmyIndex()
        local x,z = aiBrain:GetArmyStartPos()
        local cons = self.PlatoonData.Construction
        local buildingTmpl, buildingTmplFile, baseTmpl, baseTmplFile, baseTmplDefault
        local eng
        --LOG('*SCTAEXPANSIONTA', self.PlatoonData.LocationType)
        for k, v in platoonUnits do
            if not v.Dead and EntityCategoryContains(categories.ENGINEER - categories.STATIONASSISTPOD, v) then --DUNCAN - was construction
                IssueClearCommands({v})
                if not eng then
                    eng = v
                else
                    IssueGuard({v}, eng)
                end
            end
        end

        if not eng or eng.Dead then
            coroutine.yield(1)
            self:PlatoonDisband()
            return
        end

        --DUNCAN - added
        if eng:IsUnitState('Building') or eng:IsUnitState('Upgrading') then
           return
        end
            local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
            local factionIndex = cons.FactionIndex or FactionToIndex[eng.factionCategory]

            buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
            baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
            baseTmplDefault = import('/lua/BaseTemplates.lua')
            buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
            baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]

        --LOG('*AI DEBUG: EngineerBuild AI ' .. eng.Sync.id)

        if self.PlatoonData.NeedGuard then
            eng.NeedGuard = true
        end

        -------- CHOOSE APPROPRIATE BUILD FUNCTION AND SETUP BUILD VARIABLES --------
        local reference = false
        local refName = false
        local buildFunction
        local closeToBuilder
        local relative
        local baseTmplList = {}

        -- if we have nothing to build, disband!
        if not cons.BuildStructures then
            --[[local pos = self:GetPlatoonPosition()
            local gtime = GetGameTimeSeconds()
        if gtime < 600 then
            local ents = TAutils.TAAIGetReclaimablesAroundLocation(aiBrain, locationType) or {}
            local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
            if ents and econ.MassStorageRatio < 0.5 then
                coroutine.yield(1)
                return self:IdleEngineerSCTA()
            end
            else]]
        coroutine.yield(1)
        self:PlatoonDisband()
        return
        end
        if cons.NearUnitCategory then
            self:SetPrioritizedTargetList('support', {ParseEntityCategory(cons.NearUnitCategory)})
            local unitNearBy = self:FindPrioritizedUnit('support', 'Ally', false, self:GetPlatoonPosition(), cons.NearUnitRadius or 50)
            --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." attempt near: ", cons.NearUnitCategory)
            if unitNearBy then
                reference = table.copy(unitNearBy:GetPosition())
                -- get commander home position
                --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." Near unit: ", cons.NearUnitCategory)
                if cons.NearUnitCategory == 'COMMAND' and unitNearBy.CDRHome then
                    reference = unitNearBy.CDRHome
                end
            else
                reference = table.copy(eng:GetPosition())
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.OrderedTemplate then
            relativeTo = table.copy(eng:GetPosition())
            --LOG('relativeTo is'..repr(relativeTo))
            relative = true
            local tmpReference = aiBrain:FindPlaceToBuild('T2EnergyProduction', 'uab1201', baseTmplDefault['BaseTemplates'][factionIndex], relative, eng, nil, relativeTo[1], relativeTo[3])
            if tmpReference then
                reference = eng:CalculateWorldPositionFromRelative(tmpReference)
            else
                return
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.Wall then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100
            relative = false
            reference = AIUtils.GetLocationNeedingWalls(aiBrain, 200, 4, 'STRUCTURE - WALLS', cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            table.insert(baseTmplList, 'Blank')
            buildFunction = AIBuildStructures.WallBuilder
        elseif cons.NearBasePatrolPoints then
            relative = false
            reference = AIUtils.GetBasePatrolPoints(aiBrain, cons.Location or 'MAIN', cons.Radius or 100)
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            for k,v in reference do
                table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, v))
            end
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
        elseif cons.FireBase and cons.FireBaseRange then
            --DUNCAN - pulled out and uses alt finder
            reference, refName = AIUtils.AIFindFirebaseLocation(aiBrain, cons.LocationType, cons.FireBaseRange, cons.NearMarkerType,
                                                cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType,
                                                cons.MarkerUnitCount, cons.MarkerUnitCategory, cons.MarkerRadius)
            if not reference or not refName then
                self:PlatoonDisband()
                return
            end

        elseif cons.NearMarkerType and cons.ExpansionBase then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100

        if cons.NearMarkerType == 'Naval Area' then
                reference, refName = AIUtils.AIFindNavalAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
                -- didn't find a location to build at
            end

            -- If moving far from base, tell the assisting platoons to not go with
            if cons.FireBase or cons.ExpansionBase then
                local guards = eng:GetGuards()
                for k,v in guards do
                    if not v.Dead and v.PlatoonHandle then
                        v.PlatoonHandle:PlatoonDisband()
                    end
                end
            end

            if not cons.BaseTemplate and (cons.NearMarkerType == 'Naval Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, eng, cons)
            end
            relative = false
            if reference and aiBrain:GetThreatAtPosition(reference , 1, true, 'AntiSurface') > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            --buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
            buildFunction = AIBuildStructures.AIBuildBaseTemplate
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Naval Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindNavalDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiSurface'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and (cons.NearMarkerType == 'Rally Point' or cons.NearMarkerType == 'Protected Experimental Construction') then
            --DUNCAN - add so experimentals build on maps with no markers.
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if not reference then
                reference = pos
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType then
            --WARN('*Data weird for builder named - ' .. self.BuilderName)
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            if not cons.BaseTemplate and (cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, (cons.ExpansionRadius or 100), cons.ExpansionTypes, nil, cons)
            end
            if reference and aiBrain:GetThreatAtPosition(reference, 1, true) > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        else
            table.insert(baseTmplList, baseTmpl)
            relative = true
            reference = true
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        end
        if cons.BuildClose then
            closeToBuilder = eng
        end
        if cons.BuildStructures[1] == 'T1Resource' or cons.BuildStructures[1] == 'T2Resource' or cons.BuildStructures[1] == 'T3Resource' then
            relative = true
            closeToBuilder = eng
            local guards = eng:GetGuards()
            for k,v in guards do
                if not v.Dead and v.PlatoonHandle and aiBrain:PlatoonExists(v.PlatoonHandle) then
                    v.PlatoonHandle:PlatoonDisband()
                end
            end
        end

        --LOG("*AI DEBUG: Setting up Callbacks for " .. eng.Sync.id)
        self.SetupEngineerCallbacksSCTA(eng)

        -------- BUILD BUILDINGS HERE --------
        for baseNum, baseListData in baseTmplList do
            for k, v in cons.BuildStructures do
                if aiBrain:PlatoonExists(self) then
                    if not eng.Dead then
                        local faction = TAutils.TAGetEngineerFaction(eng)
                        if aiBrain.CustomUnits[v] and aiBrain.CustomUnits[v][faction] then
                            local replacement = SUtils.GetTemplateReplacement(aiBrain, v, faction, buildingTmpl)
                            if replacement then
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, replacement, baseListData, reference, cons.NearMarkerType)
                            else
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                            end
                        else
                            buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                        end
                    else
                        if aiBrain:PlatoonExists(self) then
                            self:PlatoonDisband()
                            return
                        end
                    end
                end
            end
        end

        -- wait in case we're still on a base
        local count = 0
        while not eng.Dead and eng:IsUnitState('Attached') and count < 2 do
            coroutine.yield(60)
            count = count + 1
        end

        if not eng.Dead and not eng:IsUnitState('Building') then
            return self.SCTAProcessBuildCommand(eng, false)
        end
    end,

    EngineerBuildAISCTAAir = function(self)
        local aiBrain = self:GetBrain()
        local platoonUnits = self:GetPlatoonUnits()
        local armyIndex = aiBrain:GetArmyIndex()
        local x,z = aiBrain:GetArmyStartPos()
        local cons = self.PlatoonData.Construction
        local buildingTmpl, buildingTmplFile, baseTmpl, baseTmplFile, baseTmplDefault
        local eng
        for k, v in platoonUnits do
            if not v.Dead and EntityCategoryContains(categories.ENGINEER - categories.STATIONASSISTPOD, v) then --DUNCAN - was construction
                IssueClearCommands({v})
                if not eng then
                    eng = v
                else
                    IssueGuard({v}, eng)
                end
            end
        end

        if not eng or eng.Dead then
            coroutine.yield(1)
            self:PlatoonDisband()
            return
        end

        --DUNCAN - added
        if eng:IsUnitState('Building') or eng:IsUnitState('Upgrading') then
           return
        end
            local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
            local factionIndex = cons.FactionIndex or FactionToIndex[eng.factionCategory]

            buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
            baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
            baseTmplDefault = import('/lua/BaseTemplates.lua')
            buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
            baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]

        --LOG('*AI DEBUG: EngineerBuild AI ' .. eng.Sync.id)

        if self.PlatoonData.NeedGuard then
            eng.NeedGuard = true
        end

        -------- CHOOSE APPROPRIATE BUILD FUNCTION AND SETUP BUILD VARIABLES --------
        local reference = false
        local refName = false
        local buildFunction
        local closeToBuilder
        local relative
        local baseTmplList = {}

        -- if we have nothing to build, disband!
        if not cons.BuildStructures then
            --[[local pos = self:GetPlatoonPosition()
            local gtime = GetGameTimeSeconds()
        if gtime < 600 then
            local ents = TAutils.TAAIGetReclaimablesAroundLocation(aiBrain, locationType) or {}
            local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
            if ents and econ.MassStorageRatio < 0.5 then
                coroutine.yield(1)
                return self:IdleEngineerSCTA()
            end
            else]]
        coroutine.yield(1)
        self:PlatoonDisband()
        return
        end
        if cons.NearUnitCategory then
            self:SetPrioritizedTargetList('support', {ParseEntityCategory(cons.NearUnitCategory)})
            local unitNearBy = self:FindPrioritizedUnit('support', 'Ally', false, self:GetPlatoonPosition(), cons.NearUnitRadius or 50)
            --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." attempt near: ", cons.NearUnitCategory)
            if unitNearBy then
                reference = table.copy(unitNearBy:GetPosition())
                -- get commander home position
                --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." Near unit: ", cons.NearUnitCategory)
                if cons.NearUnitCategory == 'COMMAND' and unitNearBy.CDRHome then
                    reference = unitNearBy.CDRHome
                end
            else
                reference = table.copy(eng:GetPosition())
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.OrderedTemplate then
            relativeTo = table.copy(eng:GetPosition())
            --LOG('relativeTo is'..repr(relativeTo))
            relative = true
            local tmpReference = aiBrain:FindPlaceToBuild('T2EnergyProduction', 'uab1201', baseTmplDefault['BaseTemplates'][factionIndex], relative, eng, nil, relativeTo[1], relativeTo[3])
            if tmpReference then
                reference = eng:CalculateWorldPositionFromRelative(tmpReference)
            else
                return
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.Wall then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100
            relative = false
            reference = AIUtils.GetLocationNeedingWalls(aiBrain, 200, 4, 'STRUCTURE - WALLS', cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            table.insert(baseTmplList, 'Blank')
            buildFunction = AIBuildStructures.WallBuilder
        elseif cons.NearBasePatrolPoints then
            relative = false
            reference = AIUtils.GetBasePatrolPoints(aiBrain, cons.Location or 'MAIN', cons.Radius or 100)
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            for k,v in reference do
                table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, v))
            end
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
        elseif cons.FireBase and cons.FireBaseRange then
            --DUNCAN - pulled out and uses alt finder
            reference, refName = AIUtils.AIFindFirebaseLocation(aiBrain, cons.LocationType, cons.FireBaseRange, cons.NearMarkerType,
                                                cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType,
                                                cons.MarkerUnitCount, cons.MarkerUnitCategory, cons.MarkerRadius)
            if not reference or not refName then
                self:PlatoonDisband()
                return
            end

        elseif cons.NearMarkerType and cons.ExpansionBase then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100

            if cons.NearMarkerType == 'Expansion Area' then
                reference, refName = AIUtils.AIFindExpansionAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            elseif cons.NearMarkerType == 'Naval Area' then
                reference, refName = AIUtils.AIFindNavalAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            else
                --DUNCAN - use my alternative expansion finder on large maps below a certain time
                local mapSizeX, mapSizeZ = GetMapSize()
                if GetGameTimeSeconds() <= 780 and mapSizeX > 512 and mapSizeZ > 512 then
                    reference, refName = AIUtils.AIFindFurthestStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    if not reference or not refName then
                        reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                            (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    end
                else
                    reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                end
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            end

            -- If moving far from base, tell the assisting platoons to not go with
            if cons.FireBase or cons.ExpansionBase then
                local guards = eng:GetGuards()
                for k,v in guards do
                    if not v.Dead and v.PlatoonHandle then
                        v.PlatoonHandle:PlatoonDisband()
                    end
                end
            end

            if not cons.BaseTemplate and (cons.NearMarkerType == 'Naval Area' or cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, eng, cons)
            end
            relative = false
            if reference and aiBrain:GetThreatAtPosition(reference , 1, true, 'AntiAir') > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            --buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
            buildFunction = AIBuildStructures.AIBuildBaseTemplate
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiAir'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Naval Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindNavalDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiAir'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and (cons.NearMarkerType == 'Rally Point' or cons.NearMarkerType == 'Protected Experimental Construction') then
            --DUNCAN - add so experimentals build on maps with no markers.
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if not reference then
                reference = pos
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType then
            --WARN('*Data weird for builder named - ' .. self.BuilderName)
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            if not cons.BaseTemplate and (cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, (cons.ExpansionRadius or 100), cons.ExpansionTypes, nil, cons)
            end
            if reference and aiBrain:GetThreatAtPosition(reference, 1, true) > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        else
            table.insert(baseTmplList, baseTmpl)
            relative = true
            reference = true
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        end
        if cons.BuildClose then
            closeToBuilder = eng
        end
        if cons.BuildStructures[1] == 'T1Resource' or cons.BuildStructures[1] == 'T2Resource' or cons.BuildStructures[1] == 'T3Resource' then
            relative = true
            closeToBuilder = eng
            local guards = eng:GetGuards()
            for k,v in guards do
                if not v.Dead and v.PlatoonHandle and aiBrain:PlatoonExists(v.PlatoonHandle) then
                    v.PlatoonHandle:PlatoonDisband()
                end
            end
        end

        --LOG("*AI DEBUG: Setting up Callbacks for " .. eng.Sync.id)
        self.SetupEngineerCallbacksSCTA(eng)

        -------- BUILD BUILDINGS HERE --------
        for baseNum, baseListData in baseTmplList do
            for k, v in cons.BuildStructures do
                if aiBrain:PlatoonExists(self) then
                    if not eng.Dead then
                        local faction = TAutils.TAGetEngineerFaction(eng)
                        if aiBrain.CustomUnits[v] and aiBrain.CustomUnits[v][faction] then
                            local replacement = SUtils.GetTemplateReplacement(aiBrain, v, faction, buildingTmpl)
                            if replacement then
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, replacement, baseListData, reference, cons.NearMarkerType)
                            else
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                            end
                        else
                            buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                        end
                    else
                        if aiBrain:PlatoonExists(self) then
                            self:PlatoonDisband()
                            return
                        end
                    end
                end
            end
        end

        -- wait in case we're still on a base
        local count = 0
        while not eng.Dead and eng:IsUnitState('Attached') and count < 2 do
            coroutine.yield(60)
            count = count + 1
        end

        if not eng.Dead and not eng:IsUnitState('Building') then
            return self.SCTAProcessBuildCommand(eng, false)
        end
    end,

    EngineerBuildAISCTACommand = function(self)
        local aiBrain = self:GetBrain()
        local platoonUnits = self:GetPlatoonUnits()
        local armyIndex = aiBrain:GetArmyIndex()
        local x,z = aiBrain:GetArmyStartPos()
        local cons = self.PlatoonData.Construction
        local buildingTmpl, buildingTmplFile, baseTmpl, baseTmplFile, baseTmplDefault
        local eng
        for k, v in platoonUnits do
            if not v.Dead and EntityCategoryContains(categories.ENGINEER - categories.STATIONASSISTPOD, v) then --DUNCAN - was construction
                IssueClearCommands({v})
                if not eng then
                    eng = v
                else
                    IssueGuard({v}, eng)
                end
            end
        end

        if not eng or eng.Dead then
            coroutine.yield(1)
            self:PlatoonDisband()
            return
        end

        --DUNCAN - added
        if eng:IsUnitState('Building') or eng:IsUnitState('Upgrading') then
           return
        end
            local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
            local factionIndex = cons.FactionIndex or FactionToIndex[eng.factionCategory]

            buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
            baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
            baseTmplDefault = import('/lua/BaseTemplates.lua')
            buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
            baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]

        --LOG('*AI DEBUG: EngineerBuild AI ' .. eng.Sync.id)

        if self.PlatoonData.NeedGuard then
            eng.NeedGuard = true
        end

        -------- CHOOSE APPROPRIATE BUILD FUNCTION AND SETUP BUILD VARIABLES --------
        local reference = false
        local refName = false
        local buildFunction
        local closeToBuilder
        local relative
        local baseTmplList = {}

        -- if we have nothing to build, disband!
        if not cons.BuildStructures then
            coroutine.yield(1)
            self:PlatoonDisband()
            return
        end
        if cons.NearUnitCategory then
            self:SetPrioritizedTargetList('support', {ParseEntityCategory(cons.NearUnitCategory)})
            local unitNearBy = self:FindPrioritizedUnit('support', 'Ally', false, self:GetPlatoonPosition(), cons.NearUnitRadius or 50)
            --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." attempt near: ", cons.NearUnitCategory)
            if unitNearBy then
                reference = table.copy(unitNearBy:GetPosition())
                -- get commander home position
                --LOG("ENGINEER BUILD: " .. cons.BuildStructures[1] .." Near unit: ", cons.NearUnitCategory)
                if cons.NearUnitCategory == 'COMMAND' and unitNearBy.CDRHome then
                    reference = unitNearBy.CDRHome
                end
            else
                reference = table.copy(eng:GetPosition())
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.OrderedTemplate then
            relativeTo = table.copy(eng:GetPosition())
            --LOG('relativeTo is'..repr(relativeTo))
            relative = true
            local tmpReference = aiBrain:FindPlaceToBuild('T2EnergyProduction', 'uab1201', baseTmplDefault['BaseTemplates'][factionIndex], relative, eng, nil, relativeTo[1], relativeTo[3])
            if tmpReference then
                reference = eng:CalculateWorldPositionFromRelative(tmpReference)
            else
                return
            end
            relative = false
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
        elseif cons.Wall then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100
            relative = false
            reference = AIUtils.GetLocationNeedingWalls(aiBrain, 200, 4, 'STRUCTURE - WALLS', cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            table.insert(baseTmplList, 'Blank')
            buildFunction = AIBuildStructures.WallBuilder
        elseif cons.NearBasePatrolPoints then
            relative = false
            reference = AIUtils.GetBasePatrolPoints(aiBrain, cons.Location or 'MAIN', cons.Radius or 100)
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            for k,v in reference do
                table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, v))
            end
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
        elseif cons.FireBase and cons.FireBaseRange then
            --DUNCAN - pulled out and uses alt finder
            reference, refName = AIUtils.AIFindFirebaseLocation(aiBrain, cons.LocationType, cons.FireBaseRange, cons.NearMarkerType,
                                                cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType,
                                                cons.MarkerUnitCount, cons.MarkerUnitCategory, cons.MarkerRadius)
            if not reference or not refName then
                self:PlatoonDisband()
                return
            end

        elseif cons.NearMarkerType and cons.ExpansionBase then
            local pos = aiBrain:PBMGetLocationCoords(cons.LocationType) or cons.Position or self:GetPlatoonPosition()
            local radius = cons.LocationRadius or aiBrain:PBMGetLocationRadius(cons.LocationType) or 100

            if cons.NearMarkerType == 'Expansion Area' then
                reference, refName = AIUtils.AIFindExpansionAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            elseif cons.NearMarkerType == 'Naval Area' then
                reference, refName = AIUtils.AIFindNavalAreaNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            else
                --DUNCAN - use my alternative expansion finder on large maps below a certain time
                local mapSizeX, mapSizeZ = GetMapSize()
                if GetGameTimeSeconds() <= 780 and mapSizeX > 512 and mapSizeZ > 512 then
                    reference, refName = AIUtils.AIFindFurthestStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    if not reference or not refName then
                        reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                            (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                    end
                else
                    reference, refName = AIUtils.AIFindStartLocationNeedsEngineer(aiBrain, cons.LocationType,
                        (cons.LocationRadius or 100), cons.ThreatMin, cons.ThreatMax, cons.ThreatRings, cons.ThreatType)
                end
                -- didn't find a location to build at
                if not reference or not refName then
                    self:PlatoonDisband()
                    return
                end
            end

            -- If moving far from base, tell the assisting platoons to not go with
            if cons.FireBase or cons.ExpansionBase then
                local guards = eng:GetGuards()
                for k,v in guards do
                    if not v.Dead and v.PlatoonHandle then
                        v.PlatoonHandle:PlatoonDisband()
                    end
                end
            end

            if not cons.BaseTemplate and (cons.NearMarkerType == 'Naval Area' or cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, eng, cons)
            end
            relative = false
            if reference and aiBrain:GetThreatAtPosition(reference , 1, true, 'AntiSurface') > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            -- Must use BuildBaseOrdered to start at the marker; otherwise it builds closest to the eng
            --buildFunction = AIBuildStructures.AIBuildBaseTemplateOrderedSCTAAI
            buildFunction = AIBuildStructures.AIBuildBaseTemplate
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiSurface'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and cons.NearMarkerType == 'Naval Defensive Point' then
            baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]

            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIFindNavalDefensivePointNeedsStructure(aiBrain, cons.LocationType, (cons.LocationRadius or 100),
                            cons.MarkerUnitCategory, cons.MarkerRadius, cons.MarkerUnitCount, (cons.ThreatMin or 0), (cons.ThreatMax or 1),
                            (cons.ThreatRings or 1), (cons.ThreatType or 'AntiSurface'))

            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))

            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType and (cons.NearMarkerType == 'Rally Point' or cons.NearMarkerType == 'Protected Experimental Construction') then
            --DUNCAN - add so experimentals build on maps with no markers.
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if not reference then
                reference = pos
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        elseif cons.NearMarkerType then
            --WARN('*Data weird for builder named - ' .. self.BuilderName)
            if not cons.ThreatMin or not cons.ThreatMax or not cons.ThreatRings then
                cons.ThreatMin = -1000000
                cons.ThreatMax = 1000000
                cons.ThreatRings = 0
            end
            if not cons.BaseTemplate and (cons.NearMarkerType == 'Defensive Point' or cons.NearMarkerType == 'Expansion Area') then
                baseTmpl = baseTmplFile['ExpansionBaseTemplates'][factionIndex]
            end
            relative = false
            local pos = self:GetPlatoonPosition()
            reference, refName = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, cons.NearMarkerType, pos[1], pos[3],
                                                            cons.ThreatMin, cons.ThreatMax, cons.ThreatRings)
            if cons.ExpansionBase and refName then
                AIBuildStructures.AINewExpansionBase(aiBrain, refName, reference, (cons.ExpansionRadius or 100), cons.ExpansionTypes, nil, cons)
            end
            if reference and aiBrain:GetThreatAtPosition(reference, 1, true) > 0 then
                --aiBrain:ExpansionHelp(eng, reference)
            end
            table.insert(baseTmplList, AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, reference))
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        else
            table.insert(baseTmplList, baseTmpl)
            relative = true
            reference = true
            buildFunction = AIBuildStructures.AIExecuteBuildStructureSCTAAI
        end
        if cons.BuildClose then
            closeToBuilder = eng
        end
        if cons.BuildStructures[1] == 'T1Resource' or cons.BuildStructures[1] == 'T2Resource' or cons.BuildStructures[1] == 'T3Resource' then
            relative = true
            closeToBuilder = eng
            local guards = eng:GetGuards()
            for k,v in guards do
                if not v.Dead and v.PlatoonHandle and aiBrain:PlatoonExists(v.PlatoonHandle) then
                    v.PlatoonHandle:PlatoonDisband()
                end
            end
        end

        --LOG("*AI DEBUG: Setting up Callbacks for " .. eng.Sync.id)
        self.SetupEngineerCallbacksSCTA(eng)

        -------- BUILD BUILDINGS HERE --------
        for baseNum, baseListData in baseTmplList do
            for k, v in cons.BuildStructures do
                if aiBrain:PlatoonExists(self) then
                    if not eng.Dead then
                        local faction = TAutils.TAGetEngineerFaction(eng)
                        if aiBrain.CustomUnits[v] and aiBrain.CustomUnits[v][faction] then
                            local replacement = SUtils.GetTemplateReplacement(aiBrain, v, faction, buildingTmpl)
                            if replacement then
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, replacement, baseListData, reference, cons.NearMarkerType)
                            else
                                buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                            end
                        else
                            buildFunction(aiBrain, eng, v, closeToBuilder, relative, buildingTmpl, baseListData, reference, cons.NearMarkerType)
                        end
                    else
                        if aiBrain:PlatoonExists(self) then
                            self:PlatoonDisband()
                            return
                        end
                    end
                end
            end
        end

        -- wait in case we're still on a base
        local count = 0
        while not eng.Dead and eng:IsUnitState('Attached') and count < 2 do
            coroutine.yield(60)
            count = count + 1
        end

        if not eng.Dead and not eng:IsUnitState('Building') then
            return self.SCTAProcessBuildCommand(eng, false)
        end
    end,

    SetupEngineerCallbacksSCTA = function(eng)
        if eng and not eng.Dead and not eng.BuildDoneCallbackSet and eng.PlatoonHandle and eng:GetAIBrain():PlatoonExists(eng.PlatoonHandle) then
            import('/lua/ScenarioTriggers.lua').CreateUnitBuiltTrigger(eng.PlatoonHandle.EngineerBuildDoneSCTA, eng, categories.ALLUNITS)
            eng.BuildDoneCallbackSet = true
        end
        if eng and not eng.Dead and not eng.CaptureDoneCallbackSet and eng.PlatoonHandle and eng:GetAIBrain():PlatoonExists(eng.PlatoonHandle) then
            import('/lua/ScenarioTriggers.lua').CreateUnitStopCaptureTrigger(eng.PlatoonHandle.EngineerCaptureDoneSCTA, eng)
            eng.CaptureDoneCallbackSet = true
        end
        if eng and not eng.Dead and not eng.ReclaimDoneCallbackSet and eng.PlatoonHandle and eng:GetAIBrain():PlatoonExists(eng.PlatoonHandle) then
            import('/lua/ScenarioTriggers.lua').CreateUnitStopReclaimTrigger(eng.PlatoonHandle.EngineerReclaimDoneSCTA, eng)
            eng.ReclaimDoneCallbackSet = true
        end
        if eng and not eng.Dead and not eng.FailedToBuildCallbackSet and eng.PlatoonHandle and eng:GetAIBrain():PlatoonExists(eng.PlatoonHandle) then
            import('/lua/ScenarioTriggers.lua').CreateOnFailedToBuildTrigger(eng.PlatoonHandle.EngineerFailedToBuildSCTA, eng)
            eng.FailedToBuildCallbackSet = true
        end
    end,

    EngineerBuildDoneSCTA = function(unit, params)
        if not unit.PlatoonHandle then return end
        if not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTA' 
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTACommand'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTANaval'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTAAir'
        then return end
        --LOG("*AI DEBUG: Build done " .. unit.Sync.id)
        if not unit.ProcessBuild then
            unit.ProcessBuild = unit:ForkThread(unit.PlatoonHandle.SCTAProcessBuildCommand, true)
            unit.ProcessBuildDone = true
        end
    end,

    EngineerCaptureDoneSCTA = function(unit, params)
        if not unit.PlatoonHandle then return end
        if not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTA' 
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTACommand'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTANaval'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTAAir'
        then return end
        --LOG("*AI DEBUG: Capture done" .. unit.Sync.id)
        if not unit.ProcessBuild then
            unit.ProcessBuild = unit:ForkThread(unit.PlatoonHandle.SCTAProcessBuildCommand, false)
        end
    end,
    EngineerReclaimDoneSCTA = function(unit, params)
        if not unit.PlatoonHandle then return end
        if not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTA' 
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTACommand'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTANaval'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTAAir'
        then return end
        --LOG("*AI DEBUG: Reclaim done" .. unit.Sync.id)
        if not unit.ProcessBuild then
            unit.ProcessBuild = unit:ForkThread(unit.PlatoonHandle.SCTAProcessBuildCommand, false)
        end
    end,

    EngineerFailedToBuildSCTA = function(unit, params)
        if not unit.PlatoonHandle then return end
        if not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTA' 
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTACommand'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTANaval'
        or not unit.PlatoonHandle.PlanName == 'EngineerBuildAISCTAAir'
        then return end
        if unit.ProcessBuildDone and unit.ProcessBuild then
            KillThread(unit.ProcessBuild)
            unit.ProcessBuild = nil
        end
        if not unit.ProcessBuild then
            unit.ProcessBuild = unit:ForkThread(unit.PlatoonHandle.SCTAProcessBuildCommand, true)  --DUNCAN - changed to true
        end
    end,

    SCTAProcessBuildCommand = function(eng, removeLastBuild)
        if not eng or eng.Dead or not eng.PlatoonHandle then
            return
        end
        local aiBrain = eng.PlatoonHandle:GetBrain()

        if not aiBrain or eng.Dead or not eng.EngineerBuildQueue or table.getn(eng.EngineerBuildQueue) == 0 then
            if aiBrain:PlatoonExists(eng.PlatoonHandle) then
                if not eng.AssistSet and not eng.AssistPlatoon and not eng.UnitBeingAssist then
                    eng.PlatoonHandle:PlatoonDisband()
                end
            end
            if eng then eng.ProcessBuild = nil end
            return
        end

        -- it wasn't a failed build, so we just finished something
        if removeLastBuild then
            table.remove(eng.EngineerBuildQueue, 1)
        end

        eng.ProcessBuildDone = false
        IssueClearCommands({eng})
        local commandDone = false
        local PlatoonPos
        while not eng.Dead and not commandDone and table.getn(eng.EngineerBuildQueue) > 0  do
            local whatToBuild = eng.EngineerBuildQueue[1][1]
            local buildLocation = {eng.EngineerBuildQueue[1][2][1], 0, eng.EngineerBuildQueue[1][2][2]}
            if GetTerrainHeight(buildLocation[1], buildLocation[3]) > GetSurfaceHeight(buildLocation[1], buildLocation[3]) then
                --land
                buildLocation[2] = GetTerrainHeight(buildLocation[1], buildLocation[3])
            else
                --water
                buildLocation[2] = GetSurfaceHeight(buildLocation[1], buildLocation[3])
            end
            local buildRelative = eng.EngineerBuildQueue[1][3]
            if not eng.NotBuildingThread then
                eng.NotBuildingThread = eng:ForkThread(eng.PlatoonHandle.SCTAWatchForNotBuilding)
            end
            -- see if we can move there first
            if AIUtils.EngineerMoveWithSafePath(aiBrain, eng, buildLocation) then
                if not eng or eng.Dead or not eng.PlatoonHandle or not aiBrain:PlatoonExists(eng.PlatoonHandle) then
                    return
                end
                -- issue buildcommand to block other engineers from caping mex/hydros or to reserve the buildplace
                aiBrain:BuildStructure(eng, whatToBuild, {buildLocation[1], buildLocation[3], 0}, buildRelative)
                -- wait until we are close to the buildplace so we have intel
                while not eng.Dead do
                    PlatoonPos = eng:GetPosition()
                    if VDist2(PlatoonPos[1] or 0, PlatoonPos[3] or 0, buildLocation[1] or 0, buildLocation[3] or 0) < 12 then
                        break
                    end
                    coroutine.yield(1)
                end
                if not eng or eng.Dead or not eng.PlatoonHandle or not aiBrain:PlatoonExists(eng.PlatoonHandle) then
                    if eng then eng.ProcessBuild = nil end
                    return
                end
                -- cancel all commands, also the buildcommand for blocking mex to check for reclaim or capture
                eng.PlatoonHandle:Stop()
                -- check to see if we need to reclaim or capture...
                TAutils.SCTAEngineerTryReclaimCaptureArea(aiBrain, eng, buildLocation)
                -- check to see if we can repair
                AIUtils.EngineerTryRepair(aiBrain, eng, whatToBuild, buildLocation)
                -- otherwise, go ahead and build the next structure there
                aiBrain:BuildStructure(eng, whatToBuild, {buildLocation[1], buildLocation[3], 0}, buildRelative)
                if not eng.NotBuildingThread then
                    eng.NotBuildingThread = eng:ForkThread(eng.PlatoonHandle.SCTAWatchForNotBuilding)
                end
                commandDone = true
            else
                -- we can't move there, so remove it from our build queue
                table.remove(eng.EngineerBuildQueue, 1)
            end
        end

        -- final check for if we should disband
        if not eng or eng.Dead or table.getn(eng.EngineerBuildQueue) <= 0 then
            if eng.PlatoonHandle and aiBrain:PlatoonExists(eng.PlatoonHandle) and not eng.PlatoonHandle.UsingTransport then
                eng.PlatoonHandle:PlatoonDisband()
            end
        end
        if eng then eng.ProcessBuild = nil end
    end,

    SCTAWatchForNotBuilding = function(eng)
        WaitTicks(5)
        local aiBrain = eng:GetAIBrain()
        while not eng:IsDead() and eng.GoingHome or eng:IsUnitState("Building") or 
                  eng:IsUnitState("Attacking") or eng:IsUnitState("Repairing") or 
                  eng:IsUnitState("Reclaiming") or eng:IsUnitState("Capturing") or eng.ProcessBuild != nil do
                  
            WaitSeconds(3)
            --if eng.CDRHome then eng:PrintCommandQueue() end
        end
        eng.NotBuildingThread = nil
        if not eng:IsDead() and eng:IsIdleState() and table.getn(eng.EngineerBuildQueue) != 0 and eng.PlatoonHandle then
            eng.PlatoonHandle.SetupEngineerCallbacksSCTA(eng)
            if not eng.ProcessBuild then
                eng.ProcessBuild = eng:ForkThread(eng.PlatoonHandle.SCTAProcessBuildCommand, true)
            end
        end  
    end,

    UnitUpgradeAI = function(self)
        local aiBrain = self:GetBrain()
        if not aiBrain.SCTAAI then
            return SCTAAIPlatoon.UnitUpgradeAI(self)
        end
        local platoonUnits = self:GetPlatoonUnits()
        local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
        local factionIndex = aiBrain:GetFactionIndex()
        self:Stop()
        for k, v in platoonUnits do
            local upgradeID
            UnitBeingUpgradeFactionIndex = FactionToIndex[v.factionCategory] or factionIndex
                upgradeID = aiBrain:FindUpgradeBP(v:GetUnitId(), StructureUpgradeTemplates[UnitBeingUpgradeFactionIndex])
            if upgradeID then
                IssueUpgrade({v}, upgradeID)
            end
        end
        local upgrading = true
        while aiBrain:PlatoonExists(self) and upgrading do
            WaitSeconds(3)
            upgrading = false
            for k, v in platoonUnits do
                if v and not v:IsDead() then
                    upgrading = true
                end
            end
        end
        if not aiBrain:PlatoonExists(self) then
            return
        end
        WaitTicks(1)
        self:PlatoonDisband()
    end,

    SCTAAntiAirAI = function(self)
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local categoryList = {}
        local atkPri = {}
        if data.PrioritizedCategories then
            for k,v in data.PrioritizedCategories do
                table.insert( atkPri, v )
                table.insert( categoryList, ParseEntityCategory( v ) )
            end
        end
        table.insert( atkPri, 'AIR' )
        table.insert( categoryList, categories.ALLUNITS)
        self:SetPrioritizedTargetList( 'Attack', categoryList )
        local target
        local blip = false
        local maxRadius = data.SearchRadius or 50
        local movingToScout = false
        while aiBrain:PlatoonExists(self) do
            if not target or target:IsDead() then
                if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy():IsDefeated() then
                    aiBrain:PickEnemyLogic()
                end
                local mult = { 1,10,25 }
                for _,i in mult do
                    target = AIUtils.AIFindBrainTargetInRange( aiBrain, self, 'Attack', maxRadius * i, atkPri, aiBrain:GetCurrentEnemy() )
                    if target then
                        break
                    end
                    WaitSeconds(3)
                    if not aiBrain:PlatoonExists(self) then
                        return
                    end
                end
                target = self:FindPrioritizedUnit('Attack', 'Enemy', true, self:GetPlatoonPosition(), maxRadius)
                if target then
                    self:Stop()
                    if not data.UseMoveOrder then
                        self:AttackTarget( target )
                    else
                        --self:SetPlatoonFormationOverride('Attack')
                        self:MoveToLocation( table.copy( target:GetPosition() ), false)
                    end
                    movingToScout = false
                elseif not movingToScout then
                    movingToScout = true
                    self:Stop()
                    for k,v in AIUtils.AIGetSortedMassLocations(aiBrain, 10, nil, nil, nil, nil, self:GetPlatoonPosition()) do
                        if v[1] < 0 or v[3] < 0 or v[1] > ScenarioInfo.size[1] or v[3] > ScenarioInfo.size[2] then
                        end
                        --self:SetPlatoonFormationOverride('Attack')
                        self:MoveToLocation( (v), false )
                    end
                end
            end
            WaitSeconds( 7 )
        end
    end,

    SCTAStrikeForceAI = function(self)
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local categoryList = {}
        local atkPri = {}
        local platoonUnits = self:GetPlatoonUnits()
        local numberOfUnitsInPlatoon = table.getn(platoonUnits)
        --LOG('*SCTAEXPANSIONTA', data.locationType)
        if data.Laser then
            local econ = aiBrain:GetEconomyStoredRatio('ENERGY')
            if econ.EnergyStorageRatio < 0.15 then
                WaitSeconds(5)
                self:PlatoonDisband()
                return
            end
        end
        if data.PrioritizedCategories then
            for k,v in data.PrioritizedCategories do
                table.insert( atkPri, v )
                table.insert( categoryList, ParseEntityCategory( v ) )
            end
        end
        table.insert( atkPri, 'LAND' )
        table.insert( categoryList, categories.ALLUNITS - categories.AIR - categories.STRUCTURE )
        self:SetPrioritizedTargetList( 'Attack', categoryList )
        local target
        local blip = false
        local maxRadius = data.SearchRadius or 500
        local movingToScout = false
        while aiBrain:PlatoonExists(self) do
            if aiBrain:PlatoonExists(self) and numberOfUnitsInPlatoon < 15 then
                self:MergeWithNearbyPlatoonsSCTA('SCTAStrikeForceAIEarly', 5, true)
            end
            --self:SetPlatoonFormationOverride('Attack')
            if not target or target:IsDead() then
                if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy():IsDefeated() then
                    aiBrain:PickEnemyLogic()
                end
                local mult = { 1,10,25 }
                for _,i in mult do
                    target = AIUtils.AIFindBrainTargetInRange( aiBrain, self, 'Attack', maxRadius * i, atkPri, aiBrain:GetCurrentEnemy() )
                    if target then
                        break
                    end
                    WaitSeconds(3)
                    if not aiBrain:PlatoonExists(self) then
                        return
                    end
                end
                target = self:FindPrioritizedUnit('Attack', 'Enemy', true, self:GetPlatoonPosition(), maxRadius)
                if target then
                    --self:SetPlatoonFormationOverride('Attack')
                    self:Stop()
                    if aiBrain:PlatoonExists(self) and data.Small and not data.UseMoveOrder then
                        if numberOfUnitsInPlatoon < 20 then
                        self:SetPlatoonFormationOverride('AttackFormation')
                        self:AttackTarget( target )
                        end
                    else
                        self:MoveToLocation( table.copy( target:GetPosition() ), false)
                    end
                    movingToScout = false
                elseif not movingToScout then
                    --self:SetPlatoonFormationOverride('AttackFormation')
                    movingToScout = true
                    self:Stop()
                    for k,v in AIUtils.AIGetSortedMassLocations(aiBrain, 10, nil, nil, nil, nil, self:GetPlatoonPosition()) do
                        if v[1] < 0 or v[3] < 0 or v[1] > ScenarioInfo.size[1] or v[3] > ScenarioInfo.size[2] then
                        end
                        self:MoveToLocation( (v), false )
                    end
                end
            end
            --self:SetPlatoonFormationOverride('Attack')
            WaitSeconds( 7 )
        end
    end,

    SCTAStrikeForceAIEarly = function(self)
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local categoryList = {}
        local atkPri = {}
        --LOG('*SCTAEXPANSIONTA', self.BuilderData.locationType)
        if data.PrioritizedCategories then
            for k,v in data.PrioritizedCategories do
                table.insert( atkPri, v )
                table.insert( categoryList, ParseEntityCategory( v ) )
            end
        end
        table.insert( atkPri, 'LAND' )
        table.insert( categoryList, categories.ALLUNITS - categories.AIR - categories.COMMAND - categories.STRUCTURE)
        self:SetPrioritizedTargetList( 'Attack', categoryList )
        local target
        local blip = false
        local maxRadius = data.SearchRadius or 50
        local movingToScout = false
        while aiBrain:PlatoonExists(self) do
            if not target or target:IsDead() then
                if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy():IsDefeated() then
                    aiBrain:PickEnemyLogic()
                end
                local mult = { 1,10,25 }
                for _,i in mult do
                    target = AIUtils.AIFindBrainTargetInRange( aiBrain, self, 'Attack', maxRadius * i, atkPri, aiBrain:GetCurrentEnemy() )
                    if target then
                        break
                    end
                    WaitSeconds(3)
                    if not aiBrain:PlatoonExists(self) then
                        return
                    end
                end
                target = self:FindPrioritizedUnit('Attack', 'Enemy', true, self:GetPlatoonPosition(), maxRadius)
                if target then
                    --self:SetPlatoonFormationOverride('Attack')
                    self:Stop()
                    if not data.UseMoveOrder then
                        self:AttackTarget( target )
                    else
                        self:MoveToLocation( table.copy( target:GetPosition() ), false)
                    end
                    movingToScout = false
                elseif not movingToScout then
                    movingToScout = true
                    self:Stop()
                    for k,v in AIUtils.AIGetSortedMassLocations(aiBrain, 10, nil, nil, nil, nil, self:GetPlatoonPosition()) do
                        if v[1] < 0 or v[3] < 0 or v[1] > ScenarioInfo.size[1] or v[3] > ScenarioInfo.size[2] then
                        end
                        self:MoveToLocation( (v), false )
                    end
                end
            end
            --self:SetPlatoonFormationOverride('Attack')
            WaitSeconds( 7 )
        end
    end,

    SCTAStrikeForceAIEndgame = function(self)
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local categoryList = {}
        local atkPri = {}
        local platoonUnits = self:GetPlatoonUnits()
        local numberOfUnitsInPlatoon = table.getn(platoonUnits)
        if data.PrioritizedCategories then
            for k,v in data.PrioritizedCategories do
                table.insert( atkPri, v )
                table.insert( categoryList, ParseEntityCategory( v ) )
            end
        end
        table.insert( atkPri, 'LAND' )
        table.insert( categoryList, categories.ALLUNITS - categories.AIR - categories.STRUCTURE )
        self:SetPrioritizedTargetList( 'Attack', categoryList )
        local target
        local blip = false
        local maxRadius = data.SearchRadius or 1000
        while aiBrain:PlatoonExists(self) do
            if aiBrain:PlatoonExists(self) and numberOfUnitsInPlatoon < 25 then
                self:MergeWithNearbyPlatoonsSCTA('SCTAStrikeForceAI', 5)
            end
            if not target or target:IsDead() then
                if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy():IsDefeated() then
                    aiBrain:PickEnemyLogic()
                end
                local mult = { 1,10,25 }
                for _,i in mult do
                    target = AIUtils.AIFindBrainTargetInRange( aiBrain, self, 'Attack', maxRadius * i, atkPri, aiBrain:GetCurrentEnemy() )
                    if target then
                        break
                    end
                    WaitSeconds(3)
                    if not aiBrain:PlatoonExists(self) then
                        return
                    end
                end
                target = self:FindPrioritizedUnit('Attack', 'Enemy', true, self:GetPlatoonPosition(), maxRadius)
                if target then
                    --self:SetPlatoonFormationOverride('Attack')
                    self:Stop()
                    self:MoveToLocation( table.copy( target:GetPosition() ), false)
                end
            end
            --self:SetPlatoonFormationOverride('Attack')
            WaitSeconds( 7 )
        end
    end,

    MergeWithNearbyPlatoonsSCTA = function(self, planName, radius, fullrestart)
        local aiBrain = self:GetBrain()
        if not aiBrain then
            return
        end

        if self.UsingTransport then
            return
        end

        local platPos = self:GetPlatoonPosition()
        if not platPos then
            return
        end

        local radiusSq = radius*radius
        -- if we're too close to a base, forget it
        if aiBrain.BuilderManagers then
            for baseName, base in aiBrain.BuilderManagers do
                local baseRadius = base.FactoryManager.Radius
                if VDist2Sq(platPos[1], platPos[3], base.Position[1], base.Position[3]) <= (baseRadius * baseRadius) + (3 * radiusSq) then
                    return
                end
            end
        end

        AlliedPlatoons = aiBrain:GetPlatoonsList()
        local bMergedPlatoons = false
        for _,aPlat in AlliedPlatoons do
            if aPlat:GetPlan() != planName then
                continue
            end
            if aPlat == self then
                continue
            end
            if aPlat.UsingTransport then
                continue
            end

            local allyPlatPos = aPlat:GetPlatoonPosition()
            if not allyPlatPos or not aiBrain:PlatoonExists(aPlat) then
                continue
            end

            AIAttackUtils.GetMostRestrictiveLayer(self)
            AIAttackUtils.GetMostRestrictiveLayer(aPlat)

            -- make sure we're the same movement layer type to avoid hamstringing air of amphibious
            if self.MovementLayer != aPlat.MovementLayer then
                continue
            end

            if VDist2Sq(platPos[1], platPos[3], allyPlatPos[1], allyPlatPos[3]) <= radiusSq then
                local units = aPlat:GetPlatoonUnits()
                local validUnits = {}
                local bValidUnits = false
                for _,u in units do
                    if not u.Dead and not u:IsUnitState('Attached') then
                        table.insert(validUnits, u)
                        bValidUnits = true
                    end
                end
                if not bValidUnits then
                    continue
                end
                --LOG("*AI DEBUG: Merging platoons " .. self.BuilderName .. ": (" .. platPos[1] .. ", " .. platPos[3] .. ") and " .. aPlat.BuilderName .. ": (" .. allyPlatPos[1] .. ", " .. allyPlatPos[3] .. ")")
                aiBrain:AssignUnitsToPlatoon(self, validUnits, 'Attack', 'GrowthFormation')
                bMergedPlatoons = true
            end
        end
        if bMergedPlatoons then
            if fullrestart then
                self:Stop()
                self:SetAIPlan(planName)
            else
                self:StopAttack()
            end
        end
    end,

    AttackSCTAForceAIEndGame = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()

        -- get units together
        if not self:GatherUnits() then
            return
        end

        -- Setup the formation based on platoon functionality

        local enemy = aiBrain:GetCurrentEnemy()

        local platoonUnits = self:GetPlatoonUnits()
        local stuckCount = 0

        self.PlatoonAttackForce = true
        -- formations have penalty for taking time to form up... not worth it here
        -- maybe worth it if we micro
        --self:SetPlatoonFormationOverride('GrowthFormation')
        local PlatoonFormation = self.PlatoonData.UseFormation or 'NoFormation'
        while aiBrain:PlatoonExists(self) do
            local pos = self:GetPlatoonPosition() -- update positions; prev position done at end of loop so not done first time

            -- if we can't get a position, then we must be dead
            if not pos then
                break
            end


            -- if we're using a transport, wait for a while
            if self.UsingTransport then
                WaitSeconds(4)
                continue
            end
        if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy().Result == "defeat" then
            aiBrain:PickEnemyLogic()
        end

        -- deal with lost-puppy transports
        local strayTransports = {}
        for k,v in platoonUnits do
            if EntityCategoryContains(categories.TRANSPORTFOCUS, v) then
                table.insert(strayTransports, v)
            end
        end
        if table.getn(strayTransports) > 0 then
            local dropPoint = pos
            dropPoint[1] = dropPoint[1] + Random(-3, 3)
            dropPoint[3] = dropPoint[3] + Random(-3, 3)
            IssueTransportUnload(strayTransports, dropPoint)
            WaitSeconds(10)
            local strayTransports = {}
            for k,v in platoonUnits do
                local parent = v:GetParent()
                if parent and EntityCategoryContains(categories.TRANSPORTFOCUS, parent) then
                    table.insert(strayTransports, parent)
                    break
                end
            end
            if table.getn(strayTransports) > 0 then
                local MAIN = aiBrain.BuilderManagers.MAIN
                if MAIN then
                    dropPoint = MAIN.Position
                    IssueTransportUnload(strayTransports, dropPoint)
                    WaitSeconds(30)
                end
            end
            self.UsingTransport = false
            AIUtils.ReturnTransportsToPool(strayTransports, true)
            platoonUnits = self:GetPlatoonUnits()
        end


            --Disband platoon if it's all air units, so they can be picked up by another platoon
            local mySurfaceThreat = AIAttackUtils.GetSurfaceThreatOfUnits(self)
            if mySurfaceThreat == 0 and AIAttackUtils.GetAirThreatOfUnits(self) > 0 then
                self:PlatoonDisband()
                return
            end

            local cmdQ = {}
            -- fill cmdQ with current command queue for each unit
            for k,v in platoonUnits do
                if not v.Dead then
                    local unitCmdQ = v:GetCommandQueue()
                    for cmdIdx,cmdVal in unitCmdQ do
                        table.insert(cmdQ, cmdVal)
                        break
                    end
                end
            end

            -- if we're on our final push through to the destination, and we find a unit close to our destination
            local closestTarget = self:FindClosestUnit('attack', 'enemy', true, categories.ALLUNITS)
            local nearDest = false
            local oldPathSize = table.getn(self.LastAttackDestination)
            if self.LastAttackDestination then
                nearDest = oldPathSize == 0 or VDist3(self.LastAttackDestination[oldPathSize], pos) < 20
            end

            -- if we're near our destination and we have a unit closeby to kill, kill it
            if table.getn(cmdQ) <= 1 and closestTarget and VDist3(closestTarget:GetPosition(), pos) < 20 and nearDest then
                self:StopAttack()
                if PlatoonFormation != 'No Formation' then
                    --self:SetPlatoonFormationOverride('AttackFormation')
                    IssueFormAttack(platoonUnits, closestTarget, PlatoonFormation, 0)
                else
                    IssueAttack(platoonUnits, closestTarget)
                end
                cmdQ = {1}
            -- if we have nothing to do, try finding something to do
            elseif table.getn(cmdQ) == 0 then
                self:StopAttack()
                cmdQ = AIAttackUtils.AIPlatoonSquadAttackVector(aiBrain, self)
                stuckCount = 0
            -- if we've been stuck and unable to reach next marker? Ignore nearby stuff and pick another target
        elseif self.LastPosition and VDist2Sq(self.LastPosition[1], self.LastPosition[3], pos[1], pos[3]) < (self.PlatoonData.StuckDistance or 8) then
            stuckCount = stuckCount + 1
            if stuckCount >= 2 then
                self:StopAttack()
                self.LastAttackDestination = {}
                cmdQ = AIAttackUtils.AIPlatoonSquadAttackVector( aiBrain, self )
                stuckCount = 0
            end
        else
            stuckCount = 0
        end

        self.LastPosition = pos
            --else
                -- wait a little longer if we're stuck so that we have a better chance to move
                WaitSeconds(Random(5,11) + 2 * stuckCount)
        end
    end,

    AttackSCTAForceAI = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()

        -- get units together
        if not self:GatherUnits() then
            return
        end

        -- Setup the formation based on platoon functionality

        local enemy = aiBrain:GetCurrentEnemy()

        local platoonUnits = self:GetPlatoonUnits()
        local numberOfUnitsInPlatoon = table.getn(platoonUnits)
        local oldNumberOfUnitsInPlatoon = numberOfUnitsInPlatoon
        local stuckCount = 0

        self.PlatoonAttackForce = true
        -- formations have penalty for taking time to form up... not worth it here
        -- maybe worth it if we micro
        --self:SetPlatoonFormationOverride('GrowthFormation')
        local PlatoonFormation = self.PlatoonData.UseFormation or 'NoFormation'
        if aiBrain:PlatoonExists(self) and numberOfUnitsInPlatoon < 10 then
        self:SetPlatoonFormationOverride(PlatoonFormation)
        end

        while aiBrain:PlatoonExists(self) do
            local pos = self:GetPlatoonPosition() -- update positions; prev position done at end of loop so not done first time

            -- if we can't get a position, then we must be dead
            if not pos then
                break
            end


            -- if we're using a transport, wait for a while
            if self.UsingTransport then
                WaitSeconds(4)
                continue
            end

            -- pick out the enemy
            if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy().Result == "defeat" then
                aiBrain:PickEnemyLogic()
            end
            platoonUnits = self:GetPlatoonUnits()
            numberOfUnitsInPlatoon = table.getn(platoonUnits)
            if aiBrain:PlatoonExists(self) and numberOfUnitsInPlatoon < 10 then
                self:MergeWithNearbyPlatoonsSCTA('AttackSCTAForceAI', 5)
            end

            if (oldNumberOfUnitsInPlatoon != numberOfUnitsInPlatoon) then
                self:StopAttack()
                if aiBrain:PlatoonExists(self) and numberOfUnitsInPlatoon < 15 then
                self:SetPlatoonFormationOverride(PlatoonFormation)
                end
            end
            oldNumberOfUnitsInPlatoon = numberOfUnitsInPlatoon

            -- deal with lost-puppy transports
            local strayTransports = {}
            for k,v in platoonUnits do
                if EntityCategoryContains(categories.TRANSPORTFOCUS, v) then
                    table.insert(strayTransports, v)
                end
            end
            if table.getn(strayTransports) > 0 then
                local dropPoint = pos
                dropPoint[1] = dropPoint[1] + Random(-3, 3)
                dropPoint[3] = dropPoint[3] + Random(-3, 3)
                IssueTransportUnload(strayTransports, dropPoint)
                WaitSeconds(10)
                local strayTransports = {}
                for k,v in platoonUnits do
                    local parent = v:GetParent()
                    if parent and EntityCategoryContains(categories.TRANSPORTFOCUS, parent) then
                        table.insert(strayTransports, parent)
                        break
                    end
                end
                if table.getn(strayTransports) > 0 then
                    local MAIN = aiBrain.BuilderManagers.MAIN
                    if MAIN then
                        dropPoint = MAIN.Position
                        IssueTransportUnload(strayTransports, dropPoint)
                        WaitSeconds(30)
                    end
                end
                self.UsingTransport = false
                AIUtils.ReturnTransportsToPool(strayTransports, true)
                platoonUnits = self:GetPlatoonUnits()
            end


            --Disband platoon if it's all air units, so they can be picked up by another platoon
            local mySurfaceThreat = AIAttackUtils.GetSurfaceThreatOfUnits(self)
            if mySurfaceThreat == 0 and AIAttackUtils.GetAirThreatOfUnits(self) > 0 then
                self:PlatoonDisband()
                return
            end

            local cmdQ = {}
            -- fill cmdQ with current command queue for each unit
            for k,v in platoonUnits do
                if not v.Dead then
                    local unitCmdQ = v:GetCommandQueue()
                    for cmdIdx,cmdVal in unitCmdQ do
                        table.insert(cmdQ, cmdVal)
                        break
                    end
                end
            end

            -- if we're on our final push through to the destination, and we find a unit close to our destination
            local closestTarget = self:FindClosestUnit('attack', 'enemy', true, categories.ALLUNITS)
            local nearDest = false
            local oldPathSize = table.getn(self.LastAttackDestination)
            if self.LastAttackDestination then
                nearDest = oldPathSize == 0 or VDist3(self.LastAttackDestination[oldPathSize], pos) < 20
            end

            -- if we're near our destination and we have a unit closeby to kill, kill it
            if table.getn(cmdQ) <= 1 and closestTarget and VDist3(closestTarget:GetPosition(), pos) < 20 and nearDest then
                self:StopAttack()
                if PlatoonFormation != 'No Formation' then
                    --self:SetPlatoonFormationOverride('AttackFormation')
                    IssueFormAttack(platoonUnits, closestTarget, PlatoonFormation, 0)
                else
                    IssueAttack(platoonUnits, closestTarget)
                end
                cmdQ = {1}
            -- if we have nothing to do, try finding something to do
            elseif table.getn(cmdQ) == 0 then
                self:StopAttack()
                cmdQ = AIAttackUtils.AIPlatoonSquadAttackVector(aiBrain, self)
                stuckCount = 0
            -- if we've been stuck and unable to reach next marker? Ignore nearby stuff and pick another target
        elseif self.LastPosition and VDist2Sq(self.LastPosition[1], self.LastPosition[3], pos[1], pos[3]) < (self.PlatoonData.StuckDistance or 8) then
            stuckCount = stuckCount + 1
            if stuckCount >= 2 then
                self:StopAttack()
                self.LastAttackDestination = {}
                cmdQ = AIAttackUtils.AIPlatoonSquadAttackVector( aiBrain, self )
                stuckCount = 0
            end
        else
            stuckCount = 0
        end

        self.LastPosition = pos
            --else
                -- wait a little longer if we're stuck so that we have a better chance to move
                WaitSeconds(Random(5,11) + 2 * stuckCount)
        end
    end,

    SCTAReturnToBaseAI = function(self)
        local aiBrain = self:GetBrain()
        
        if not aiBrain:PlatoonExists(self) or not self:GetPlatoonPosition() then
            return
        end
        
        local bestBase = false
        local bestBaseName = ""
        local bestDistSq = 999999999
        local platPos = self:GetPlatoonPosition()

        for baseName, base in aiBrain.BuilderManagers do
            local distSq = VDist2Sq(platPos[1], platPos[3], base.Position[1], base.Position[3])

            if distSq < bestDistSq then
                bestBase = base
                bestBaseName = baseName
                bestDistSq = distSq    
            end
        end

        if bestBase then
            AIAttackUtils.GetMostRestrictiveLayer(self)
            local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, self.MovementLayer, self:GetPlatoonPosition(), bestBase.Position, 200)
            IssueClearCommands(self)
            
            if path then
                local pathLength = table.getn(path)
                for i=1, pathLength-1 do
                    self:MoveToLocation(bestBase.Position, false)  
                end 
            end
            self:MoveToLocation(bestBase.Position, false)  

            local oldDistSq = 0
            while aiBrain:PlatoonExists(self) do
                WaitSeconds(10)
                platPos = self:GetPlatoonPosition()
                local distSq = VDist2Sq(platPos[1], platPos[3], bestBase.Position[1], bestBase.Position[3])
                if distSq < 10 then
                    self:PlatoonDisband()
                    return
                end
                if (distSq - oldDistSq) < 5 then
                    break
                end
                oldDistSq = distSq      
            end
        end
        self:PlatoonDisband()
    end,

    
    HuntAILABSCTA = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local target
        local blip
        local hadtarget = false
        local basePosition = false

        if self.PlatoonData.LocationType and self.PlatoonData.LocationType != 'NOTMAIN' then
            basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
        else
            local platoonPosition = self:GetPlatoonPosition()
            if platoonPosition then
                basePosition = aiBrain:FindClosestBuilderManagerPosition(self:GetPlatoonPosition())
            end
        end

        if not basePosition then
            return
        end

        while aiBrain:PlatoonExists(self) do
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.ENGINEER - categories.COMMAND)
            if not target then
                WaitSeconds(1)
                return self:SCTALabAI()
            end
            if target and target:GetFractionComplete() == 1 then
                local EcoThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'Economy')
                --LOG("Air threat: " .. airThreat)
                local SurfaceThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'AntiSurface') - EcoThreat
                --LOG("AntiAir threat: " .. antiAirThreat)
                if SurfaceThreat < 1.5 then
                    blip = target:GetBlip(armyIndex)
                    self:Stop()
                    self:AttackTarget(target)
                    hadtarget = true
                end
           elseif not target and hadtarget then
                --DUNCAN - move back to base
                local position = AIUtils.RandomLocation(basePosition[1],basePosition[3])
                self:Stop()
                self:MoveToLocation(position, false)
                hadtarget = false
            end
            WaitSeconds(5) --DUNCAN - was 5
        end
    end,

    SCTALabAI = function(self)
        AIAttackUtils.GetMostRestrictiveLayer(self)

        local aiBrain = self:GetBrain()
        local scout = self:GetPlatoonUnits()[1]
        local target
        local structure
        -- build scoutlocations if not already done.
        if not aiBrain.InterestList then
            aiBrain:BuildScoutLocations()
        end

        --If we have cloaking (are cybran), then turn on our cloaking
        --DUNCAN - Fixed to use same bits

        while not scout.Dead do
            --Head towards the the area that has not had a scout sent to it in a while
            local targetData = false

            --For every scouts we send to all opponents, send one to scout a low pri area.
            if aiBrain.IntelData.HiPriScouts < aiBrain.NumOpponents and table.getn(aiBrain.InterestList.HighPriority) > 0 then
                targetData = aiBrain.InterestList.HighPriority[1]
                aiBrain.IntelData.HiPriScouts = aiBrain.IntelData.HiPriScouts + 1
                targetData.LastScouted = GetGameTimeSeconds()

                aiBrain:SortScoutingAreas(aiBrain.InterestList.HighPriority)

            elseif table.getn(aiBrain.InterestList.LowPriority) > 0 then
                targetData = aiBrain.InterestList.LowPriority[1]
                aiBrain.IntelData.HiPriScouts = 0
                targetData.LastScouted = GetGameTimeSeconds()

                aiBrain:SortScoutingAreas(aiBrain.InterestList.LowPriority)
            else
                --Reset number of scoutings and start over
                aiBrain.IntelData.HiPriScouts = 0
            end

            --Is there someplace we should scout?
            if targetData then
                --Can we get there safely?
                local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, self.MovementLayer, scout:GetPosition(), targetData.Position, 400) --DUNCAN - Increase threatwieght from 100

                IssueClearCommands(self)

                if path then
                    local pathLength = table.getn(path)
                    for i=1, pathLength-1 do
                        self:MoveToLocation(path[i], false)
                    end
                end

                self:MoveToLocation(targetData.Position, false)

                --Scout until we reach our destination
                while not scout.Dead and not scout:IsIdleState() do
                    target = self:FindClosestUnit('Attack', 'Enemy', true, categories.ENGINEER - categories.COMMAND)
                    structure = self:FindClosestUnit('Attack', 'Enemy', true, categories.ENERGYPRODUCTION - categories.WALL - categories.MOBILE)
                    if target and self.PlatoonData.Lab then
                        WaitSeconds(1)
                        return self:SCTALabType()
                    elseif structure and self.PlatoonData.AllTerrain then
                        WaitSeconds(1)
                        return self:SCTAArtyHuntAI()
                    else
                        WaitSeconds(2.5)
                    end
                end
            end
            WaitSeconds(1)
        end
    end,

    HuntAirAISCTA = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local target
        local blip
        local hadtarget = false
        local basePosition = false

        if self.PlatoonData.LocationType and self.PlatoonData.LocationType != 'NOTMAIN' then
            --LOG('*SCTAEXPANSIONTA', self.PlatoonData.LocationType)
            basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
        else
            local platoonPosition = self:GetPlatoonPosition()
            if platoonPosition then
                basePosition = aiBrain:FindClosestBuilderManagerPosition(self:GetPlatoonPosition())
            end
        end

        if not basePosition then
            return
        end

        while aiBrain:PlatoonExists(self) do
            if EntityCategoryContains(categories.BOMBER, self) then
                target = self:FindClosestUnit('Attack', 'Enemy', true, categories.MOBILE * categories.ENGINEER - categories.COMMAND)
                else 
                target = self:FindClosestUnit('Attack', 'Enemy', true, categories.MOBILE * (categories.AIR + categories.ENGINEER) - categories.COMMAND)
            end
            if not target then
                WaitSeconds(1)
                return self:SCTALabAI()
            end
            if target and target:GetFractionComplete() == 1 then
                local airThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'Economy')
                --LOG("Air threat: " .. airThreat)
                local antiAirThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'AntiAir') - airThreat
                --LOG("AntiAir threat: " .. antiAirThreat)
                if antiAirThreat < 1.5 then
                    blip = target:GetBlip(armyIndex)
                    self:Stop()
                    self:AttackTarget(target)
                    hadtarget = true
                end
           elseif not target and hadtarget then
                --DUNCAN - move back to base
                local position = AIUtils.RandomLocation(basePosition[1],basePosition[3])
                self:Stop()
                self:MoveToLocation(position, false)
                hadtarget = false
            end
            WaitSeconds(5) --DUNCAN - was 5
        end
    end,

    InterceptorAISCTA = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local target
        local blip
        local hadtarget = false
        local basePosition = false
        if data.Stealth then
            local econ = aiBrain:GetEconomyStoredRatio('ENERGY')
            if econ.EnergyStorageRatio < 0.2 then
                WaitSeconds(5)
                self:PlatoonDisband()
                return
            end
        end
        if self.PlatoonData.LocationType and self.PlatoonData.LocationType != 'NOTMAIN' then
            --LOG('*SCTAEXPANSIONTA', locationType)
            basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
        else
            local platoonPosition = self:GetPlatoonPosition()
            if platoonPosition then
                basePosition = aiBrain:FindClosestBuilderManagerPosition(self:GetPlatoonPosition())
            end
        end

        if not basePosition then
            return
        end

        while aiBrain:PlatoonExists(self) do
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.AIR * categories.ANTIAIR)
            if not target then
                target = self:FindClosestUnit('Attack', 'Enemy', true, categories.AIR * categories.MOBILE)
            end
            if target and target:GetFractionComplete() == 1 then
                local airThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'Air')
                --LOG("Air threat: " .. airThreat)
                local antiAirThreat = aiBrain:GetThreatAtPosition(table.copy(target:GetPosition()), 1, true, 'AntiAir') - airThreat
                --LOG("AntiAir threat: " .. antiAirThreat)
                if antiAirThreat < 1.5 then
                    blip = target:GetBlip(armyIndex)
                    self:Stop()
                    self:AttackTarget(target)
                    hadtarget = true
                end
           elseif not target and hadtarget then
                --DUNCAN - move back to base
                local position = AIUtils.RandomLocation(basePosition[1],basePosition[3])
                self:Stop()
                self:MoveToLocation(position, false)
                hadtarget = false
            end
            WaitSeconds(5) --DUNCAN - was 5
        end
    end,

    BomberAISCTA = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local data = self.PlatoonData
        local target
        while aiBrain:PlatoonExists(self) do
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.MOBILE * categories.LAND - categories.COMMAND)
            if target then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AttackTarget(target)
                --DUNCAN - added to try and stop AI getting stuck.
                local position = AIUtils.RandomLocation(target:GetPosition()[1],target:GetPosition()[3])
                self:MoveToLocation(position, false)
            end
            WaitSeconds(17)
        end
    end,

    ---Treating Spider and Climbing Kbots as Air Unit
    SCTAArtyHuntAI = function(self)
        self:Stop()
        local aiBrain = self:GetBrain()
        local armyIndex = aiBrain:GetArmyIndex()
        local structure
        local blip
        local hadtarget = false
        local basePosition = false

        if self.PlatoonData.LocationType and self.PlatoonData.LocationType != 'NOTMAIN' then
            basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
        else
            local platoonPosition = self:GetPlatoonPosition()
            if platoonPosition then
                basePosition = aiBrain:FindClosestBuilderManagerPosition(self:GetPlatoonPosition())
            end
        end

        if not basePosition then
            return
        end

        while aiBrain:PlatoonExists(self) do
            structure = self:FindClosestUnit('Attack', 'Enemy', true, categories.ENERGYPRODUCTION - categories.WALL - categories.MOBILE)
            if not structure then
                WaitSeconds(1)
                return self:SCTALabAI()
            end
            if structure and structure:GetFractionComplete() == 1 then
                local EcoThreat = aiBrain:GetThreatAtPosition(table.copy(structure:GetPosition()), 1, true, 'Economy')
                --LOG("Air threat: " .. airThreat)
                local SurfaceThreat = aiBrain:GetThreatAtPosition(table.copy(structure:GetPosition()), 1, true, 'AntiSurface') - EcoThreat
                --LOG("AntiAir threat: " .. antiAirThreat)
                if SurfaceThreat < 1.5 then
                    blip = structure:GetBlip(armyIndex)
                    self:Stop()
                    self:AttackTarget(structure)
                    hadtarget = true
                end
           elseif not structure and hadtarget then
                --DUNCAN - move back to base
                local position = AIUtils.RandomLocation(basePosition[1],basePosition[3])
                self:Stop()
                self:MoveToLocation(position, false)
                hadtarget = false
            end
            WaitSeconds(5) --DUNCAN - was 5
        end
    end,

    SCTAEngineerTypeAI = function(self)
        AIAttackUtils.GetMostRestrictiveLayer(self)
        
        if self.MovementLayer == 'Air' then 
            return self:EngineerBuildAISCTAAir() 
        elseif self.MovementLayer == 'Land' then
            return self:EngineerBuildAISCTA()
        else
            return self:EngineerBuildAISCTANaval()
        end
    end,

    SCTALabType = function(self)
        AIAttackUtils.GetMostRestrictiveLayer(self)
        
        if self.MovementLayer == 'Air' then 
            return self:HuntAirAISCTA() 
        else
            return self:HuntAILABSCTA()
        end
    end,

    SCTAReclaimAI = function(self)
            self:Stop()
            local brain = self:GetBrain()
            local locationType = self.PlatoonData.LocationType
            local data = self.PlatoonData
            local createTick = GetGameTick()
            local oldClosest
            local units = self:GetPlatoonUnits()
            local eng = units[1]
            if not eng then
                self:PlatoonDisband()
                return
            end
            --LOG('*SCTAEXPANSIONTA', locationType)
            --eng.BadReclaimables = eng.BadReclaimables or {}
    
            while brain:PlatoonExists(self) do
                local ents = TAutils.TAAIGetReclaimablesAroundLocation(brain, locationType) or {}
                local pos = self:GetPlatoonPosition()
    
                if not ents[1] or not pos then
                    WaitTicks(1)
                    self:PlatoonDisband()
                    return
                end
    
                local reclaim = {}
                local needEnergy = brain:GetEconomyStoredRatio('ENERGY') < 0.5
    
                for k,v in ents do
                    if not IsProp(v) then continue end
                    if not needEnergy or v.MaxEnergyReclaim then
                        local rpos = v:GetCachePosition()
                        table.insert(reclaim, {entity=v, pos=rpos, distance=VDist2(pos[1], pos[3], rpos[1], rpos[3])})
                    end
                end
    
                IssueClearCommands(units)
                table.sort(reclaim, function(a, b) return a.distance < b.distance end)
    
                local recPos = nil
                local closest = {}
                for i, r in reclaim  do
                    if (eng:CanPathTo (r.pos) and data.Terrain) or not data.Terrain then
                        IssueReclaim(units, r.entity)
                        if i > 10 then break end
                   end
                end
    
                local reclaiming = not eng:IsIdleState()
                local max_time = self.PlatoonData.ReclaimTime
    
                while reclaiming do
                    WaitSeconds(5)
    
                    if eng:IsIdleState() or (max_time and (GetGameTick() - createTick)*10 > max_time) then
                        reclaiming = false
                    end
                end
                WaitSeconds(10)
                self:PlatoonDisband()
            end
        end,
}