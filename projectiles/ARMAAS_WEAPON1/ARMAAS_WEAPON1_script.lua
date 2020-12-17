#ARM Archer Missile
#ARMAAS_WEAPON1
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMAAS_WEAPON1 = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 2
	end,
}

TypeClass = ARMAAS_WEAPON1
