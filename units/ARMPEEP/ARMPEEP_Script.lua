#ARM Peeper - Air Scout
#ARMPEEP
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair

ARMPEEP = Class(TAair) {

	OnCreate = function(self)
		TAair.OnCreate(self)
		self.Spinners = {
			wing1 = CreateRotator(self, 'aile1', 'z', nil, 0, 0, 0),
			wing2 = CreateRotator(self, 'aile2', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OpenWings = function(self)

		--TURN wing2 to x-axis <-8.12> SPEED <6.12>;
		self.Spinners.wing2:SetGoal(-45)
		self.Spinners.wing2:SetSpeed(6.12)

		--TURN wing1 to x-axis <-8.60> SPEED <6.48>;
		self.Spinners.wing1:SetGoal(45)
		self.Spinners.wing1:SetSpeed(6.12)
	end,

	CloseWings = function(self)

		--TURN wing2 to x-axis <0> SPEED <6.12>;
		self.Spinners.wing2:SetGoal(0)
		self.Spinners.wing2:SetSpeed(6.12)

		--TURN wing1 to x-axis <0> SPEED <6.48>;
		self.Spinners.wing1:SetGoal(0)
		self.Spinners.wing1:SetSpeed(6.12)
	end,
}

TypeClass = ARMPEEP