WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset aibrain.lua' )

local SCTAAIBrainClass = AIBrain
AIBrain = Class(SCTAAIBrainClass) {

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