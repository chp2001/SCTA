#ARM Ranger Rocket
#ARMMSHIP_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMBSHIP_ROCKET = Class(TAMissileProjectile) {
	OnCreate = function(self)
		TAMissileProjectile.OnCreate(self)
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		self:TrackTarget(false)
		WaitSeconds(2)
		self:TrackTarget(true)
		WaitSeconds(2)
		self:TrackTarget(false)
	end,
}
TypeClass = ARMBSHIP_ROCKET