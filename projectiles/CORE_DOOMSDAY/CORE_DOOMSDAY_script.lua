#CORE Doomsday Machine Laser
#CORE_DOOMSDAY
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

CORE_DOOMSDAY = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/BLUE_LASER_emit.bp',
}

TypeClass = CORE_DOOMSDAY

