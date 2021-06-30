#ARM Hammer - Artillery Kbot
#ARMHAM
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMHAM = Class(TAWalking) {
	OnCreate = function(self)
	TAWalking.OnCreate(self)
	self.Sliders = {
		lshield1 = CreateSlider(self, 'lshield1'),
		rshield1 = CreateSlider(self, 'rshield1'),
		lshield2 = CreateSlider(self, 'lshield2'),
		rshield2 = CreateSlider(self, 'rshield2'),
	}
	for k, v in self.Sliders do
		self.Trash:Add(v)
	end
end,


	Weapons = {
		ARM_HAM = Class(TAweapon) {
			OnWeaponFired = function(self)		
				TAweapon.OnWeaponFired(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				TAweapon.PlayFxWeaponUnpackSequence(self)
				self.unit.Sliders.lshield1:SetGoal(0,1,0)
				self.unit.Sliders.lshield1:SetSpeed(1)
	
				--TURN door3 to x-axis <0> SPEED <227.09>;
				self.unit.Sliders.rshield1:SetGoal(0,1,0)
				self.unit.Sliders.rshield1:SetSpeed(1)

				self.unit.Sliders.lshield2:SetGoal(0,-1,0)
				self.unit.Sliders.lshield2:SetSpeed(1)
	
				--TURN door3 to x-axis <0> SPEED <227.09>;
				self.unit.Sliders.rshield2:SetGoal(0,-1,0)
				self.unit.Sliders.rshield2:SetSpeed(1)

			end,	
	
			PlayFxWeaponPackSequence = function(self)
				TAweapon.PlayFxWeaponPackSequence(self)
			self.unit.Sliders.lshield1:SetGoal(0,0,0)
			self.unit.Sliders.lshield1:SetSpeed(1)

			--TURN door3 to x-axis <0> SPEED <227.09>;
			self.unit.Sliders.rshield1:SetGoal(0,0,0)
			self.unit.Sliders.rshield1:SetSpeed(1)

			self.unit.Sliders.lshield2:SetGoal(0,0,0)
			self.unit.Sliders.lshield2:SetSpeed(1)

			--TURN door3 to x-axis <0> SPEED <227.09>;
			self.unit.Sliders.rshield2:SetGoal(0,0,0)
			self.unit.Sliders.rshield2:SetSpeed(1)

			end,		
		},
	},
}

TypeClass = ARMHAM
