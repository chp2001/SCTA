-- For Platoon debugging. Unremarking the debugline will print all platoons with priority inside game.log
SCTAPlatoonBuilder = PlatoonBuilder
PlatoonBuilder = Class(SCTAPlatoonBuilder) {

    Create = function(self,brain,data,locationType)
       -- Only use this with AI-SCTAAI
        if not brain.SCTAAI then
            return SCTAPlatoonBuilder.Create(self,brain,data,locationType)
        end
        Builder.Create(self,brain,data,locationType)
        --LOG(repr(data.BuilderType)..' - '..repr(data.Priority)..' - '..repr(data.BuilderName)..' - '..repr(data.PlatoonTemplate))
        local verifyDictionary = { 'PlatoonTemplate', }
        for k,v in verifyDictionary do
            if not self:VerifyDataName(v, data) then return false end
        end

        # Setup for instances to be stored inside a table rather than creating new
        self.InstanceCount = {}
        local num = 1
        while num <= (data.InstanceCount or 1) do
            table.insert(self.InstanceCount, { Status = 'Available', PlatoonHandle = false })
            num = num + 1
        end
        return true
    end,

    CalculatePriority = function(self, builderManager)
       -- Only use this with AI-SCTAAI
        if not self.Brain.SCTAAI then
            return SCTAPlatoonBuilder.CalculatePriority(self, builderManager)
        end
        self.PriorityAltered = false
        if Builders[self.BuilderName].PriorityFunction then
            --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
            local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
            if newPri != self.Priority then
                --LOG('* AI-SCTAAI: PlatoonBuilder New Priority:  [[  '..self.Priority..' -> '..newPri..'  ]]  -  '..self.BuilderName..'.')
                self.Priority = newPri
                self.PriorityAltered = true
            end
            --LOG('SCTAPlatoonBuilder New Priority '..self.BuilderName..' - '..self.Priority)
        end
        return self.PriorityAltered
    end,

}

-- For Platoon debugging. Unremarking the debugline will print all platoons with priority inside game.log
SCTAFactoryBuilder = FactoryBuilder
FactoryBuilder = Class(SCTAFactoryBuilder) {

    Create = function(self,brain,data,locationType)
       -- Only use this with AI-SCTAAI
        if not brain.SCTAAI then
            return SCTAFactoryBuilder.Create(self,brain,data,locationType)
        end
        Builder.Create(self,brain,data,locationType)
        --LOG(repr(data.BuilderType)..' - '..repr(data.Priority)..' - '..repr(data.BuilderName)..' - '..repr(data.PlatoonTemplate))
        local verifyDictionary = { 'PlatoonTemplate', }
        for k,v in verifyDictionary do
            if not self:VerifyDataName(v, data) then return false end
        end
        return true
    end,

    CalculatePriority = function(self, builderManager)
       -- Only use this with AI-SCTAAI
        if not self.Brain.SCTAAI then
            return SCTAFactoryBuilder.CalculatePriority(self, builderManager)
        end
        self.PriorityAltered = false
        if Builders[self.BuilderName].PriorityFunction then
            --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
            local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
            if newPri != self.Priority then
                --LOG('* AI-SCTAAI: FactoryBuilder New Priority:  [[  '..self.Priority..' -> '..newPri..'  ]]  -  '..self.BuilderName..'.')
                self.Priority = newPri
                self.PriorityAltered = true
            end
            --LOG('SCTAFactoryBuilder New Priority '..self.BuilderName..' - '..self.Priority)
        end
        return self.PriorityAltered
    end,

}

-- For Platoon debugging. Unremarking the debugline will print all platoons with priority inside game.log
SCTAEngineerBuilder = EngineerBuilder
EngineerBuilder = Class(SCTAEngineerBuilder) {

    Create = function(self,brain,data, locationType)
       -- Only use this with AI-SCTAAI
        if not brain.SCTAAI then
            return SCTAEngineerBuilder.Create(self,brain,data, locationType)
        end
        PlatoonBuilder.Create(self,brain,data, locationType)
        --LOG(repr(data.BuilderType)..' - '..repr(data.Priority)..' - '..repr(data.BuilderName)..' - '..repr(data.PlatoonTemplate))

        self.EconomyCost = { Mass = 0, Energy = 0 }

        return true
    end,

    CalculatePriority = function(self, builderManager)
       -- Only use this with AI-SCTAAI
        if not self.Brain.SCTAAI then
            return SCTAEngineerBuilder.CalculatePriority(self, builderManager)
        end
        self.PriorityAltered = false
        if Builders[self.BuilderName].PriorityFunction then
            --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
            local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
            if newPri != self.Priority then
                --LOG('* AI-SCTAAI: EngineerBuilder New Priority:  [[  '..self.Priority..' -> '..newPri..'  ]]  -  '..self.BuilderName..'.')
                self.Priority = newPri
                self.PriorityAltered = true
            end
            --LOG('SCTAEngineerBuilder New Priority '..self.BuilderName..' - '..self.Priority)
        end
        return self.PriorityAltered
    end,

}
