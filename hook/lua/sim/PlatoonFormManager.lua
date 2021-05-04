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
        self.LocationType= lType
        
        local builderTypes = {'AirForm', 'LandForm', 'SeaForm', 'Scout', 'StructureForm', 'EngineerForm', 'Command', 'Other'}
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
                templateData.BuilderType,
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
        --LOG('*templateP', self.template[3])
        --LOG('*templateO', self.template[1])
        if self.template[3] == 'Scout' then
            return self:SCTAManagerLoopBody(builder, 'Scout')
        elseif self.template[3] == 'LandForm' then
            return self:SCTAManagerLoopBody(builder, 'LandForm')
        elseif self.template[3] == 'AirForm' then
            return self:SCTAManagerLoopBody(builder, 'AirForm')
        elseif self.template[3] == 'SeaForm' then
            return self:SCTAManagerLoopBody(builder, 'SeaForm')
        elseif self.template[3] == 'EngineerForm' then
            return self:SCTAManagerLoopBody(builder, 'EngineerForm')
        elseif self.template[3] == 'Other' then      
            return self:SCTAManagerLoopBody(builder, 'Other')
        elseif self.template[3] == 'StructureForm' then      
            return self:SCTAManagerLoopBody(builder, 'StructureForm')
        else
            return 
        end
    end,

    SCTAManagerLoopBody = function(self,builder,bType)
        --LOG('*template', self.template[1])
        --LOG('*template2', self.template[3])
        ----Builder.Btype = Nil, Btype alone = buildertypes
        --LOG('*template', builder.bType)
        local builder = self:GetHighestBuilder(bType, {self.template})
         if builder and self.Brain.BuilderManagers[self.LocationType] and builder.Priority >= 1 and builder:CheckInstanceCount() then
        ---LOG('*template2', builder.bType)
        --LOG('*templateP2', template[3])
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
            else 
                LOG('IEXIST FAILS', self.template[1])
                LOG('IEXIST FAILS2', self.template[3])
            end
        end
    end,
}