#CORE Krogoth Rocket
#CORKROG_ROCKET
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORKROG_ROCKET = Class(TARocketProjectile) {
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 3
	end,
}

TypeClass = CORKROG_ROCKET