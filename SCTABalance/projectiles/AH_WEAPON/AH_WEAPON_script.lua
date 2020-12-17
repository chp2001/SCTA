#ARM Swatter Missile
#ARMAH_WEAPON
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

AH_WEAPON = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 5
	end,
}

TypeClass = AH_WEAPON
