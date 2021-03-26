#CORE Krogoth Laser
#CORKROG_HEAD
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

CORKROG_HEAD = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/BLUE_LASER_emit.bp',
}

TypeClass = CORKROG_HEAD

