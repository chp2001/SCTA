#CORE Titan Torpedo Weapon
#CORAIR_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

CORAIR_TORPEDO = Class(TAUnderWaterProjectile) {
	TrackTime = 10,

	OnEnterWater = function(self)
		ForkThread(self.MovementThread,self)
		TAUnderWaterProjectile.OnEnterWater(self)
	end,

	MovementThread = function(self)
		self:TrackTarget(true)
		WaitSeconds(0.1)
		self:SetTurnRate(55)
		local target = self:GetTrackingTarget()
			if target and IsBlip(target) then target = target:GetSource() end
			if target and IsUnit(target) then
				local layer = target:GetCurrentLayer()
				if layer == 'Sub' then
					self:ForkThread(TAUnderWaterProjectile.PassDamageThread)
				end
			end
	end,
}

TypeClass = CORAIR_TORPEDO