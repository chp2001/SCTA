#ARM SPY - Fast Light Scout Kbot
#ARMSPY
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter

ARMSPY = Class(TACounter) {
    OnStopBeingBuilt = function(self, builder, layer)
		TACounter.OnStopBeingBuilt(self, builder, layer)
        self:SetMaintenanceConsumptionInactive()
		self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,
}

TypeClass = ARMSPY
