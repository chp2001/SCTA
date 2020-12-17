#CORE Titan Torpedo Weapon
#CORAIR_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

SEAAIR_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		self.TrackTime = 5
	end,
}

TypeClass = SEAAIR_TORPEDO