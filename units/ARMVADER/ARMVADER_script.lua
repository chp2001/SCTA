#ARM Invader - Crawling Bomb
#ARMVADER
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMVADER = Class(TAWalking) {
	attacked = false,

	Weapons = {
		CRAWL_BLAST = Class(TAweapon) {
			OnWeaponFired = function(self)
				self.unit.attacked = true
				self.unit:Kill()
			end,
		},
	},

	OnKilled = function(self, instigator, type, overkillRatio)
		if self.attacked == true then
			instigator = self
		end
		TAWalking.OnKilled(self, instigator, type, overkillRatio)
		
	end,
}
TypeClass = ARMVADER