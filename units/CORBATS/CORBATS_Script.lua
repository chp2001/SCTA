#CORE Warlord - Battleship
#CORBATS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAWeaponFile = import('/mods/SCTA-master/lua/TAweapon.lua')
local TAweapon = TAWeaponFile.TAweapon
local TARotatingWeapon = TAWeaponFile.TARotatingWeapon

CORBATS = Class(TASea) {
	Weapons = {
		COR_BATS = Class(TAweapon) {

		},
		COR_BATSLASER = Class(TARotatingWeapon) {
			PlayRackRecoil = function(self, rackList)
				if not self.Rotator then
					self.Rotator = CreateRotator(self.unit, 'guna', 'z')
				end
				self.MaxRound = 3
				self.Rotation = -120
				self.Speed = 120
				TARotatingWeapon.PlayRackRecoil(self, rackList) 
			end, 
		},

	},
}

TypeClass = CORBATS
