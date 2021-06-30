TAPlatoonBuilder = PlatoonBuilder
PlatoonBuilder = Class(TAPlatoonBuilder) {
    CalculatePriority = function(self, builderManager)
    if not self.Brain.SCTAAI then
        return TAPlatoonBuilder.CalculatePriority(self, builderManager)
    end
    --LOG('*TAAlter1', builder)
    --LOG('*TAAlter1C', self.Brain.SCTAAI)
    ---LOG('*TAAlter1Brain', self.Brain.SCTAAI)
    --self.Value = (self.OriginalPriority/5)
    self.PriorityAltered = false
    --LOG('*TAAlter1Plat', self.BuilderData.Value)
    --LOG('*TAAlter2Plat', self.Value)
    if Builders[self.BuilderName].PriorityFunction then
        --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
        local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
        local Val = self.OriginalPriority/10 
        --LOG('*TAAlter', newPri)
        if newPri != self.Priority then
                if newPri == 0 then
                    self.Priority = 0
                else
                    self.Priority = newPri + Val
                    --LOG('*TAAlterHuzzah', self.Priority)
                end    
            self.PriorityAltered = true
        end
        --LOG('New Priority '..self.BuilderName..' - '..self.Priority)
    end
    return self.PriorityAltered
end,
}


--[[TAEngineerBuilder = EngineerBuilder
EngineerBuilder = Class(TAEngineerBuilder) {
    
    CalculatePriority = function(self, builderManager)
    if not self.Brain.SCTAAI then
        return TAEngineerBuilder.CalculatePriority(self, builderManager)
    end
    --LOG('*TAAlter1', builder)
    LOG('*TAAlter1C', self.Brain.SCTAAI)
    ---LOG('*TAAlter1Brain', self.Brain.SCTAAI)
    self.PriorityAltered = false
    LOG('*TAAlter1', self)
    LOG('*TAAlter2', self.Value)
    if Builders[self.BuilderName].PriorityFunction then
        --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
        local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
        ---local Val = Builders[self.BuilderName].Value 
        LOG('*TAAlter', self.Value)
        if newPri != self.Priority then
                if NewPri > 0 then
                    self.Priority = newPri + (self.Value or 0)
                else 
                    self.Priority = 0
                end    
            self.PriorityAltered = true
        end
        --LOG('New Priority '..self.BuilderName..' - '..self.Priority)
    end
    return self.PriorityAltered
end,
}]]

TAFactoryBuilder = FactoryBuilder
FactoryBuilder = Class(TAFactoryBuilder) {
  CalculatePriority = function(self, builderManager)
    if not self.Brain.SCTAAI then
        return TAFactoryBuilder.CalculatePriority(self, builderManager)
    end
    --LOG('*TAAlter1C', self.Brain.SCTAAI)
    ---LOG('*TAAlter1Brain', self.Brain.SCTAAI)
    self.PriorityAltered = false
    --LOG('*TAAlter1Plat', self.BuilderData.Value)
    --LOG('*TAAlter2Plat', self.Value)
    if Builders[self.BuilderName].PriorityFunction then
        --LOG('Calculate new Priority '..self.BuilderName..' - '..self.Priority)
        local newPri = Builders[self.BuilderName]:PriorityFunction(self.Brain)
        local Val = self.OriginalPriority/10 
        --LOG('*TAAlter', newPri)
        if newPri != self.Priority then
                if newPri == 0 then
                    self.Priority = 0
                else
                    self.Priority = newPri + Val
                    --LOG('*TAAlterHuzzah', self.Priority)
                end    
            self.PriorityAltered = true
        end
        --LOG('New Priority '..self.BuilderName..' - '..self.Priority)
    end
    return self.PriorityAltered
end,
}
