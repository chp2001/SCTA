#ARM Skimmer Laser
#ARMSH_WEAPON
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

ARMSH_WEAPON = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/RED_LASER_emit.bp',
}

TypeClass = ARMSH_WEAPON

