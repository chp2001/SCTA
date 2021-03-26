#ARM Annihilator Laser
#ARM_TOTAL_ANNIHILATOR
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

ARM_SCTA_ANNIHILATOR = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/BLUE_LASER_emit.bp',
}

TypeClass = ARM_SCTA_ANNIHILATOR

