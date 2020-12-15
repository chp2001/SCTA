

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORMABM_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORMABM_WEAPON
