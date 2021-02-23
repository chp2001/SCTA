local SCTAUnitClass = Unit
Unit = Class(SCTAUnitClass) {
    OnStopBeingCaptured = function(self, captor)
        SCTAUnitClass.OnStopBeingCaptured(self, captor)
        local aiBrain = self:GetAIBrain()
        if aiBrain.SCTAAI then
            self:Kill()
        end
    end,
}