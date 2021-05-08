WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset EngineerManager.lua' )

SCTAEngineerManager = EngineerManager
EngineerManager = Class(SCTAEngineerManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            return SCTAEngineerManager.Create(self, brain, lType, location, radius)
        end
        BuilderManager.Create(self,brain)
        if not lType or not location or not radius then
            error('*PLATOOM FORM MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end
        local builderTypes = { 'AirTA', 'LandTA', 'SeaTA', 'T3TA', 'FieldTA', 'Command', }
        for k,v in builderTypes do
            self:AddBuilderType(v)
        end
        ---LOG('IEXIST')
        self.Location = location
        self.Radius = radius
        self.LocationType = lType
        self.ConsumptionUnits = {
            Engineers = { Category = categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
            Fabricators = { Category = categories.MASSFABRICATION * categories.STRUCTURE, Units = {}, UnitsList = {}, Count = 0, },
            Intel = { Category = categories.STRUCTURE * ( categories.SONAR + categories.RADAR + categories.OMNI) - categories.FACTORY, Units = {}, UnitsList = {}, Count = 0, },
            MobileIntel = { Category = categories.MOBILE - categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
        }
        self.EngineerList = {}
        ---LOG(self.ConsumptionUnits)

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
    end,

    LowEnergy = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.LowEnergy(self)
        end
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
                self:AddInstancedBuilder(newBuilder, 'T3TA')
            end
            elseif newBuilder:GetBuilderType() == 'NotACU' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3TA')
                self:AddInstancedBuilder(newBuilder, 'AirTA')
                self:AddInstancedBuilder(newBuilder, 'LandTA')
            end
            elseif newBuilder:GetBuilderType() == 'OmniLand' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3TA')
                self:AddInstancedBuilder(newBuilder, 'LandTA')
            end
            elseif newBuilder:GetBuilderType() == 'OmniAir' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'T3TA')
                self:AddInstancedBuilder(newBuilder, 'AirTA')
            end
            elseif newBuilder:GetBuilderType() == 'OmniNaval' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'SeaTA')
                self:AddInstancedBuilder(newBuilder, 'T3TA')
            end
        else
            self:AddInstancedBuilder(newBuilder)
        end
        return newBuilder
    end,

    AssignEngineerTask = function(self, unit)
        --LOG('*Brain', self.Brain.SCTAAI)
        --LOG('*Who', unit)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.AssignEngineerTask(self, unit)
        end      
                if unit:GetBlueprint().Economy.Land then
                    self:TAAssignEngineerTask(unit, 'LandTA')
                    return
                elseif unit:GetBlueprint().Economy.Air then
                    self:TAAssignEngineerTask(unit, 'AirTA')
                    return
                elseif unit:GetBlueprint().Economy.Naval then
                    self:TAAssignEngineerTask(unit, 'SeaTA')
                    return
                elseif unit:GetBlueprint().Economy.TECH3 then
                    self:TAAssignEngineerTask(unit, 'T3TA')
                    return
                elseif unit:GetBlueprint().Economy.Command then
                    self:TAAssignEngineerTask(unit, 'Command')
                    return
                else 
                    self:TAAssignEngineerTask(unit, 'FieldTA')
                    return
                end
        end,


    TAAssignEngineerTask = function(self, unit, bType)
        ---LOG('*Brain', self.Brain.SCTAAI)   
        if unit.UnitBeingBuilt or unit.unitBuilding then
            return
        end

        unit.DesiresAssist = false
        unit.NumAssistees = nil
        unit.MinNumAssistees = nil
        unit.bType = bType
        if self.AssigningTask then
            return
        end
        local builder = self:GetHighestBuilder(unit.bType, {unit})
        if builder then
            self.AssigningTask = true
            -- Fork off the platoon here
            local template = self:GetEngineerPlatoonTemplate(builder:GetPlatoonTemplate())
            local hndl = self.Brain:MakePlatoon(template[1], template[2])
            self.Brain:AssignUnitsToPlatoon(hndl, {unit}, 'support', 'none')
            unit.PlatoonHandle = hndl

            --if EntityCategoryContains(categories.COMMAND, unit) then
            --LOG('*AI DEBUG: ARMY '..self.Brain.Nickname..': Engineer Manager Forming - '..builder.BuilderName..' - Priority: '..builder:GetPriority())
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
            end

            if hndl.PlatoonData.NumAssistees then
                unit.NumAssistees = hndl.PlatoonData.NumAssistees
            end


            builder:StoreHandle(hndl)
            self.AssigningTask = nil
            return
        end
        self.AssigningTask = nil
        self:DelayAssign(unit, 10)
    end,
}