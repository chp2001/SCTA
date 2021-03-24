#ARM Wombat Rocket
#ARMMH_WEAPON
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAMissileProjectile

ARMTRUCK_ROCKET = Class(TAMissileProjectile) {

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

TypeClass = ARMTRUCK_ROCKET