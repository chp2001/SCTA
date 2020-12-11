#CORE Avenger Missile
#CORVTOL_MISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORVTOL_MISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORVTOL_MISSILE
