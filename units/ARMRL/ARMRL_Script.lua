#ARM Defender - Missile Tower
#ARMRL
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TARotatingWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TARotatingWeapon

ARMRL = Class(TAStructure) {
	Weapons = {
		ARMRL_MISSILE = Class(TARotatingWeapon) {
			PlayRackRecoil = function(self, rackList)
				if not self.Rotator then
					self.Rotator = CreateRotator(self.unit, 'gun1', 'z')
				end
				TARotatingWeapon.PlayRackRecoil(self, rackList) 
			end, 
		},
	},
}

TypeClass = ARMRL
