WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset PlatoonForm.lua' )
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
SCTAPlatoonFormManager = PlatoonFormManager
PlatoonFormManager = Class(SCTAPlatoonFormManager) {
    Create = function(self, brain, lType, location, radius)
        if not brain.SCTAAI then
            --LOG('*self.template2', brain.SCTAAI)
            return SCTAPlatoonFormManager.Create(self, brain, lType, location, radius)
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

    ManagerLoopBody = function(self,builder,bType)
        if not self.Brain.SCTAAI then
            --LOG('*self.template3', self.Brain.SCTAAI)
            return SCTAPlatoonFormManager.ManagerLoopBody(self,builder,bType)
        end
        --('*TAbtype', bType)
        --LOG('*TALtype', self.Naval)
        --builder = self:GetHighestBuilder(bType, {builder})
        BuilderManager.ManagerLoopBody(self,builder,bType)
        

    ----return self:ForkThread(self.SCTAManagerLoopBody

    SCTAManagerLoopBody = function(self,builder,bType)
        --LOG('*TAself.template2', builder)
        --LOG('*TAself.templateP2', bType)
                ---LOG('*builder', self.Brain.SCTAAI)
            --LOG('*self.template1', self.template[1])
        --builder = self:GetHighestBuilder(bType, {builder})
        --BuilderManager.ManagerLoopBody(self,builder,bType)
        --[[if bType == 'AirForm' then
            self.Radius = 500
        elseif bType == 'StructureForm' then
            self.Radius = 1000
        end]]
        if bType == 'AirForm' or bType =='StructureForm' then 
            self.Radius = 1000
        elseif bType == 'LandForm' or bType == 'Scout' then 
            self.Radius = 100 
        end
            local radius = self.Radius
            if builder:GetFormRadius() then radius = builder:GetFormRadius() end
            if not self.template or not self.Location or not radius then
                if type(self.template) != 'table' or type(self.template[1]) != 'string' or type(self.template[2]) != 'string' then
                    WARN('*Platoon Form: Could not find self.template named: ' .. builder:GetPlatoontemplate())
                    return
                end
                WARN('*Platoon Form: Could not find self.template named: ' .. builder:GetPlatoontemplate())
                return
            end
            local formIt = self.poolPlatoon:CanFormPlatoon(self.template, self.personality:GetPlatoonSize(), self.Location, radius) 
            if builder:GetBuilderStatus() then
                --LOG('*self.templatetype', self.template[3])
                --LOG('*self.template2', self.template[1])
                local hndl = self.poolPlatoon:FormPlatoon(self.template, self.personality:GetPlatoonSize(), self.Location, radius)
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
                --LOG('*TAIEXIST FAILS1', builder.BuilderName)
                --LOG('*TAIEXIST FAILS2', self.template[3])
        end
    end,

}

--self.PriorityFunction = builder.PriorityFunction or 1
        --LOG('*TAPrior', builder.PriorityFunction)
        --LOG('*TAbtypeBui', builder)
        builder = self:GetHighestBuilder(bType, {builder})
        if self.Brain.BuilderManagers[self.LocationType] and builder.Priority >= 1 and builder:CheckInstanceCount() then
            --LOG('*TAbtypePrior1', builder.BuilderName, builder.Priority)
            self.personality = self.Brain:GetPersonality()
            self.poolPlatoon = self.Brain:GetPlatoonUniquelyNamed('ArmyPool')
            self.template = self:GetPlatoonTemplate(builder:GetPlatoonTemplate())            
            --_ALERT('*TAbtypePrior2', builder.Priority)
            ----if builder:CheckBuilderConditions(self.Brain) then
            --self.template = self:GetPlatoonself.template(builder:GetPlatoonself.template())
        --bType = self.template[3]
        --_ALERT('*TAbtype2', bType)
        --LOG('*TAbtype3', self.template[3])
         --return
        builder:FormDebug()
        if self.Naval and bType == 'SeaForm' then
            self:SCTAManagerLoopBody(builder, 'SeaForm')
        elseif self.Main then
            --LOG('*TAbtype2', self.Main)
            if bType == 'CommandTA' then
                    --LOG('*TATtype2', bType)
                ForkThread(self.SCTAManagerLoopBody, self, builder, 'CommandTA')
            elseif bType == 'Scout' and TAPrior.LessThanTime >= 125 then
                    --LOG('*TATtype2MS', bType)
                ForkThread(self.SCTAManagerLoopBody, self, builder, 'Scout')
            else
                return
            end
        --[[elseif not self.Naval then
               if bType == 'LandForm' then
                ForkThread(self.SCTAManagerLoopBody, self, builder, 'LandForm')
                elseif bType == 'EngineerForm' then
                    ForkThread(self.SCTAManagerLoopBody, self, builder, 'EngineerForm')
                elseif bType == 'AirForm' then
                    ForkThread(self.SCTAManagerLoopBody, self, builder, 'AirForm')
                elseif bType == 'Other' and TAPrior.UnitProductionField >= 200 then
                    self:SCTAManagerLoopBody(builder, 'Other')
                elseif bType == 'StructureForm' and TAPrior.UnitProduction >= 75 then
                    self:SCTAManagerLoopBody(builder, 'StructureForm')
                elseif bType == 'Scout' and not self.Main then
                    --LOG('*TATtype2ES', self.Main)
                    self:SCTAManagerLoopBody(builder, 'Scout')
                else
                    return
                end
            end
        end
    end,]]