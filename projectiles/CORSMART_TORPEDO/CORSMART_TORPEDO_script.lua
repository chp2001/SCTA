#CORE Shark Torpedo Weapon
#CORSMART_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

CORSMART_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		self.TrackTime = 3
	end,

}

TypeClass = CORSMART_TORPEDO