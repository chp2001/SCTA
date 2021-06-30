WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset PlatoonForm.lua' )
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
SCTAPlatoonFormManager = PlatoonFormManager
PlatoonFormManager = Class(SCTAPlatoonFormManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            --LOG('*self.template2', brain.SCTAAI)
            return SCTAPlatoonFormManager.Create(self, brain, lType, location, radius)
        end
        if not brain.FormManagerSCTAI then
            ForkThread(brain.FormManagerSCTA,brain)
        end
        BuilderManager.Create(self,brain)
        --LOG('IEXIST2')
        if not lType or not location or not radius then
            error('*PLATOOM FORM MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end
        ---self.Terrain = self.ThreatType

        self.Location = location
        self.Radius = radius
        ---self.OriginalRadius = self.Radius
        self.LocationType = lType
        --LOG('*TALocation', lType)
        if string.find(lType, 'Naval') then
            self.Naval = true
            --LOG('*TALocation3', self.LocationType)
            elseif lType == 'MAIN' then
            self.Main = true
            --LOG('*TALocation2', self.Main)
        end
        --LOG('*TATerrain', self.Naval)
        --LOG('*TATerrain2', self.Radius)
        --LOG('*TATerrain3', self.LocationType)
        local builderTypes = {'AirForm', 'LandForm', 'SeaForm', 'Scout', 'StructureForm', 'Other'}
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
    

    ManagerLoopBody = function(self,builder,bType)
        if not self.Brain.SCTAAI then
            --LOG('*self.template3', self.Brain.SCTAAI)
            return SCTAPlatoonFormManager.ManagerLoopBody(self,builder,bType)
        end
        BuilderManager.ManagerLoopBody(self,builder,bType)
        ---local builder = self:GetHighestBuilder(bType, {builder})
            --local pool = self.Brain:GetPlatoonUniquelyNamed('ArmyPool')
        local aiBrain=self.Brain
        if builder then
            if aiBrain.Naval and bType == 'SeaForm' then 
                
                --LOG('*TATerrain', self.LocationType)
                if aiBrain.SeaForm > 0 then
                    return self:SCTAManagerLoopBody(builder, 'SeaForm')
                end
            end
            if TAPrior.TechEnergyExist >= 75 and (bType == 'StructureForm' or TAPrior.GantryProduction >= 200 and bType == 'Other') then
                if bType == 'StructureForm' then
                
                if aiBrain.StructureForm < 2 then 
                    return self:SCTAManagerLoopBody(builder, bType)
                end
                elseif self.Main and bType == 'Other' then
                    
                    if aiBrain.Other > 0 then
                        return self:SCTAManagerLoopBody(builder, bType)
                    end
                end 
            --LOG('*TATerrain3', self.Main)
            elseif bType == 'LandForm' then 
                
                if aiBrain.LandForm > 0 then
                    return self:SCTAManagerLoopBody(builder, bType)
                end    
            elseif bType == 'AirForm' then 
                
                if aiBrain.AirForm > 0 then
                    return self:SCTAManagerLoopBody(builder, bType)
                end
            elseif bType == 'Scout' then
                
                if aiBrain.Scout > 0 then
                    if not self.Main then
                        return self:SCTAManagerLoopBody(builder, bType)
                    elseif self.Main and TAPrior.UnitProductionT1 >= 75 then 
                        return self:SCTAManagerLoopBody(builder, bType)
                    end
                end
            end
        end
    end,
        
    ----return self:ForkThread(self.SCTAManagerLoopBody

    SCTAManagerLoopBody = function(self,builder,bType)
        --BuilderManager.ManagerLoopBody(self,builder,bType)
        if self.Brain.BuilderManagers[self.LocationType] and builder.Priority >= 1 and builder:CheckInstanceCount() then
                local personality = self.Brain:GetPersonality()
                local poolPlatoon = self.Brain:GetPlatoonUniquelyNamed('ArmyPool')
                local template = self:GetPlatoonTemplate(builder:GetPlatoonTemplate())
                builder:FormDebug()
                local radius = 500
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
                local hndl = poolPlatoon:FormPlatoon(template, personality:GetPlatoonSize(), self.Location, radius)

                --LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager Forming - ',repr(builder.BuilderName),': Location = ',self.LocationType)
                --LOG('*AI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Platoon Form Manager - Platoon Size = ', table.getn(hndl:GetPlatoonUnits()))
                hndl.PlanName = template[2]
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
            end
            --self.Radius = self.OriginalRadius
        end
    end,

}