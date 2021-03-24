#ARM Hawk Missile
#ARMVTOL_ADVMISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMVTOL_ADVMISSILE = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		---self.TrackTime = 2
	end,
}

TypeClass = ARMVTOL_ADVMISSILE
