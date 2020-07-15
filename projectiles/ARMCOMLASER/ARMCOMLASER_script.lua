#ARM Commander Laser
#ARMCOMLASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

ARMCOMLASER = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/RED_LASER_emit.bp',
}

TypeClass = ARMCOMLASER
