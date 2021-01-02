#ARM Torpedo Launcher Torpedo Weapon
#COAX_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

COAX_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		self.TrackTime = 3
	end,
}

TypeClass = COAX_TORPEDO
