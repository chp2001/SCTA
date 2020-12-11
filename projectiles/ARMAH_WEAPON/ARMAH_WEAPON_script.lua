#ARM Swatter Missile
#ARMAH_WEAPON
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMAH_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMAH_WEAPON
