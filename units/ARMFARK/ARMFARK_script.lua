#ARM FARK - Fast Assist-Repair Kbot
#ARMFARK
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMFARK = Class(TAconstructor) {

	OnCreate = function(self)
		self.Spinners = {
			Lshoulder = CreateRotator(self, 'Llathe', 'x', nil, 0, 0, 0),
			Rshoulder = CreateRotator(self, 'Rlathe', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	Open = function(self)
		--TURN Lshoulder to x-axis <-10.94> SPEED <59.18>;
		self.Spinners.Lshoulder:SetGoal(-90)
		self.Spinners.Lshoulder:SetSpeed(45)

		--TURN Rshoulder to x-axis <-10.64> SPEED <57.53>;
		self.Spinners.Rshoulder:SetGoal(-90)
		self.Spinners.Rshoulder:SetSpeed(45)


		TAconstructor.Open(self)
	end,


	Close = function(self)
		--TURN Lshoulder to x-axis <-10.94> SPEED <54.74>;
		self.Spinners.Lshoulder:SetGoal(0)
		self.Spinners.Lshoulder:SetSpeed(45)

		--TURN Rshoulder to x-axis <-10.64> SPEED <53.21>;
		self.Spinners.Rshoulder:SetGoal(0)
		self.Spinners.Rshoulder:SetSpeed(45)

		TAconstructor.Close(self)
	end,
}

TypeClass = ARMFARK