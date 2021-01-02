#ARM Focused Mine - Med. Damage, Small Range Mine
#ARMMINE3
#
#Script created by Raevn
local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

ARMMINE3 = Class(TAMine) {


	Weapons = {
		ARMMINE3 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = ARMMINE3