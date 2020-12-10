#CORE Titan Torpedo Weapon
#CORAIR_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

SEAAIR_TORPEDO = Class(TAUnderWaterProjectile) {
	TrackTime = 10,
}

TypeClass = SEAAIR_TORPEDO