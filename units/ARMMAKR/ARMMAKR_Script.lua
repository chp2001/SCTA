#ARM Metal Maker - Converts Energy into Metal
#ARMMAKR
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

ARMMAKR = Class(TAunit) {
	OnProductionUnpaused = function(self)
		TAunit.Unfold(self)
		TAunit.OnProductionUnpaused(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
	end,


	OnProductionPaused = function(self)
		TAunit.OnProductionPaused(self)
		TAunit.Fold(self)
		self:SetMaintenanceConsumptionInactive()
		self:PlayUnitSound('Deactivate')		
	end,
}

TypeClass = ARMMAKR