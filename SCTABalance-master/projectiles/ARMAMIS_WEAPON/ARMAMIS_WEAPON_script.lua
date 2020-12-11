

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMAMIS_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMAMIS_WEAPON
