local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMSVTOL_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = ARMSVTOL_MISSILE
