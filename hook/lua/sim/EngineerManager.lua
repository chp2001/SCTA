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
}