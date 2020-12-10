#ARM Lancet Torpedo Weapon
#ARMAIR_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

ARMAIR_TORPEDO = Class(TAUnderWaterProjectile) {
	TrackTime = 10,
}

TypeClass = ARMAIR_TORPEDO