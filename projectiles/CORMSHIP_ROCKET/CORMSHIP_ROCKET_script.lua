#CORE Hydra Rocket
#CORMSHIP_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

CORMSHIP_ROCKET = Class(TAMissileProjectile) {
	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
		self.TrackTime = 4
	end,

	MovementThread = function(self)
		WaitSeconds(2)
		self:TrackTarget(true)
		WaitSeconds(2)
		self:TrackTarget(false)
	end,
}
TypeClass = CORMSHIP_ROCKET