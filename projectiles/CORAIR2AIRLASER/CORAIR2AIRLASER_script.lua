#CORE Hurricane Laser
#CORAIR2AIRLASER
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

CORAIR2AIRLASER = Class(TALaserProjectile) {
	PolyTrail = '/mods/SCTA-master/effects/emitters/YELLOW_LASER_emit.bp',
}

TypeClass = CORAIR2AIRLASER

