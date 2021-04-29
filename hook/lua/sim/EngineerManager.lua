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

    AssignEngineerTask = function(self, unit)
        LOG('*Brain', self.Brain.SCTAAI)
        LOG('*Who', unit)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.AssignEngineerTask(self, unit)
        end
                if EntityCategoryContains(categories.LAND * (categories.TECH1 + categories.TECH2) - categories.FIELDENGINEER, unit) then
                    self:TAAssignEngineerTask(unit, 'Land')
                    return
                elseif EntityCategoryContains(categories.AIR * (categories.TECH1 + categories.TECH2), unit) then
                    self:TAAssignEngineerTask(unit, 'Air')
                    return
                elseif EntityCategoryContains(categories.NAVAL * (categories.TECH1 + categories.TECH2), unit) then
                    self:TAAssignEngineerTask(unit, 'Sea')
                    return
                elseif EntityCategoryContains(categories.TECH3 + categories.SUBCOMMANDER, unit) then
                    self:TAAssignEngineerTask(unit, 'T3')
                    return
                elseif EntityCategoryContains(categories.FIELDENGINEER, unit) then
                    self:TAAssignEngineerTask(unit, 'Field')
                    return
                else 
                    self:TAAssignEngineerTask(unit, 'Command')
                    return
                end
        end,
    

        EngineerAlreadyExists = function(self, Engineer)
            for k,v in self.EngineerList do
                if v == Engineer then
                    return true
                end
            end
            return false
        end,
        --[[EngineerAlreadyExists = function(self, Engineer)
            for k,v in self.EngineerList do
                if v == Engineer then
                    return true
                end
            end
            return false
        end,

    GetEngineer = function(self, unit, bType)
        for k,v in unit do
            LOG('*ThisWork2', bType)
             v.BuilderManagerData = { EngineerManager = self, BuilderType = bType, }
            end
        self:TAAssignEngineerTask(unit, bType)
    end,]]


    TAAssignEngineerTask = function(self, unit, bType)
        --LOG('+ AssignEngineerTask')
        if unit.UnitBeingAssist or unit.UnitBeingBuilt then
            self:DelayAssign(unit, 50)
            return
        end
        if not self:EngineerAlreadyExists(unit) then
            table.insert(self.EngineerList, bType)
        end
        unit.DesiresAssist = false
        unit.NumAssistees = nil
        unit.MinNumAssistees = nil
        unit.bType = bType
        if self.AssigningTask then
            self:DelayAssign(unit, 50)
            return
        else
            self.AssigningTask = true
        end
        LOG('*ThisWork2', unit)
        LOG('*Builder', bType)
        local builder = self:GetHighestBuilder(unit.bType, {unit})
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

            builder:StoreHandle(hndl)
            self.AssigningTask = false
            return
        end
        self.AssigningTask = false
        self:DelayAssign(unit, 50)
    end,
}