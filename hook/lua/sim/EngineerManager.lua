do
    local taEngineerManager = EngineerManager
      
    EngineerManager = Class(taEngineerManager) {
    GetEngineerFactionIndex = function(self, engineer)
        if not self.Brain.SCTAAI then
            return taEngineerManager.GetEngineerFactionIndex(self, engineer)
        end
        if EntityCategoryContains(categories.ARM, engineer) then
            return 6
        elseif EntityCategoryContains(categories.CORE, engineer) then
            return 7
        end
    end,

    LowMass = function(self)
        if not self.Brain.SCTAAI then
            return taEngineerManager.LowMass(self)
        end
        local econ = AIUtils.AIGetEconomyNumbers(self.Brain)
        local pauseVal = 0
        self.Brain.LowMassMode = true
        pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.DEFENSE)

        if pauseVal != true then
            pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.FACTORY * (categories.LEVEL2 + categories.LEVEL3))
        end

        if pauseVal != true then
        end

        if pauseVal != true then
        end

        if pauseVal != true then
        end

        self:ForkThread(self.LowMassRepeatThread)
    end,
}

end