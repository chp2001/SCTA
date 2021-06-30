#ARM Tiny - Low Damage, Med. Range Mine
#ARMMINE1
#
#Script created by Raevn

local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

MINE1 = Class(TAMine) {


	Weapons = {
		ARMMINE1 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = MINE1