#CORE Crasher, Searcher Missile
#CORKBOT_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORKBOT_MISSILE = Class(TARocketProjectile) 
{
	TrackTime = 3,
}

TypeClass = CORKBOT_MISSILE
