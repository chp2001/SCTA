#ARM Jethro Missile
#ARMKBOT_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMKBOT_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMKBOT_MISSILE
