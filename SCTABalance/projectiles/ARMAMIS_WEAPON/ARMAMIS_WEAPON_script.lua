

local TARocketProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TARocketProjectile

ARMAMIS_WEAPON = Class(TARocketProjectile) 
{
	OnCreate = function(self)
		TARocketProjectile.OnCreate(self)
		self.TrackTime = 2
	end,
}

TypeClass = ARMAMIS_WEAPON
