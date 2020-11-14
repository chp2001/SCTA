

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORABM_WEAPON = Class(TAMissileProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORABM_WEAPON
