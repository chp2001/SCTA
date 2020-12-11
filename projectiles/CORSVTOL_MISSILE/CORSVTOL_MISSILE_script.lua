#CORE Vamp Missile
#CORVTOL_ADVMISSILE2
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORSVTOL_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORSVTOL_MISSILE
