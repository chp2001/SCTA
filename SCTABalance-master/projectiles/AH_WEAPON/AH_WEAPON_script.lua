#ARM Swatter Missile
#ARMAH_WEAPON
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

AH_WEAPON = Class(TAMissileProjectile) 
{
	TrackTime = 5,
}

TypeClass = AH_WEAPON
