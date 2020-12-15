#Anti Nuke Rocket
#AMD_ROCKET
#
#Projectile created by Raevn

local TAAntiNukeProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAAntiNukeProjectile

ARD_ROCKET = Class(TAAntiNukeProjectile) {
	OnCreate = function(self)
		TAAntiNukeProjectile.OnCreate(self)
        	self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
		self:ForkThread( self.MovementThread )
	end,

	MovementThread = function(self)
		self:TrackTarget(true)
	end,
}

TypeClass = ARD_ROCKET