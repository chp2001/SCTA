local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

CORASON = Class(TAStructure) {
	OnCreate = function(self)
		TAStructure.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),	
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		
	end,

	OnIntelDisabled = function(self)
		TAStructure.Fold(self)
		--STOP-SPIN dish around y-axis;
		self.Spinners.dish:SetSpeed(0)
		TAStructure.OnIntelDisabled(self)
		self:PlayUnitSound('Deactivate')
	end,

	OnIntelEnabled = function(self)
		TAStructure.Unfold(self)
		--SPIN dish around y-axis  SPEED <60.01>;
		self.Spinners.dish:SetSpeed(60)
		TAStructure.OnIntelEnabled(self)
		self:PlayUnitSound('Activate')
	end,
}

TypeClass = CORASON
