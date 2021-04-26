local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAEndGameWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAEndGameWeapon

CORBUZZ = Class(TAStructure) {
	Weapons = {
		CORBUZZ_WEAPON = Class(TAEndGameWeapon) {
			OnWeaponFired = function(self)
				TAEndGameWeapon.OnWeaponFired(self)
				self.unit:CreateProjectileAtBone('/mods/SCTA-master/effects/entities/Shells/ARMVULC_Shell/ARMVULC_Shell_proj.bp','Turret')
			end,

			PlayRackRecoil = function(self, rackList) 
				if not self.Rotator then
					self.Rotator = CreateRotator(self.unit, 'Spindle', 'x')
				end
				TAEndGameWeapon.PlayRackRecoil(self, rackList)
			end, 
		},
	},
}
TypeClass = CORBUZZ
