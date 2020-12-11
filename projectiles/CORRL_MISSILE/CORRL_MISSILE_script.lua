#CORE Pulverizer Missile
#CORRL_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORRL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORRL_MISSILE
