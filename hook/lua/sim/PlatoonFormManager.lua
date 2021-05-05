WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset PlatoonForm.lua' )

SCTAPlatoonFormManager = PlatoonFormManager
PlatoonFormManager = Class(SCTAPlatoonFormManager, BuilderManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            --LOG('*template2', brain.SCTAAI)
            return SCTAPlatoonFormManager.Create(self, brain, lType, location, radius)
        end
        BuilderManager.Create(self,brain)
        --LOG('IEXIST2')
        if not lType or not location or not radius then
            error('*PLATOOM FORM MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end

        self.Location = location
        self.Radius = radius
        self.LocationType = lType
        
        local builderTypes = {'AirForm', 'LandForm', 'SeaForm', 'Scout', 'StructureForm', 'EngineerForm', 'CommandTA', 'Other'}
        for _,v in builderTypes do
			self:AddBuilderType(v)
		end
        self.BuilderCheckInterval = 5
    end,

   AddBuilder = function(self, builderData, locationType, builderType)
        if not self.Brain.SCTAAI then
            return SCTAPlatoonFormManager.AddBuilder(self, builderData, locationType, builderType)
        end
        local newBuilder = Builder.CreatePlatoonBuilder(self.Brain, builderData, locationType)
        if newBuilder:GetBuilderType() == 'Any' then
            for k,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, k)
            end
        else
            self:AddInstancedBuilder(newBuilder)
        end
        return newBuilder
    end,

    GetPlatoonTemplate = function(self, templateName)
        if not self.Brain.SCTAAI then
            --LOG('*template3', self.Brain.SCTAAI)
            return SCTAPlatoonFormManager.GetPlatoonTemplate(self, templateName)
        end
        local templateData = PlatoonTemplates[templateName]
        if not templateData then
            error('*AI ERROR: Invalid platoon template named - ' .. templateName)
        end
        local template = {}
        if templateData.GlobalSquads then
            template = {
                templateData.Name,
                templateData.Plan,
                templateData.PlatoonType,
                unpack(templateData.GlobalSquads)
            }
        else
            template = {
                templateData.Name,
                templateData.Plan,
            }
            for k,v in templateData.FactionSquads do
                table.insert(template, unpack(v))
            end
        end
        return template
    end,

    ManagerLoopBody = function(self,builder,bType)
        if not self.Brain.SCTAAI then
            --LOG('*template3', self.Brain.SCTAAI)
            return SCTAPlatoonFormManager.ManagerLoopBody(self,builder,bType)
        end
        self.template = self:GetPlatoonTemplate(builder:GetPlatoonTemplate())
        BuilderManager.ManagerLoopBody(self, builder, self.template[3])
        --LOG('*TALocation', self.LocationType)
        bType = self.template[3]
        if bType == 'Scout' then
            builder = self:GetHighestBuilder('Scout', {self.template})
            return
        elseif bType == 'LandForm' then
            builder = self:GetHighestBuilder('LandForm', {self.template})
            return
        elseif bType == 'AirForm' then
            builder = self:GetHighestBuilder('AirForm', {self.template})
            return
        elseif bType == 'SeaForm' and self.LocationType == 'Naval Area' then
            builder = self:GetHighestBuilder('SeaForm', {self.template})
            return
        elseif bType == 'EngineerForm' then
            builder = self:GetHighestBuilder('EngineerForm', {self.template})
            return
        elseif bType == 'Other' then
            builder = self:GetHighestBuilder('Other', {self.template})     
            return
        elseif bType == 'CommandTA' and self.LocationType == 'MAIN' then
            builder = self:GetHighestBuilder('CommandTA', {self.template})     
            return
        elseif bType == 'StructureForm' then
            builder = self:GetHighestBuilder('StructureForm', {self.template})
            return
        end
    end,
        SCTAManagerLoopBody = function(self,builder,bType)
        if builder and self.Brain.BuilderManagers[self.LocationType] and builder.Priority >= 1 and builder:CheckInstanceCount() then
        --LOG('*TAtemplate2', builder)
        --LOG('*TAtemplateP2', bType)
        
                ---LOG('*builder', self.Brain.SCTAAI)
            local personality = self.Brain:GetPersonality()
            local poolPlatoon = self.Brain:GetPlatoonUniquelyNamed('ArmyPool')
            --LOG('*template1', template[1])
            builder:FormDebug()
            local radius = self.Radius
            if builder:GetFormRadius() then radius = builder:GetFormRadius() end
            if not self.template or not self.Location or not radius then
                if type(self.template) != 'table' or type(self.template[1]) != 'string' or type(self.template[2]) != 'string' then
                    WARN('*Platoon Form: Could not find template named: ' .. builder:GetPlatoonTemplate())
                    return
                end
                WARN('*Platoon Form: Could not find template named: ' .. builder:GetPlatoonTemplate())
                return
            end
            local formIt = poolPlatoon:CanFormPlatoon(self.template, personality:GetPlatoonSize(), self.Location, radius) 
            if formIt and builder:GetBuilderStatus() then
                --LOG('*templatetype', template[3])
                --LOG('*template2', template[1])
                local hndl = poolPlatoon:FormPlatoon(self.template, personality:GetPlatoonSize(), self.Location, radius)
                #LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager Forming - ',repr(builder.BuilderName),': Location = ',self.LocationType)
                #LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager - Platoon Size = ', table.getn(hndl:GetPlatoonUnits()))
                hndl.PlanName = self.template[2]
                #If we have specific AI, fork that AI thread
                if builder:GetPlatoonAIFunction() then
                    hndl:StopAI()
                    local aiFunc = builder:GetPlatoonAIFunction()
                    hndl:ForkAIThread(import(aiFunc[1])[aiFunc[2]])
                end
                if builder:GetPlatoonAIPlan() then
                    hndl.PlanName = builder:GetPlatoonAIPlan()
                    hndl:SetAIPlan(hndl.PlanName)
                end
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

                hndl.Priority = builder.Priority
                hndl.BuilderName = builder.BuilderName

                hndl:SetPlatoonData(builder:GetBuilderData(self.LocationType))

                for k,v in hndl:GetPlatoonUnits() do
                    if not v.PlatoonPlanName then
                        v.PlatoonHandle = hndl
                    end
                end
                builder:StoreHandle(hndl)
            --else 
                --LOG('*TAIEXIST FAILS', self.template[1])
                ----('*TAIEXIST FAILS2', self.template[3])
            end
        end
    end,
}