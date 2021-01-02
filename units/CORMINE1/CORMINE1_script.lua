local TAMine = import('/mods/SCTA-master/lua/TAStructure.lua').TAMine
local Projectile = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

CORMINE1 = Class(TAMine) {


	Weapons = {
		CORMINE1 = Class(Projectile) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},
}
TypeClass = CORMINE1