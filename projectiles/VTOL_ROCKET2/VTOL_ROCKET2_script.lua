#CORE Rapier Rocket
#VTOL_ROCKET2
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

VTOL_ROCKET2 = Class(TARocketProjectile) {
    OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		---self.TrackTime = 2
	end,
}

TypeClass = VTOL_ROCKET2
