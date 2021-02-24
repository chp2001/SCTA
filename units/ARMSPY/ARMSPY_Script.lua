#ARM SPY - Fast Light Scout Kbot
#ARMSPY
#
#Script created by Raevn

local TACloaker = import('/mods/SCTA-master/lua/TAMotion.lua').TACloaker

ARMSPY = Class(TACloaker) {
    OnStopBeingBuilt = function(self, builder, layer)
		TACloaker.OnStopBeingBuilt(self, builder, layer)
        self:SetMaintenanceConsumptionInactive()
		self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,
}

TypeClass = ARMSPY
