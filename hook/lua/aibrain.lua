WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset aibrain.lua' )

SCTAAIBrainClass = AIBrain
AIBrain = Class(SCTAAIBrainClass) {

    AddBuilderManagers = function(self, position, radius, baseName, useCenter)
        -- Only use this with AI-Uveso
         if not self.SCTAAI then
             return SCTAAIBrainClass.AddBuilderManagers(self, position, radius, baseName, useCenter)
         end
         self.BuilderManagers[baseName] = {
             FactoryManager = FactoryManager.CreateFactoryBuilderManager(self, baseName, position, radius, useCenter),
             PlatoonFormManager = PlatoonFormManager.CreatePlatoonFormManager(self, baseName, position, radius, useCenter),
             EngineerManager = EngineerManager.CreateEngineerManager(self, baseName, position, radius),
             MassConsumption = {
                 Resources = {Units = {}, Drain = 0, },
                 Units = {Units = {}, Drain = 0, },
                 Defenses = {Units = {}, Drain = 0, },
                 Upgrades = {Units = {}, Drain = 0, },
                 Engineers = {Units = {}, Drain = 0, },
                 TotalDrain = 0,
             },
             BuilderHandles = {},
             Position = position,
             BaseType = Scenario.MasterChain._MASTERCHAIN_.Markers[baseName].type or 'MAIN',
         }
         self.NumBases = self.NumBases + 1
     end,

    OnCreateAI = function(self, planName)
        SCTAAIBrainClass.OnCreateAI(self, planName)
        local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
        --LOG('Oncreate')
        if string.find(per, 'scta') then
            --LOG('* AI-SCTA: This is SCTA')
            self.SCTAAI = true

        end
    end,

    PBMBuildNumFactories = function (self, template, location, pType, factory)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMBuildNumFactories(self, template, location, pType, factory)
        end
        local retTemplate = table.deepcopy(template)
        local assistFacs = factory[1]:GetGuards()
        table.insert(assistFacs, factory[1])
        local facs = {T1 = 0, T2 = 0, T3 = 0}
        for _, v in assistFacs do
        if EntityCategoryContains(categories.FACTORY * (categories.TECH3 + categories.GATE), v) then
                facs.T3 = facs.T3 + 1
            elseif EntityCategoryContains(categories.TECH2 * categories.FACTORY, v) then
                facs.T2 = facs.T2 + 1
            elseif EntityCategoryContains(categories.FACTORY, v) then
                facs.T1 = facs.T1 + 1
            end
        end

        -- Handle any squads with a specified build quantity
        local squad = 3
        while squad <= table.getn(retTemplate) do
            if retTemplate[squad][2] > 0 then
                local bp = self:GetUnitBlueprint(retTemplate[squad][1])
                local buildLevel = AIBuildUnits.SCTAUnitBuildCheck(bp)
                local remaining = retTemplate[squad][3]
                while buildLevel <= 3 do
                    if facs['T'..buildLevel] > 0 then
                        if facs['T'..buildLevel] < remaining then
                            remaining = remaining - facs['T'..buildLevel]
                            facs['T'..buildLevel] = 0
                            buildLevel = buildLevel + 1
                        else
                            facs['T'..buildLevel] = facs['T'..buildLevel] - remaining
                            buildLevel = 10
                        end
                    else
                        buildLevel = buildLevel + 1
                    end
                end
            end
            squad = squad + 1
        end

        -- Handle squads with programatic build quantity
        squad = 3
        local remainingIds = {T1 = {}, T2 = {}, T3 = {}}
        while squad <= table.getn(retTemplate) do
            if retTemplate[squad][2] < 0 then
                table.insert(remainingIds['T'..AIBuildUnits.SCTAUnitBuildCheck(self:GetUnitBlueprint(retTemplate[squad][1])) ], retTemplate[squad][1])
            end
            squad = squad + 1
        end
        local rTechLevel = 3
        while rTechLevel >= 1 do
            for num, unitId in remainingIds['T'..rTechLevel] do
                for tempRow = 3, table.getn(retTemplate) do
                    if retTemplate[tempRow][1] == unitId and retTemplate[tempRow][2] < 0 then
                        retTemplate[tempRow][3] = 0
                        for fTechLevel = rTechLevel, 3 do
                            retTemplate[tempRow][3] = retTemplate[tempRow][3] + (facs['T'..fTechLevel] * math.abs(retTemplate[tempRow][2]))
                            facs['T'..fTechLevel] = 0
                        end
                    end
                end
            end
            rTechLevel = rTechLevel - 1
        end

        -- Remove any IDs with 0 as a build quantity.
        for i = 1, table.getn(retTemplate) do
            if i >= 3 then
                if retTemplate[i][3] == 0 then
                    table.remove(retTemplate, i)
                end
            end
        end

        return retTemplate
    end,

    PBMAssistGivenFactory = function( self, factories, primary )
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMAssistGivenFactory( self, factories, primary )
        end
        for k,v in factories do
            if not v:IsDead() and not ( v:IsUnitState('Building')) then
                local guarded = v:GetGuardedUnit()
                if not guarded or guarded:GetEntityId() ~= primary:GetEntityId() then
                    IssueFactoryAssist( {v}, primary )
                end
            end
        end
    end,

    PBMSetRallyPoint = function(self, factories, location, rallyLoc, markerType)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMSetRallyPoint(self, factories, location, rallyLoc, markerType)
        end
        if table.getn(factories) > 0 then
            local rally
            local position = factories[1]:GetPosition()
            for facNum, facData in factories do
                if facNum > 1 then
                    position[1] = position[1] + facData:GetPosition()[1]
                    position[3] = position[3] + facData:GetPosition()[3]
                end
            end
            position[1] = position[1] / table.getn(factories)
            position[3] = position[3] / table.getn(factories)
            if not rallyLoc and not location.UseCenterPoint then
                local pnt
                if not markerType then
                    pnt = AIUtils.AIGetClosestMarkerLocation( self, 'Rally Point', position[1], position[3] )
                else
                    pnt = AIUtils.AIGetClosestMarkerLocation( self, markerType, position[1], position[3] )
                end
                if(pnt and table.getn(pnt) == 3) then
                    rally = Vector(pnt[1], pnt[2], pnt[3])
                end
            elseif not rallyLoc and location.UseCenterPoint then
                rally = location.Location
            elseif rallyLoc then
                rally = rallyLoc
            else
                error('*ERROR: PBMSetRallyPoint - Missing Rally Location and Marker Type', 2)
                return false
            end
            if(rally) then
                for k,v in factories do
                    IssueFactoryRallyPoint({v}, rally)
                end
            end
        end
        return true
    end,

    ForceManagerSort = function(self)
        if not self.SCTAAI then
            return SCTAAIBrainClass.ForceManagerSort(self)
        end
        for _, v in self.BuilderManagers do
            v.EngineerManager:SortBuilderList('Any')
            v.FactoryManager:SortBuilderList('KBot')
            v.FactoryManager:SortBuilderList('Vehicle')
            v.FactoryManager:SortBuilderList('Hover')
            v.FactoryManager:SortBuilderList('Land')
            v.FactoryManager:SortBuilderList('Air')
            v.FactoryManager:SortBuilderList('Sea')
            v.PlatoonFormManager:SortBuilderList('Any')
        end
    end,
}