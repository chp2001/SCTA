#ARM Pheonix Laser
#ARMAIR2AIRLASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

ARMAIR2AIRLASER = Class(TALaserProjectile) {
	PolyTrail = '/mods/SCTA-master/effects/emitters/YELLOW_LASER_emit.bp',
}

TypeClass = ARMAIR2AIRLASER

