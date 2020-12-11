#ARM Defender Missile
#ARMRL_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMRL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMRL_MISSILE
