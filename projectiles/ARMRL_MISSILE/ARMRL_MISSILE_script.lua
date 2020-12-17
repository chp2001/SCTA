#ARM Defender Missile
#ARMRL_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMRL_MISSILE = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 2
	end,
}

TypeClass = ARMRL_MISSILE
