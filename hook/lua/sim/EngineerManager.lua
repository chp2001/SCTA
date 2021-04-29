WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset EngineerManager.lua' )

SCTAEngineerManager = EngineerManager
EngineerManager = Class(SCTAEngineerManager, BuilderManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            return SCTAEngineerManager.Create(self, brain, lType, location, radius)
        end
        BuilderManager.Create(self,brain)
        if not lType or not location or not radius then
            error('*PLATOOM FORM MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end
        ---LOG('IEXIST')
        self.Location = location
        self.Radius = radius
        self.LocationType = lType
        self.ConsumptionUnits = {
            Engineers = { Category = categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
            Fabricators = { Category = categories.MASSFABRICATION * categories.STRUCTURE, Units = {}, UnitsList = {}, Count = 0, },
            Intel = { Category = categories.STRUCTURE * ( categories.SONAR + categories.RADAR + categories.OMNI), Units = {}, UnitsList = {}, Count = 0, },
            MobileIntel = { Category = categories.MOBILE - categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
        }
        self.EngineerList = {}
        ---LOG(self.ConsumptionUnits)
        local builderTypes = { 'Air', 'Land', 'Sea', 'T3', 'Field', 'Command', }
        for k,v in builderTypes do
            self:AddBuilderType(v)
        end

    end,

    GetEngineerFactionIndex = function(self, engineer)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.GetEngineerFactionIndex(self, engineer)
        end
        if EntityCategoryContains(categories.ARM, engineer) then
            return 6
        elseif EntityCategoryContains(categories.CORE, engineer) then
            return 7
        end
    end,
    
    LowMass = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.LowMass(self)
        end
        local econ = AIUtils.AIGetEconomyNumbers(self.Brain)
        local pauseVal = 0
        self.Brain.LowMassMode = true
        pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.DEFENSE)

        if pauseVal != true then
            pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.FACTORY * (categories.TECH2 + categories.TECH3 + categories.GATE))
        end

        if pauseVal != true then
           ---pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ExperimentalCheck )
        end

        if pauseVal != true then
            --pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.MOBILE - categories.EXPERIMENTAL )
        end

        if pauseVal != true then
            --pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.STRUCTURE - categories.MASSEXTRACTION - categories.ENERGYPRODUCTION - categories.FACTORY - categories.EXPERIMENTAL )
        end

        self:ForkThread(self.LowMassRepeatThread)
    end,

    LowEnergy = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.LowEnergy(self)
        end
        local econ = AIUtils.AIGetEconomyNumbers(self.Brain)
        local pauseVal = 0
        
        self.Brain.LowEnergyMode = true
        
        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Fabricators, econ, pauseVal, self.MassDrainCheck)
        end
        
        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.MobileIntel, econ, pauseVal)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.ALLUNITS - categories.ENERGYPRODUCTION - categories.MASSPRODUCTION)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Intel, econ, pauseVal)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Fabricators, econ, pauseVal)
        end

       if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.ALLUNITS - categories.ENERGYPRODUCTION)
        end 
        
        self:ForkThread( self.LowEnergyRepeatThread )
    end,

    RestoreEnergy = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.RestoreEnergy(self)
        end
        self.Brain.LowEnergyMode = false

        self:EnableGroup(self.ConsumptionUnits.Intel)

        self:EnableGroup(self.ConsumptionUnits.MobileIntel)
        
        self:EnableGroup(self.ConsumptionUnits.Fabricators)

        self:EnableGroup(self.ConsumptionUnits.Engineers)
    end,

    RemoveUnit = function(self, unit)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.RemoveUnit(self, unit)
        end
        local guards = unit:GetGuards()
        for k,v in guards do
            if not v.Dead and v.AssistPlatoon then
                if self.Brain:PlatoonExists(v.AssistPlatoon) then
                    v.AssistPlatoon:ForkThread(v.AssistPlatoon.EconAssistBody)
                else
                    v.AssistPlatoon = nil
                end
            end
        end

        local found = false
        for k,v in self.ConsumptionUnits do
            if EntityCategoryContains(v.Category, unit) then
                for num,sUnit in v.Units do
                    if sUnit.Unit == unit then
                        table.remove(v.Units, num)
                        table.remove(v.UnitsList, num)
                        v.Count = v.Count - 1
                        found = true
                        break
                    end
                end
            end
            if found then
                break
            end
        end
        for k,v in self.EngineerList do
            if v == engineer then
                self.EngineerList[k] = nil
            end
        end
        for k,v in self.EngineerList do
            if not v.Dead then
                return
            end
        end
        self.Brain:RemoveConsumption(self.LocationType, unit)
    end,

    SetupEngineerCallbacks = function(self, unit, bType)
        self:SetupEngineeringUnits({unit}, bType)
        self:AssignEngineerTask(unit, bType)
    end,

    SetupEngineeringUnits = function(self, unit, bType)
        for k,v in unit do
              if not v.BuilderManagerData then
                v.BuilderManagerData = { EngineerManager = self, BuilderType = bType, }
                unit.BuilderManagerData.EngineerManager = self
                unit.BuilderManagerData.LocationType = self.LocationType
              end
              self:AssignEngineerTask(unit, bType)
        end
    end,

    TADelayAssign = function(manager, unit, bType)
        if unit.TAForkedEngineerTask then
            KillThread(unit.TAForkedEngineerTask)
        end
        unit.TAForkedEngineerTask = unit:ForkThread(manager.TAWait, manager, delaytime or 10)
    end,

    TADelayAssignBody = function( unit, manager, bType)
        WaitSeconds(1)
        if not unit:IsDead() then
            manager:AssignEngineerTask(unit, bType)
        end
        unit.DelayThread = nil
    end,

    AddUnit = function(self, unit, dontAssign)
        --LOG('+ AddUnit')
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.AddUnit(self, unit, dontAssign)
        end
        for k,v in self.ConsumptionUnits do
            if EntityCategoryContains(v.Category, unit) then
                table.insert(v.Units, { Unit = unit, Status = true })
                table.insert(v.UnitsList, unit)
                v.Count = v.Count + 1

                if not unit.BuilderManagerData then
                    unit.BuilderManagerData = {}
                end
                unit.BuilderManagerData.EngineerManager = self
                unit.BuilderManagerData.LocationType = self.LocationType

                if not unit.BuilderManagerData.CallbacksSetup then
                    unit.BuilderManagerData.CallbacksSetup = true
                    -- Callbacks here
                    local deathFunction = function(unit)
                        unit.BuilderManagerData.EngineerManager:RemoveUnit(unit)
                    end

                    import('/lua/scenariotriggers.lua').CreateUnitDestroyedTrigger(deathFunction, unit)

                    if EntityCategoryContains(categories.ENGINEER - categories.STATIONASSISTPOD, unit) then
                        local unitConstructionFinished = function(unit, finishedUnit)
                                                    -- Call function on builder manager; let it handle the finish of work
                                                    local aiBrain = unit:GetAIBrain()
                                                    local engManager = aiBrain.BuilderManagers[unit.BuilderManagerData.LocationType].EngineerManager
                                                    if engManager then
                                                        engManager:UnitConstructionFinished(unit, finishedUnit)
                                                    end
                        end
                        import('/lua/ScenarioTriggers.lua').CreateUnitBuiltTrigger(unitConstructionFinished, unit, categories.ALLUNITS)

                        local unitConstructionStarted = function(unit, unitBeingBuilt)
                                                    local aiBrain = unit:GetAIBrain()
                                                    local engManager = aiBrain.BuilderManagers[unit.BuilderManagerData.LocationType].EngineerManager
                                                    if engManager then
                                                        engManager:UnitConstructionStarted(unit, unitBeingBuilt)
                                                    end
                        end
                        import('/lua/ScenarioTriggers.lua').CreateStartBuildTrigger(unitConstructionStarted, unit, categories.ALLUNITS)
                    end
                end
                return
            end
        end
    end,
    EngineerConstructionFinished = function(self, unit)
        if not self:EngineerAlreadyExists(unit) then
            table.insert(self.EngineerList, unit)
            if EntityCategoryContains(categories.LAND * (categories.TECH1 + categories.TECH2) - categories.FIELDENGINEER, unit) then
                self:SetupEngineerCallbacks(unit, 'Land')
            elseif EntityCategoryContains(categories.AIR * (categories.TECH1 + categories.TECH2), unit) then
                self:SetupEngineerCallbacks(unit, 'Air')
            elseif EntityCategoryContains(categories.NAVAL * (categories.TECH1 + categories.TECH2), unit) then
                self:SetupEngineerCallbacks(unit,'Sea')
            elseif EntityCategoryContains(categories.TECH3 + categories.SUBCOMMANDER, unit) then
                self:SetupEngineerCallbacks(unit, 'T3')
            elseif EntityCategoryContains(categories.FIELDENGINEER, unit) then
                self:SetupEngineerCallbacks(unit, 'Field')
            else
                self:SetupEngineerCallbacks(unit, 'Command')
            end
        end
    end,

    TAWait = function(unit, manager, ticks, bType)
        LOG('*ThisWork2', bType)
        coroutine.yield(ticks)
        if not unit.Dead then
            manager:AssignEngineerTask(unit, bType)
        end
    end,

    TAEngineerWaiting = function(manager, unit, bType)
        coroutine.yield(50)
        if not unit.Dead then
            manager:AssignEngineerTask(unit, bType)
        end
    end,
    EngineerAlreadyExists = function(self, finishedUnit)
        for k,v in self.EngineerList do
            if v == Engineer then
                return true
            end
        end
        return false
    end,

    UnitConstructionFinished = function(self, unit, finishedUnit)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.UnitConstructionFinished(self, unit, finishedUnit)
        end
        if EntityCategoryContains( categories.FACTORY * categories.STRUCTURE, finishedUnit ) then
            self.Brain.BuilderManagers[self.LocationType].FactoryManager:AddFactory(finishedUnit)
        end
        if EntityCategoryContains( categories.ENGINEER, unit ) then
            self.Brain.BuilderManagers[self.LocationType].EngineerManager:EngineerConstructionFinished(finishedUnit)
        end
        self:AddUnit(finishedUnit)
        local guards = unit:GetGuards()
        for k,v in guards do
            if not v:IsDead() and v.AssistPlatoon then
                if self.Brain:PlatoonExists(v.AssistPlatoon) then
                    v.AssistPlatoon:ForkThread(v.AssistPlatoon.EconAssistBody)
                else
                    v.AssistPlatoon = nil
                end
            end
        end
        self.Brain:RemoveConsumption(self.LocationType, unit)
    end,

    AddBuilder = function(self, builderData, locationType)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.AddBuilder(self, builderData, locationType)
        end
        local newBuilder = Builder.CreateEngineerBuilder(self.Brain, builderData, locationType)
        if newBuilder:GetBuilderType() == 'Any' then
            for k,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, k)
            end
            elseif newBuilder:GetBuilderType() == 'ACU' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'Command')
                self:AddInstancedBuilder(newBuilder, 'T3')
            end
            elseif newBuilder:GetBuilderType() == 'NotACU' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3')
                self:AddInstancedBuilder(newBuilder, 'Air')
                self:AddInstancedBuilder(newBuilder, 'Land')
            end
            elseif newBuilder:GetBuilderType() == 'OmniLand' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3')
                self:AddInstancedBuilder(newBuilder, 'Land')
            end
            elseif newBuilder:GetBuilderType() == 'OmniAir' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3')
                self:AddInstancedBuilder(newBuilder, 'Air')
            end
        else
            self:AddInstancedBuilder(newBuilder)
        end
        return newBuilder
    end,

    TAForkEngineerTask = function(manager, unit, bType)
        if unit.TAForkedEngineerTask then
            KillThread(unit.TAForkedEngineerTask)
            unit.TAForkedEngineerTask = unit:ForkThread(manager.TAWait, manager, 3, bType)
        else
            unit.TAForkedEngineerTask = unit:ForkThread(manager.TAWait, manager, 20, bType)
        end
    end,
    
    TATaskFinished = function(manager, unit, bType)
        if VDist3(manager.Location, unit:GetPosition()) > manager.Radius and not EntityCategoryContains(categories.COMMAND, unit) then
            manager:ReassignUnit(unit)
        else
            manager:TAForkEngineerTask(unit, bType)
        end
    end,

    AssignEngineerTask = function(self, unit, bType)
        --LOG('+ AssignEngineerTask')
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.AssignEngineerTask(self, unit)
        end
        if unit.UnitBeingAssist or unit.UnitBeingBuilt then
            self:TADelayAssign(unit, 50, bType)
            return
        end
    
        unit.DesiresAssist = false
        unit.NumAssistees = nil
        unit.MinNumAssistees = nil
    
        if self.AssigningTask then
            self:DelayAssign(unit, 50)
            return
        else
            self.AssigningTask = true
        end
    
        local builder = self:GetHighestBuilder(bType, {unit})
        if builder then
            -- Fork off the platoon here
            local template = self:GetEngineerPlatoonTemplate(builder:GetPlatoonTemplate())
            local hndl = self.Brain:MakePlatoon(template[1], template[2])
            self.Brain:AssignUnitsToPlatoon(hndl, {unit}, 'support', 'none')
            unit.PlatoonHandle = hndl
    
            --if EntityCategoryContains(categories.COMMAND, unit) then
            --    LOG('*AI DEBUG: ARMY '..self.Brain.Nickname..': Engineer Manager Forming - '..builder.BuilderName..' - Priority: '..builder:GetPriority())
            --end
    
            --LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Engineer Manager Forming - ',repr(builder.BuilderName),' - Priority: ', builder:GetPriority())
            hndl.PlanName = template[2]
    
            --If we have specific AI, fork that AI thread
            if builder:GetPlatoonAIFunction() then
                hndl:StopAI()
                local aiFunc = builder:GetPlatoonAIFunction()
                hndl:ForkAIThread(import(aiFunc[1])[aiFunc[2]])
            end
            if builder:GetPlatoonAIPlan() then
                hndl.PlanName = builder:GetPlatoonAIPlan()
                hndl:SetAIPlan(hndl.PlanName)
            end
    
            --If we have additional threads to fork on the platoon, do that as well.
            if builder:GetPlatoonAddPlans() then
                for papk, papv in builder:GetPlatoonAddPlans() do
                    hndl:ForkThread(hndl[papv])
                end
            end
    
            if builder:GetPlatoonAddFunctions() then
                for pafk, pafv in builder:GetPlatoonAddFunctions() do
                    hndl:ForkThread(import(pafv[1])[pafv[2]])
                end
            end
    
            if builder:GetPlatoonAddBehaviors() then
                for pafk, pafv in builder:GetPlatoonAddBehaviors() do
                    hndl:ForkThread(import('/lua/ai/AIBehaviors.lua')[pafv])
                end
            end
    
            hndl.Priority = builder:GetPriority()
            hndl.BuilderName = builder:GetBuilderName()
    
            hndl:SetPlatoonData(builder:GetBuilderData(self.LocationType))
    
            if hndl.PlatoonData.DesiresAssist then
                unit.DesiresAssist = hndl.PlatoonData.DesiresAssist
            else
                unit.DesiresAssist = true
            end
    
            if hndl.PlatoonData.NumAssistees then
                unit.NumAssistees = hndl.PlatoonData.NumAssistees
            end
    
            if hndl.PlatoonData.MinNumAssistees then
                unit.MinNumAssistees = hndl.PlatoonData.MinNumAssistees
            end
    
            --[[if hndl.PlatoonData.BuilderType == unit.BuilderType then
                unit.BuilderType = hndl.PlatoonData.BuilderType
            end]]
    
            builder:StoreHandle(hndl)
            self.AssigningTask = false
            return
        end
        self.AssigningTask = false
        self:TADelayAssign(unit, 50, bType)
    end,
}