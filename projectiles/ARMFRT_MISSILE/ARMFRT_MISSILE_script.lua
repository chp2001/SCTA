#ARM Defender - NS Missile
#ARMFRT_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMFRT_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMFRT_MISSILE
