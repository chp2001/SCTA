#ARM SPY - Fast Light Scout Kbot
#ARMSPY
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking

ARMSPY = Class(TAWalking) {
    OnStopBeingBuilt = function(self, builder, layer)
		TAWalking.OnStopBeingBuilt(self, builder, layer)
        self:SetScriptBit('RULEUTC_IntelToggle', true)
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

TypeClass = ARMSPY
