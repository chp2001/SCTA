local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

CORASON = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),	
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		
	end,

	OnIntelDisabled = function(self)
		TAunit.Fold(self)
		--STOP-SPIN dish around y-axis;
		self.Spinners.dish:SetSpeed(0)

		self:SetMaintenanceConsumptionInactive()
		
		TAunit.OnIntelDisabled(self)
		self:PlayUnitSound('Deactivate')
	end,

	OnIntelEnabled = function(self)
		TAunit.Unfold(self)
		--SPIN dish around y-axis  SPEED <60.01>;
		self.Spinners.dish:SetSpeed(60)

		self:SetMaintenanceConsumptionActive()
		
		TAunit.OnIntelEnabled(self)
		self:PlayUnitSound('Activate')
	end,
}

TypeClass = CORASON
