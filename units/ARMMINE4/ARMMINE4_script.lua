#ARM HE Area Mine - Med. Damage, Large Range Mine
#ARMMINE4
#
#Script created by Raevn
local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

ARMMINE4 = Class(TAMine) {


	Weapons = {
		ARMMINE4 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = ARMMINE4