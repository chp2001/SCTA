local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

CORASON = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),	
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		
	end,


	OpeningState = State {
		Main = function(self)
			TACloser.Unfold(self)
			self:EnableIntel('Sonar')
			self:PlayUnitSound('Activate')
			self.intelIsActive = true
	--SPIN dish around y-axis  SPEED <60.01>;
	self.Spinners.dish:SetSpeed(60)
	ChangeState(self, self.IdleOpenState)
end,
},


ClosingState = State {
Main = function(self)
	self:DisableIntel('Sonar')
	TACloser.Fold(self)
	self:PlayUnitSound('Deactivate')
	self.Spinners.dish:SetSpeed(0)
	ChangeState(self, self.IdleClosedState)
end,
},
}

TypeClass = CORASON
