WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset PlatoonForm.lua' )

SCTAPlatoonFormManager = PlatoonFormManager
PlatoonFormManager = Class(SCTAPlatoonFormManager, BuilderManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            LOG('*template2', brain.SCTAAI)
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
        
        --[[local builderTypes = {'Land', 'Air', 'Sea', 'Engineer', 'Structure'}
        for _,v in builderTypes do
			self:AddBuilderType(v)
		end]]
        local builderTypes = {'Air', 'Land', 'Sea', 'Scout', 'Structure', 'Engineer', 'Other'}
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
        BuilderManager.ManagerLoopBody(self,builder,bType)
        --LOG('*template', template[1])
        local template = self:GetPlatoonTemplate(builder:GetPlatoonTemplate())
            if self:GetHighestBuilder(template[3], {template}) and self.Brain.BuilderManagers[self.LocationType] and builder.Priority >= 1 and builder:CheckInstanceCount() then
            ---LOG('*builder', self.Brain.SCTAAI)
            local personality = self.Brain:GetPersonality()
            local poolPlatoon = self.Brain:GetPlatoonUniquelyNamed('ArmyPool')
            --LOG('*template1', template[1])
            builder:FormDebug()
            local radius = self.Radius
            if builder:GetFormRadius() then radius = builder:GetFormRadius() end
            if not template or not self.Location or not radius then
                if type(template) != 'table' or type(template[1]) != 'string' or type(template[2]) != 'string' then
                    WARN('*Platoon Form: Could not find template named: ' .. builder:GetPlatoonTemplate())
                    return
                end
                WARN('*Platoon Form: Could not find template named: ' .. builder:GetPlatoonTemplate())
                return
            end
            local formIt = poolPlatoon:CanFormPlatoon(template, personality:GetPlatoonSize(), self.Location, radius) 
            if formIt and builder:GetBuilderStatus() then
                --LOG('*templatetype', template[3])
                --LOG('*template2', template[1])
                local hndl = poolPlatoon:FormPlatoon(template, personality:GetPlatoonSize(), self.Location, radius)
                #LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager Forming - ',repr(builder.BuilderName),': Location = ',self.LocationType)
                #LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager - Platoon Size = ', table.getn(hndl:GetPlatoonUnits()))
                hndl.PlanName = template[2]
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

                #If we have additional threads to fork on the platoon, do that as well.
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
                end
            end
        end,
}