local taUnitClass = Unit
Unit = Class(taUnitClass) {
    OnStopBeingCaptured = function(self, captor)
        taUnitClass.OnStopBeingCaptured(self, captor)
        local aiBrain = self:GetAIBrain()
        if aiBrain.SCTAAI then
            self:Kill()
        end
    end,
}