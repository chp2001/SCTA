#ARM Metal Maker - Converts Energy into Metal
#ARMMAKR
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

ARMMAKR = Class(TAStructure) {
	OnProductionUnpaused = function(self)
		TAStructure.Unfold(self)
		TAStructure.OnProductionUnpaused(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
	end,


	OnProductionPaused = function(self)
		TAStructure.OnProductionPaused(self)
		TAStructure.Fold(self)
		self:SetMaintenanceConsumptionInactive()
		self:PlayUnitSound('Deactivate')		
	end,
}

TypeClass = ARMMAKR