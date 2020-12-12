#CORE Hive - Light Carrier
#CORCARRY
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

CORCARRY = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,

	
	OnCreate = function(self)
		TAFactory.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.dish)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
		--SPIN dish around y-axis SPEED <60.01>
		self.Spinners.dish:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
	end,

	Open = function(self)
		TAFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
	end,

	Aim = function(self, target)
		TAFactory.Aim(self, target)
		WaitFor(self.AnimManip)
	end,

	Close = function(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
		ChangeState(self, self.IdleState)
		TAFactory.Close(self)
	end,

	OnScriptBitSet = function(self, bit)
		if bit == 3 then

			self.Spinners.dish:SetSpeed(0)

			self:SetMaintenanceConsumptionInactive()
		end
		TAFactory.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			--SPIN dish around y-axis SPEED <60.01>
			self.Spinners.dish:SetSpeed(60)
			self:SetMaintenanceConsumptionActive()
		end
		TAFactory.OnScriptBitClear(self, bit)
	end,
}

TypeClass = CORCARRY
