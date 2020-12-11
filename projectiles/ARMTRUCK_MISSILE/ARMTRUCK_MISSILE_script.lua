#ARM Samson Missile
#ARMTRUCK_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMTRUCK_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMTRUCK_MISSILE
