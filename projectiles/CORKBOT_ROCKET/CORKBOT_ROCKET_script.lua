#CORE Storm Rocket
#CORKBOT_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORKBOT_ROCKET = Class(TAMissileProjectile) 
{
	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		---self.TrackTime = 2
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		WaitSeconds(1)
		self:TrackTarget(true)
		WaitSeconds(1)
	end,
}

TypeClass = CORKBOT_ROCKET
