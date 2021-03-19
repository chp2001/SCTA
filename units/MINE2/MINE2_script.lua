#ARM Precision Mine - High Damage, Small Range Mine
#ARMMINE5
#
#Script created by Raevn

local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

MINE2 = Class(TAMine) {


	Weapons = {
		ARMMINE2 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = MINE2