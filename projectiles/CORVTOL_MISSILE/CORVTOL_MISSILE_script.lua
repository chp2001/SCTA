#CORE Avenger Missile
#CORVTOL_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORVTOL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORVTOL_MISSILE
