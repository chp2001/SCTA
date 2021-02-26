do
    local taFactoryBuilderManager = FactoryBuilderManager
      
    FactoryBuilderManager = Class(taFactoryBuilderManager) {
        GetFactoryFaction = function(self, factory)
            if not self.Brain.SCTAAI then
                return taFactoryBuilderManager.GetFactoryFaction(self, factory)
            end
            if EntityCategoryContains(categories.ARM, factory) then
                return 'Arm'
            elseif EntityCategoryContains(categories.CORE, factory) then
                return 'Core'
            end
            return false
        end,
    }
    
    
    end