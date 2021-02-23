#ARM Defender - Missile Tower
#ARMRL
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMRL = Class(TAStructure) {
	

	OnCreate = function(self)
		TAStructure.OnCreate(self)
		self.Spinners = {
			barrel = CreateRotator(self, 'gun1', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.currentBarrel = 0
	end,

	Weapons = {
		ARMRL_MISSILE = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
				self.unit.currentBarrel = self.unit.currentBarrel + 1
				if self.unit.currentBarrel == 3 then
					self.unit.currentBarrel = 0
				end

				--TURN barrel to z-axis <119.99> SPEED <400.09>; (for each turn)
				self.unit.Spinners.barrel:SetGoal(-120 * self.unit.currentBarrel)
				self.unit.Spinners.barrel:SetSpeed(400)
			end,
		},
	},
}

TypeClass = ARMRL
