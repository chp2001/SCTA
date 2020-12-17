#ARM Advanced Torpedo Launcher Torpedo Weapon
#ARMATL_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

ARMATL_TORPEDO = Class(TAUnderWaterProjectile) {
	OnCreate = function(self)
		TAUnderWaterProjectile.OnCreate(self)
		self.TrackTime = 3
	end,
}

TypeClass = ARMATL_TORPEDO