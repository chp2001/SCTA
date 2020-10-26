#ARM Torpedo Launcher Torpedo Weapon
#COAX_TORPEDO
#
#Script created by Raevn

local TAUnderWaterProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TAUnderWaterProjectile

COAX_TORPEDO = Class(TAUnderWaterProjectile) {
	TrackTime = 3,
	
	OnCreate = function(self)
		ForkThread(self.MovementThread, self)
		TAUnderWaterProjectile.OnCreate(self)
	end,

	MovementThread = function(self)
		self:TrackTarget(true)
		WaitSeconds(0.1)
		self:SetTurnRate(50)
		local target = self:GetTrackingTarget()
		if target and IsBlip(target) then target = target:GetSource() end
		if target and IsUnit(target) then
			local layer = target:GetCurrentLayer()
			if layer == 'Sub' then
				self:ForkThread(self.PassDamageThread)
			end
		end
	end,

	PassDamageThread = function(self)
		local bp = self:GetLauncher():GetBlueprint().Weapon
		WaitSeconds(0.1)
		self.DamageData.DamageAmount = bp.DamageWater or 300
		self.DamageData.DamageRadius = bp.DamageRadiusWater or 0.5
	end,
}

TypeClass = COAX_TORPEDO
