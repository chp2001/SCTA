#ARM Colossus - Light Carrier
#ARMCARRY
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMCARRY = Class(TAFactory) {
	OnCreate = function(self)
		TAFactory.OnCreate(self)
		self.Spinners = {
			radar = CreateRotator(self, 'Radar', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
		--SPIN dish around y-axis SPEED <60.01>
		self.Spinners.radar:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
	end,


	Open = function(self)
		TAFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
	end,


	Close = function(self)
		TAFactory.Close(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
	end,

	OnScriptBitSet = function(self, bit)
		if bit == 3 then

			self.Spinners.radar:SetSpeed(0)

			self:SetMaintenanceConsumptionInactive()
		end
		TAFactory.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			--SPIN radar around y-axis SPEED <60.01>
			self.Spinners.radar:SetSpeed(60)
			self:SetMaintenanceConsumptionActive()
		end
		TAFactory.OnScriptBitClear(self, bit)
	end,
}

TypeClass = ARMCARRY
