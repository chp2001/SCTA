

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMSMIS_WEAPON = Class(TARocketProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMSMIS_WEAPON
