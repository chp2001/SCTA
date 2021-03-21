#ARM Pheonix - Bomber
#ARMPNIX
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMPNIX = Class(TAair) {

	OnCreate = function(self)
		TAair.OnCreate(self)
		self.Sliders = {
			wing1 = CreateSlider(self, 'lwing1'),
			wing2 = CreateSlider(self, 'rwing1'),
			--wing1b = CreateSlider(self, 'wing_left_mid'),
			--wing2b = CreateSlider(self, 'wing_right_mid'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OpenWings = function(self)
		--MOVE wing1 to x-axis <6.75> SPEED <6>;
		self.Sliders.wing1:SetGoal(0,0,0)
		self.Sliders.wing1:SetSpeed(6)

		--MOVE wing1 to z-axis <-1.75> SPEED <1>;
		--self.Sliders.wing1b:SetGoal(0,0,0)
		--self.Sliders.wing1b:SetSpeed(1)

		--MOVE wing2 to x-axis <-6.95> SPEED <6>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(6)

		--MOVE wing2 to z-axis <-1.85> SPEED <1>;
		--self.Sliders.wing2b:SetGoal(0,0,0)
		--self.Sliders.wing2b:SetSpeed(1)

	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <6>;
		self.Sliders.wing1:SetGoal(-4,0,0)
		self.Sliders.wing1:SetSpeed(6)

		--MOVE wing1 to z-axis <0> SPEED <1>;
		--self.Sliders.wing1b:SetGoal(3,0,0)
		--self.Sliders.wing1b:SetSpeed(1)

		--MOVE wing2 to x-axis <0> SPEED <6>;
		self.Sliders.wing2:SetGoal(4,0,0)
		self.Sliders.wing2:SetSpeed(6)

		--MOVE wing2 to z-axis <0> SPEED <1>;
		--self.Sliders.wing2b:SetGoal(-3,0,0)
		--self.Sliders.wing2b:SetSpeed(1)
	end,

	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = ARMPNIX