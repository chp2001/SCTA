#ARM Freedom Fighter Missile
#ARMVTOL_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMVTOL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMVTOL_MISSILE
