#CORE Commander Laser
#CORCOMLASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

CORCOMLASER = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/RED_LASER_emit.bp',
}

TypeClass = CORCOMLASER
