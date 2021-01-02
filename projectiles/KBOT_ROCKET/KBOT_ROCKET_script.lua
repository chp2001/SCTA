#ARM Rocko Rocket
#ARMKBOT_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

KBOT_ROCKET = Class(TAMissileProjectile) 
{
	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self.TrackTime = 4
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		WaitSeconds(1)
		self:TrackTarget(true)
		WaitSeconds(1)
	end,
}

TypeClass = KBOT_ROCKET
