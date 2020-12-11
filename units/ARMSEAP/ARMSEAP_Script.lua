#CORE Titan - Torpedo Bomber
#ARMSEAP
#
#Script created by Raevn

local TASeaair = import('/mods/SCTA-master/lua/TAair.lua').TASeaair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSEAP = Class(TASeaair) {

	OnCreate = function(self)
		TASeaair.OnCreate(self)
		self.Sliders = {
			chassis = CreateSlider(self, 0),
			wing1 = CreateSlider(self, 'LWing'),
			wing2 = CreateSlider(self, 'RWing'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,



	OpenWings = function(self)
		self.moving = true
		--TURN wing1 to z-axis <-90.00> SPEED <60.69>;
		self.Sliders.wing1:SetGoal(3,0,2)
		self.Sliders.wing1:SetSpeed(1)

		--TURN wing2 to z-axis <90.00> SPEED <60.69>;
		self.Sliders.wing2:SetGoal(-3,0,2)
		self.Sliders.wing2:SetSpeed(1)
	end,

	CloseWings = function(self)
		self.moving = nil
		--TURN wing1 to z-axis <0> SPEED <60.69>;
		self.Sliders.wing1:SetGoal(0,0,0)
		self.Sliders.wing1:SetSpeed(1)

		--TURN wing2 to z-axis <0> SPEED <60.69>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(1)
	end,

	Weapons = {
		CORAIR_TORPEDO = Class(TAweapon) {},
		ARMVTOL_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = ARMSEAP