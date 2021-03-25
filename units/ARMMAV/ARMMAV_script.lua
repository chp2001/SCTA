#ARM Fido - Assault Kbot
#ARMFIDO
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMMAV = Class(TAWalking) {

	OnCreate = function(self)
	TAWalking.OnCreate(self)
	self.Spinners = {
		lgunbase = CreateRotator(self, 'larm', 'y', nil, 0, 0, 0),
		rgunbase = CreateRotator(self, 'rarm', 'y', nil, 0, 0, 0),
	}
	for k, v in self.Spinners do
		self.Trash:Add(v)
	end
	end,

	Weapons = {
		EMG = Class(TAweapon) {
		PlayFxWeaponUnpackSequence = function(self)
			TAweapon.PlayFxWeaponUnpackSequence(self)
			self.unit.Spinners.lgunbase:SetGoal(-90)
			self.unit.Spinners.lgunbase:SetSpeed(90)

			--TURN door3 to x-axis <0> SPEED <227.09>;
			self.unit.Spinners.rgunbase:SetGoal(90)
			self.unit.Spinners.rgunbase:SetSpeed(90)
		end,	

		PlayFxWeaponPackSequence = function(self)
			TAweapon.PlayFxWeaponPackSequence(self)
			self.unit.Spinners.lgunbase:SetGoal(0)
			self.unit.Spinners.lgunbase:SetSpeed(90)
			--TURN door3 to x-axis <0> SPEED <227.09>;
			self.unit.Spinners.rgunbase:SetGoal(0)
			self.unit.Spinners.rgunbase:SetSpeed(90)
		end,		
		},
	},
}
TypeClass = ARMMAV