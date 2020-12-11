#CORE Vamp Missile
#CORVTOL_ADVMISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORVTOL_ADVMISSILE = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORVTOL_ADVMISSILE
