#CORE Vamp Missile
#CORVTOL_ADVMISSILE2
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORSVTOL_MISSILE = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 3
	end,
}

TypeClass = CORSVTOL_MISSILE
