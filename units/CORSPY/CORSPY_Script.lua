#ARM SPY - Fast Light Scout Kbot
#CORSPY
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking

CORSPY = Class(TAWalking) {
    OnStopBeingBuilt = function(self, builder, layer)
		TAWalking.OnStopBeingBuilt(self, builder, layer)
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

	OnIntelDisabled = function(self)
		self:SetMaintenanceConsumptionInactive()
		self:DisableIntel('Cloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
	end,

	OnIntelEnabled = function(self)
		self:SetMaintenanceConsumptionActive()
		self:EnableIntel('Cloak')
		self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
	end,
}

TypeClass = CORSPY
