#ARM Samson Missile
#ARMTRUCK_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMTRUCK_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMTRUCK_MISSILE
