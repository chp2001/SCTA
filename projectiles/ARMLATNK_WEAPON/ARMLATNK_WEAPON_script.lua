#ARM Panther Lightning Weapon
#ARMLATNK_WEAPON
#
#Script created by Raevn

local TALaserProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TALaserProjectile

ARMLATNK_WEAPON = Class(TALaserProjectile) 
{
	PolyTrail = '/mods/SCTA-master/effects/emitters/LIGHTNING_emit.bp',
}

TypeClass = ARMLATNK_WEAPON

