#ARM Pirahna Torpedo Weapon
#ARMSMART_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

ARMSMART_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		---self.TrackTime = 3
	end,

}

TypeClass = ARMSMART_TORPEDO