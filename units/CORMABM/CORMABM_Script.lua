#ARM Jeffy - Fast Attack Vehicle
#CORMABM
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local DefaultWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

CORMABM = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			barrel = CreateRotator(self, 'box', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	Weapons = {
			Turret01 = Class(DefaultWeapon) {
				PlayFxWeaponUnpackSequence = function(self)
					self.unit.Spinners.barrel:SetGoal(-45)
					self.unit.Spinners.barrel:SetSpeed(45)
					DefaultWeapon.PlayFxWeaponUnpackSequence(self)
				end,

				PlayFxWeaponPackSequence = function(self)
					self.unit.Spinners.barrel:SetGoal(0)
					self.unit.Spinners.barrel:SetSpeed(45)
					DefaultWeapon.PlayFxWeaponPackSequence(self)
				end,
			}
	},
}

TypeClass = CORMABM