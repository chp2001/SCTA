local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMSVTOL_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 7,
}

TypeClass = ARMSVTOL_MISSILE
