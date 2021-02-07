do
    local oldFactoryBuilderManager = FactoryBuilderManager
      
    FactoryBuilderManager = Class(oldFactoryBuilderManager) {
        GetFactoryTemplate = function(self, templateName, factory)
            if not self.Brain.SCTAAI then
                return oldFactoryBuilderManager.GetFactoryTemplate(self, factory)
            end
            local templateData = PlatoonTemplates[templateName]
            if not templateData then
                SPEW('*AI WARNING: No templateData found for template '..templateName..'. ')
                return false
            end
            if not templateData.FactionSquads then
                SPEW('*AI ERROR: PlatoonTemplate named: ' .. templateName .. ' does not have a FactionSquads')
                return false
            end
            local template = {
                templateData.Name,
                '',
            }
    
            local faction = self:GetFactoryFaction(factory)
            if faction and templateData.FactionSquads[faction] then
                for k,v in templateData.FactionSquads[faction] do     
                        table.insert(template, v)
                    end
                -- if we don't have a template use a dummy.
            end
            return template
        end,



        GetFactoryFaction = function(self, factory)
            if not self.Brain.SCTAAI then
                return oldFactoryBuilderManager.GetFactoryFaction(self, factory)
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