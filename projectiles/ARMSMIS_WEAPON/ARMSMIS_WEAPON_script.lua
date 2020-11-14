

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMSMIS_WEAPON = Class(TAMissileProjectile) 
{
	TrackTime = 2,
}

TypeClass = ARMSMIS_WEAPON
