local TShellPhalanxProjectile = import('/lua/terranprojectiles.lua').TShellPhalanxProjectile

TMD_LASER = Class(TShellPhalanxProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/GREEN_LASER_emit.bp',
}

TypeClass = TMD_LASER

