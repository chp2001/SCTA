#ARM Adv. Construction Aircraft - Tech Level 2
#ARMACA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor


CORCSA = Class(TAAirConstructor) {
	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.Spinners = {
			wing1 = CreateRotator(self, 'rightwing', 'z', nil, 0, 0, 0),
			wing2 = CreateRotator(self, 'leftwing', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,


	OpenWings = function(self)
		--MOVE winga to x-axis <5.59> SPEED <5.00>;
		self.Spinners.wing1:SetGoal(70)
		self.Spinners.wing1:SetSpeed(70)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Spinners.wing2:SetGoal(-70)
		self.Spinners.wing2:SetSpeed(70)
	end,

	CloseWings = function(self)
		self.Spinners.wing1:SetGoal(0)
		self.Spinners.wing1:SetSpeed(70)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Spinners.wing2:SetGoal(0)
		self.Spinners.wing2:SetSpeed(70)
	end,

}

TypeClass = CORCSA