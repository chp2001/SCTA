#CORE Roach - Crawling Bomb
#CORROACH
#
#Script created by Raevn


local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter
local TABomb = import('/mods/SCTA-master/lua/TAweapon.lua').TABomb
local TAKami = import('/mods/SCTA-master/lua/TAweapon.lua').TAKami

CORROACH = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.attacked = false
	end,

	Weapons = {
			DeathWeapon = Class(TABomb) {},
			Suicide = Class(TAKami) {        
				OnFire = function(self)			
					#disable death weapon
					self.unit:SetDeathWeaponEnabled(false)
					TAKami.OnFire(self)
				end,
			},
		},
}
TypeClass = CORROACH