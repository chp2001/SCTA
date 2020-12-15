#CORE Krogoth Rocket
#CORKROG_ROCKET
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORKROG_ROCKET = Class(TARocketProjectile) {
	TrackTime = 3,
}

TypeClass = CORKROG_ROCKET