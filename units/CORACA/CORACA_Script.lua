#CORE Adv. Construction Aircraft - Tech Level 2
#CORACA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor


CORACA = Class(TAAirConstructor) {

	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.Spinners = {
			nozzle = CreateRotator(self, 'nozzle', 'x', nil, 0, 0, 0),
			wing1 = CreateRotator(self, 'wing1', 'z', nil, 0, 0, 0),
			wing2 = CreateRotator(self, 'wing2', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,


	OpenWings = function(self)
		--TURN wing1 to z-axis <-90.00> SPEED <60.57>;
		self.Spinners.wing1:SetGoal(90)
		self.Spinners.wing1:SetSpeed(60)

		--TURN wing2 to z-axis <90.00> SPEED <60.57>;
		self.Spinners.wing2:SetGoal(-90)
		self.Spinners.wing2:SetSpeed(60)
	end,

	CloseWings = function(self)
		--TURN wing1 to z-axis <0> SPEED <60.21>;
		self.Spinners.wing1:SetGoal(0)
		self.Spinners.wing1:SetSpeed(60)

		--TURN wing2 to z-axis <0> SPEED <60.21>;
		self.Spinners.wing2:SetGoal(0)
		self.Spinners.wing2:SetSpeed(60)
	end,

}

TypeClass = CORACA