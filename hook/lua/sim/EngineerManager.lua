SCTAEngineerManager = EngineerManager
EngineerManager = Class(SCTAEngineerManager, BuilderManager) {
    Create = function(self, brain, lType, location, radius)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.Create(self, brain, lType, location, radius)
        end
        BuilderManager.Create(self,brain)
        if not lType or not location or not radius then
            error('*PLATOOM FORM MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end

        self.Location = location
        self.Radius = radius
        self.LocationType = lType
        self.ConsumptionUnits = {
            Engineers = { Category = categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
            Fabricators = { Category = categories.MASSFABRICATION * categories.STRUCTURE, Units = {}, UnitsList = {}, Count = 0, },
            Intel = { Category = categories.STRUCTURE * ( categories.SONAR + categories.RADAR + categories.OMNI), Units = {}, UnitsList = {}, Count = 0, },
            MobileIntel = { Category = categories.MOBILE - categories.ENGINEER, Units = {}, UnitsList = {}, Count = 0, },
        }
        ---LOG(self.ConsumptionUnits)

        self:AddBuilderType('Any')
    end,

    GetEngineerFactionIndex = function(self, engineer)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.GetEngineerFactionIndex(self, engineer)
        end
        if EntityCategoryContains(categories.ARM, engineer) then
            return 6
        elseif EntityCategoryContains(categories.CORE, engineer) then
            return 7
        end
    end,
    
    LowMass = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.LowMass(self)
        end
        local econ = AIUtils.AIGetEconomyNumbers(self.Brain)
        local pauseVal = 0
        self.Brain.LowMassMode = true
        pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.DEFENSE)

        if pauseVal != true then
            pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.FACTORY * (categories.TECH2 + categories.TECH3 + categories.GATE))
        end

        if pauseVal != true then
           ---pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ExperimentalCheck )
        end

        if pauseVal != true then
            --pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.MOBILE - categories.EXPERIMENTAL )
        end

        if pauseVal != true then
            --pauseVal = self:DisableMassGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.STRUCTURE - categories.MASSEXTRACTION - categories.ENERGYPRODUCTION - categories.FACTORY - categories.EXPERIMENTAL )
        end

        self:ForkThread(self.LowMassRepeatThread)
    end,

    LowEnergy = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.LowEnergy(self)
        end
        local econ = AIUtils.AIGetEconomyNumbers(self.Brain)
        local pauseVal = 0
        
        self.Brain.LowEnergyMode = true
        
        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Fabricators, econ, pauseVal, self.MassDrainCheck)
        end
        
        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.MobileIntel, econ, pauseVal)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.ALLUNITS - categories.ENERGYPRODUCTION - categories.MASSPRODUCTION)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Intel, econ, pauseVal)
        end

        if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Fabricators, econ, pauseVal)
        end

       if pauseVal != true then
            pauseVal = self:DisableEnergyGroup(self.ConsumptionUnits.Engineers, econ, pauseVal, self.ProductionCheck, categories.ALLUNITS - categories.ENERGYPRODUCTION)
        end 
        
        self:ForkThread( self.LowEnergyRepeatThread )
    end,

    RestoreEnergy = function(self)
        if not self.Brain.SCTAAI then
            return SCTAEngineerManager.RestoreEnergy(self)
        end
        self.Brain.LowEnergyMode = false

        self:EnableGroup(self.ConsumptionUnits.Intel)

        self:EnableGroup(self.ConsumptionUnits.MobileIntel)
        
        self:EnableGroup(self.ConsumptionUnits.Fabricators)

        self:EnableGroup(self.ConsumptionUnits.Engineers)
    end,
}