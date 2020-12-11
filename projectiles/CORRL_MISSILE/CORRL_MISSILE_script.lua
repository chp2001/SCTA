#CORE Pulverizer Missile
#CORRL_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORRL_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORRL_MISSILE
