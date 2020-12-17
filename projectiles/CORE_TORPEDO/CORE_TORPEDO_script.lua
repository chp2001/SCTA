#CORE Snake Torpedo Weapon
#CORE_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

CORE_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		self.TrackTime = 3
	end,

}

TypeClass = CORE_TORPEDO