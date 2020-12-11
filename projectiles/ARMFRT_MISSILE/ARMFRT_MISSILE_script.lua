#ARM Defender - NS Missile
#ARMFRT_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMFRT_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMFRT_MISSILE
