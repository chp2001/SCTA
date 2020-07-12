#ARM Penetrator Laser
#ARMMANNI_WEAPON
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

ARMMANNI_WEAPON = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/PURPLE_LASER_emit.bp',
}

TypeClass = ARMMANNI_WEAPON

