

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORABM_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORABM_WEAPON
