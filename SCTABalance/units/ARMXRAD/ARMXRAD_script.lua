local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

ARMXRAD = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.Spinners = {
			arm1 = CreateRotator(self, 'dish1', 'x', nil, 0, 0, 0),
			arm2 = CreateRotator(self, 'dish2', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			post = CreateSlider(self, 'radar'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OpeningState = State {
		Main = function(self)
			TACloser.Unfold(self)
			self:PlayUnitSound('Activate')
			self.intelIsActive = true
			self.Sliders.post:SetGoal(0,0,0)
			self.Sliders.post:SetSpeed(16)

			--WAIT-FOR-MOVE post along y-axis;
			WaitFor(self.Sliders.post)

			--SPIN arm1 around x-axis  SPEED <100.02>;
			self.Spinners.arm1:SetSpeed(45)
			self.Spinners.arm1:ClearGoal()

			--SPIN arm2 around x-axis  SPEED <-100.02>;
			self.Spinners.arm2:SetSpeed(45)
			self.Spinners.arm2:ClearGoal()
			
			self:EnableIntel('Radar')
			ChangeState(self, self.IdleOpenState)
		end,
	},


	ClosingState = State {
		Main = function(self)
			self:DisableIntel('Radar')
			TACloser.Fold(self)
			self:PlayUnitSound('Deactivate')
			self.intelIsActive = nil
			--TURN dish1 to z-axis <0> SPEED <178.70>;
			self.Spinners.arm1:SetGoal(0)

			--TURN dish2 to z-axis <0> SPEED <178.70>;
			self.Spinners.arm2:SetGoal(0)

			--MOVE post to y-axis <0> SPEED <19.00>;
			self.Sliders.post:SetGoal(0,-9,0)
			self.Sliders.post:SetSpeed(19)

			--WAIT-FOR-MOVE post along y-axis;
			WaitFor(self.Sliders.post)

			ChangeState(self, self.IdleClosedState)
		end,

	},

}

TypeClass = ARMXRAD

	