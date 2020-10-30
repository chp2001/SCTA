local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local oldCORARAD = CORARAD

CORARAD = Class(oldCORARAD) {
	OnStopBuild = function(self, unitBeingBuilt)
		 oldCORARAD.OnStopBuild(self, unitBeingBuilt)
		 if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBeingBuilt)
			 self:Destroy()
		 end
	 end,

	 OnFailedToBuild = function(self)
        oldCORARAD.OnFailedToBuild(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
		ChangeState(self, self.OpeningState)
	end,
		
	OnStopBeingBuilt = function(self,builder,layer)
		oldCORARAD.OnStopBeingBuilt(self,builder,layer)
		self:PlayUnitSound('Activate')
		TAutils.registerTargetingFacility(self:GetArmy())
	end,

	OnScriptBitSet = function(self, bit)
		if bit == 3 then
			self:PlayUnitSound('Deactivate')
			TAutils.unregisterTargetingFacility(self:GetArmy())
		end
		oldCORARAD.OnScriptBitSet(self, bit)
	end,

	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			self:PlayUnitSound('Activate')
			TAutils.registerTargetingFacility(self:GetArmy())
		end
		oldCORARAD.OnScriptBitClear(self, bit)
	end,
}

TypeClass = CORARAD