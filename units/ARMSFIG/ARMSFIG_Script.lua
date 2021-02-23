#CORE Avenger - Fighter
#ARMSFIG
#
#Script created by Raevn

local TASeaair = import('/mods/SCTA-master/lua/TAair.lua').TASeaair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSFIG = Class(TASeaair) {
	

	OnCreate = function(self)
		TASeaair.OnCreate(self)
		self.Sliders = {
			chassis = CreateSlider(self, 0),
			winga = CreateSlider(self, 'lwing1'),
			wingb = CreateSlider(self, 'rwing1'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end	
		self.moving = nil
	end,


	OpenWings = function(self)
		--TURN winga to z-axis <-91.21> SPEED <63.22>;
		self.Sliders.winga:SetGoal(0,0,0)
		self.Sliders.winga:SetSpeed(3)

		--TURN wingb to z-axis <91.21> SPEED <63.22>;
		self.Sliders.wingb:SetGoal(0,0,0)
		self.Sliders.wingb:SetSpeed(3)
		self.moving = true
	end,

	CloseWings = function(self)
		self.moving = nil
		--TURN winga to z-axis <0> SPEED <63.13>;
		self.Sliders.winga:SetGoal(-3,0,0)
		self.Sliders.winga:SetSpeed(3)

		--TURN wingb to z-axis <0> SPEED <63.13>;
		self.Sliders.wingb:SetGoal(3,0,0)
		self.Sliders.wingb:SetSpeed(3)
	end,

	Weapons = {
		CORVTOL_MISSILE = Class(TAweapon) {},
		
	},
}

TypeClass = ARMSFIG