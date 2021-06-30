#ARM Solar Collector - Produces Energy
#ARMSOLAR
#
#Script created by Raevn

local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

ARMSOLAR = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.Spinners = {
			dish1 = CreateRotator(self, 'turn1', 'x', nil, 0, 0, 0),
			dish2 = CreateRotator(self, 'turn2', 'x', nil, 0, 0, 0),
			dish3 = CreateRotator(self, 'turn3', 'z', nil, 0, 0, 0),
			dish4 = CreateRotator(self, 'turn4', 'z', nil, 0, 0, 0),	
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OpeningState = State {
		Main = function(self)
			self.IsActive = true
			self:SetProductionActive(true)
			self.Spinners.dish1:SetGoal(90)
			self.Spinners.dish1:SetSpeed(60)

			--TURN dish2 to x-axis <90.00> SPEED <60.01>
			self.Spinners.dish2:SetGoal(-90)
			self.Spinners.dish2:SetSpeed(60)

			--TURN dish3 to z-axis <-90.00> SPEED <60.01>
			self.Spinners.dish3:SetGoal(90)
			self.Spinners.dish3:SetSpeed(60)

			--TURN dish4 to z-axis <90.00> SPEED <60.01>
			self.Spinners.dish4:SetGoal(-90)
			self.Spinners.dish4:SetSpeed(60)

			TACloser.OpeningState.Main(self)
		end,
	},


	ClosingState = State {
		Main = function(self)
			self:SetProductionActive(false)
			--TURN dish1 to x-axis <0> SPEED <120.02>
			self.Spinners.dish1:SetGoal(0)
			self.Spinners.dish1:SetSpeed(120)

			--TURN dish2 to x-axis <0> SPEED <120.02>
			self.Spinners.dish2:SetGoal(0)
			self.Spinners.dish2:SetSpeed(120)

			--TURN dish3 to x-axis <0> SPEED <120.02>
			self.Spinners.dish3:SetGoal(0)
			self.Spinners.dish3:SetSpeed(120)

			--TURN dish4 to x-axis <0> SPEED <120.02>
			self.Spinners.dish4:SetGoal(0)
			self.Spinners.dish4:SetSpeed(120)

			TACloser.ClosingState.Main(self)
		end,

	},
}

TypeClass = ARMSOLAR