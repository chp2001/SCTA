WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset aibrain.lua' )

SCTAAIBrainClass = AIBrain
AIBrain = Class(SCTAAIBrainClass) {

    AddBuilderManagers = function(self, position, radius, baseName, useCenter)
        -- Only use this with AI-Uveso
         if not self.SCTAAI then
             return SCTAAIBrainClass.AddBuilderManagers(self, position, radius, baseName, useCenter)
         end
         self.BuilderManagers[baseName] = {
             FactoryManager = FactoryManager.CreateFactoryBuilderManager(self, baseName, position, radius, useCenter),
             PlatoonFormManager = PlatoonFormManager.CreatePlatoonFormManager(self, baseName, position, radius, useCenter),
             EngineerManager = EngineerManager.CreateEngineerManager(self, baseName, position, radius),
             MassConsumption = {
                 Resources = {Units = {}, Drain = 0, },
                 Units = {Units = {}, Drain = 0, },
                 Defenses = {Units = {}, Drain = 0, },
                 Upgrades = {Units = {}, Drain = 0, },
                 Engineers = {Units = {}, Drain = 0, },
                 TotalDrain = 0,
             },
             BuilderHandles = {},
             Position = position,
             BaseType = Scenario.MasterChain._MASTERCHAIN_.Markers[baseName].type or 'MAIN',
         }
         self.NumBases = self.NumBases + 1
     end,

    OnCreateAI = function(self, planName)
        SCTAAIBrainClass.OnCreateAI(self, planName)
        local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
        --LOG('Oncreate')
        if string.find(per, 'scta') then
            --LOG('* AI-SCTA: This is SCTA')
            self.SCTAAI = true

        end
    end,

}