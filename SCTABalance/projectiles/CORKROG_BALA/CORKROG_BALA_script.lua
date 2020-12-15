#CORE Krogoth Cannon
#CORKROG_FIRE
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TALaserProjectile

CORKROG_BALA = ClassClass(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/BLUE_LASER_emit.bp',
}

TypeClass = CORKROG_BALA
