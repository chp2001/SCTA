#ARM Nuclear Mine - Nuclear Mine
#ARMMINE6
#
#Script created by Raevn
local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

ARMMINE6 = Class(TAMine) {


	Weapons = {
		ARMMINE6 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = ARMMINE6