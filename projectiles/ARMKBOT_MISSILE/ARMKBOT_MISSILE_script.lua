#ARM Jethro Missile
#ARMKBOT_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMKBOT_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMKBOT_MISSILE
