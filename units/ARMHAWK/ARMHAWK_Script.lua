#ARM Hawk - Stealth Fighter
#ARMHAWK
#
#Script created by Raevn

local TAIntelAir = import('/mods/SCTA-master/lua/TAair.lua').TAIntelAir
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMHAWK = Class(TAIntelAir) {

	OnCreate = function(self)
		TAIntelAir.OnCreate(self)
		self.Sliders = {
			wing1 = CreateSlider(self, 'wing1'),
			wing2 = CreateSlider(self, 'wing2'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,
	
	OpenWings = function(self)
		--MOVE wing1 to x-axis <1.99> SPEED <2>;
		self.Sliders.wing1:SetGoal(-2,0,0)
		self.Sliders.wing1:SetSpeed(2)

		--MOVE wing2 to x-axis <-2.24> SPEED <2>;
		self.Sliders.wing2:SetGoal(2,0,0)
		self.Sliders.wing2:SetSpeed(2)

	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <2>;
		self.Sliders.wing1:SetGoal(0,0,0)
		self.Sliders.wing1:SetSpeed(2)

		--MOVE wing2 to x-axis <0> SPEED <2>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(2)
	end,

	Weapons = {
		WEAPON = Class(TAweapon) {},		
	},
}

TypeClass = ARMHAWK