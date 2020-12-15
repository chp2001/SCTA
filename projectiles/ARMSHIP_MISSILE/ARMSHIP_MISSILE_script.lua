#ARM Ranger Missile
#ARMSHIP_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMSHIP_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMSHIP_MISSILE
