#CORE Hydra Missile
#CORSHIP_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORSHIP_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORSHIP_MISSILE
