#ARM Zeus Lightning Weapon
#LIGHTNING
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

LIGHTNING = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/LIGHTNING_emit.bp',
}

TypeClass = LIGHTNING

