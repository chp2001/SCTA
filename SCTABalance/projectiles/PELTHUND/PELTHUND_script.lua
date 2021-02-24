#ARM Zeus PELTHUND Weapon
#PELTHUND
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

PELTHUND = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/PELTHUND_emit.bp',
}

TypeClass = PELTHUND

