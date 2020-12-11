#CORE Vamp Missile
#CORVTOL_ADVMISSILE
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORVTOL_ADVMISSILE = Class(TAMissileProjectile) 
{
	TrackTime = 2,
}

TypeClass = CORVTOL_ADVMISSILE
