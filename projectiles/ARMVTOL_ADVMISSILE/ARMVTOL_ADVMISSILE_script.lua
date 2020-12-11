#ARM Hawk Missile
#ARMVTOL_ADVMISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMVTOL_ADVMISSILE = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMVTOL_ADVMISSILE
