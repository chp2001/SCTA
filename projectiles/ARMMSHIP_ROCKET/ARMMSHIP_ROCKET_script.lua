#ARM Ranger Rocket
#ARMMSHIP_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMMSHIP_ROCKET = Class(TAMissileProjectile) {
	TrackTime = 5,

	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		WaitSeconds(1)
		self:TrackTarget(true)
		WaitSeconds(1)
		self:TrackTarget(false)
	end,
}
TypeClass = ARMMSHIP_ROCKET