#CORE Diplomat Rocket
#CORTRUCK_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORTRUCK_ROCKET = Class(TAMissileProjectile) {

	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		self:TrackTarget(false)
		WaitSeconds(3)
		self:TrackTarget(true)
		WaitSeconds(1)
		self:TrackTarget(false)
	end,
}

TypeClass = CORTRUCK_ROCKET