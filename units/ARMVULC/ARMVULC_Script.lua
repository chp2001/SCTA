#ARM Vulcan - Rapid Fire Plasma Cannon
#ARMVULC
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAEndGameWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAEndGameWeapon

ARMVULC = Class(TAStructure) {

	Weapons = {
		ARMVULC_WEAPON = Class(TAEndGameWeapon) {
			OnWeaponFired = function(self)
				TAEndGameWeapon.OnWeaponFired(self)
				self.unit:CreateProjectileAtBone('/mods/SCTA-master/effects/entities/Shells/ARMVULC_Shell/ARMVULC_Shell_proj.bp','Shell')
			end,

			PlayRackRecoil = function(self, rackList) 
				if not self.Rotator then
					self.Rotator = CreateRotator(self.unit, 'Spindle', 'z')
				end
				self.MaxRound = 4
				self.Rotation = -90
				self.Speed = 720
				TAEndGameWeapon.PlayRackRecoil(self, rackList)
			end, 
		},
	},
}

TypeClass = ARMVULC
