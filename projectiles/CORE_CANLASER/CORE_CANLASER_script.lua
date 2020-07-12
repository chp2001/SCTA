#CORE The Can Laser
#CORE_CANLASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

CORE_CANLASER = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/GREEN_LASER_emit.bp',
}

TypeClass = CORE_CANLASER

