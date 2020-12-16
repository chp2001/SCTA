#CORE Solar Collector - Produces Energy
#CORSOLAR
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

CORSOLAR = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		self.productionIsActive = true
		closeDueToDamage = nil,
		ChangeState(self, self.OpeningState)
	end,

	OpeningState = State {
		Main = function(self)
			self:PlayUnitSound('Activate')
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen)
			self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationOpenRate or 0.2))
			self:SetProductionActive(true)
			ChangeState(self, self.IdleOpenState)
		end,
	},


	ClosingState = State {
		Main = function(self)
			self:SetProductionActive(false)
			self:PlayUnitSound('Activate')
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen)
			self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationOpenRate or 0.2))
			ChangeState(self, self.IdleClosedState)
		end,

	},

	IdleClosedState = State {
		Main = function(self)
			#Building was closed due to damage
			if self.closeDueToDamage then 
				while self.DamageSeconds > 0 do
					WaitSeconds(1)
					self.DamageSeconds = self.DamageSeconds - 1
				end

				self.closeDueToDamage = nil

				#Only Open if set to active
				if self.productionIsActive then 
					ChangeState(self, self.OpeningState)
				end
			end
		end,

	},

	IdleOpenState = State {
		Main = function(self)
		end,

		OnDamage = function(self, instigator, amount, vector, damageType)
			TAunit.OnDamage(self, instigator, amount, vector, damageType)
			self.DamageSeconds = 8
			self.closeDueToDamage = true
			ChangeState(self, self.ClosingState)
		end,

	},
		
	OnProductionUnpaused = function(self)
		TAunit.OnProductionUnpaused(self)
		self.productionIsActive = true
		ChangeState(self, self.OpeningState)
	end,

	OnProductionPaused = function(self)
		TAunit.OnProductionPaused(self)
		self.productionIsActive = nil
		ChangeState(self, self.ClosingState)
	end,



	OnDamage = function(self, instigator, amount, vector, damageType)
		TAunit.OnDamage(self, instigator, amount, vector, damageType) 
		self.DamageSeconds = 8
	end,
}

TypeClass = CORSOLAR