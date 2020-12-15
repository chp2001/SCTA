#ARM Swatter Missile
#ARMAH_WEAPON
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

AH_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 5,
}

TypeClass = AH_WEAPON
