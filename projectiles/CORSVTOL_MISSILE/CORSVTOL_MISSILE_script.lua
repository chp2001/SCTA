#CORE Vamp Missile
#CORVTOL_ADVMISSILE2
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORSVTOL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORSVTOL_MISSILE
