#CORE Crasher, Searcher Missile
#CORKBOT_MISSILE
#
#Script created by Raevn

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

CORKBOT_MISSILE = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		---self.TrackTime = 3
	end,
}

TypeClass = CORKBOT_MISSILE
