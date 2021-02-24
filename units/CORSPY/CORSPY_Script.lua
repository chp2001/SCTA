#ARM SPY - Fast Light Scout Kbot
#CORSPY
#
#Script created by Raevn

local TACloaker = import('/mods/SCTA-master/lua/TAMotion.lua').TACloaker 

CORSPY = Class(TACloaker) {
    OnStopBeingBuilt = function(self, builder, layer)
		TACloaker.OnStopBeingBuilt(self, builder, layer)
		self.Spinners = {
			fork = CreateRotator(self, 'jam', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,

}

TypeClass = CORSPY
