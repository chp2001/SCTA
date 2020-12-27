#ARM Zipper Laser
#ARM_FAST
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

ARM_FAST = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/GREEN_LASER_emit.bp',
}

TypeClass = ARM_FAST

