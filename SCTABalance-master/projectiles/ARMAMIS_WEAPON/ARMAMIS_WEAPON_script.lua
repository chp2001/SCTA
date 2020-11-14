

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMAMIS_WEAPON = Class(TAMissileProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMAMIS_WEAPON
