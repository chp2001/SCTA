#ARM Samson Missile
#ARMTRUCK_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMTRUCK_MISSILE = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		---self.TrackTime = 3
	end,
}

TypeClass = ARMTRUCK_MISSILE
