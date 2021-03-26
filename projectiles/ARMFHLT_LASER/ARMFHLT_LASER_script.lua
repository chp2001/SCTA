#ARM Stingray Laser
#ARMFHLT_LASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

ARMFHLT_LASER = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/GREEN_LASER_emit.bp',
}

TypeClass = ARMFHLT_LASER

