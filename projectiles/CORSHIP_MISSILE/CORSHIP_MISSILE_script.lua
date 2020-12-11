#CORE Hydra Missile
#CORSHIP_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORSHIP_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORSHIP_MISSILE
