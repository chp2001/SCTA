#CORE Storm Rocket
#CORKBOT_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORKBOT_ROCKET = Class(TAMissileProjectile) 
{
	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		self:TrackTarget(false)
		WaitSeconds(1)
		self:TrackTarget(true)
		WaitSeconds(1)
		self:TrackTarget(false)
	end,
}

TypeClass = CORKBOT_ROCKET
