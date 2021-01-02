#CORE Advanced Radar Tower - Long Range Radar Tower
#CORARAD
#
#Script created by Raevn

local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

CORARAD = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'x', nil, 0, 0, 0),
			turret = CreateRotator(self, 'turret', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnDestroy = function(self)
		TACloser.OnDestroy(self)
		ChangeState(self, self.DeadState)
	end,

	OpeningState = State {
		Main = function(self)
			TACloser.Unfold(self)
			self:EnableIntel('Radar')
			self:PlayUnitSound('Activate')
			self.intelIsActive = true
			self:SetMaintenanceConsumptionActive()

			--SPIN turret around y-axis  SPEED <20.00>;
			self.Spinners.turret:ClearGoal()
			self.Spinners.turret:SetSpeed(20)

			--SPIN dish around x-axis  SPEED <-200.04>;
			self.Spinners.dish:ClearGoal()
			self.Spinners.dish:SetSpeed(-200)
			ChangeState(self, self.IdleOpenState)
		end,
	},


	ClosingState = State {
		Main = function(self)
			TACloser.Fold(self)
			self:DisableIntel('Radar')

			self:PlayUnitSound('Deactivate')

			--SPIN turret around y-axis  SPEED <0.00>;
			self.Spinners.turret:ClearGoal()
			self.Spinners.turret:SetSpeed(0)

			--SPIN dish around x-axis  SPEED <0.0>;
			self.Spinners.dish:ClearGoal()
			self.Spinners.dish:SetSpeed(0)

			ChangeState(self, self.IdleClosedState)
		end,

	},

	IdleClosedState = State {
		Main = function(self)
			if self.closeDueToDamage then 
				while self.DamageSeconds > 0 do
					WaitSeconds(1)
					self.DamageSeconds = self.DamageSeconds - 1
				end

				self.closeDueToDamage = nil

				if self.intelIsActive then 
					ChangeState(self, self.OpeningState)
				end
			end
		end,

		OnDamage = function(self, instigator, amount, vector, damageType)
			TACloser.OnDamage(self, instigator, amount, vector, damageType) 

			self.DamageSeconds = 8
			ChangeState(self, self.ClosingState)
		end,

	},

	IdleOpenState = State {
		Main = function(self)
		end,

		OnDamage = function(self, instigator, amount, vector, damageType)
			TACloser.OnDamage(self, instigator, amount, vector, damageType)
			self.DamageSeconds = 8
			self.closeDueToDamage = true
			ChangeState(self, self.ClosingState)
		end,

	},

	OnScriptBitSet = function(self, bit)
		if bit == 3 then
			self.intelIsActive = nil
			self:SetMaintenanceConsumptionInactive()
			ChangeState(self, self.ClosingState)
		end
		TACloser.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			self.intelIsActive = true
			self:SetMaintenanceConsumptionActive()
			ChangeState(self, self.OpeningState)
		end
		TACloser.OnScriptBitClear(self, bit)
	end,

	DeadState = State {
		Main = function(self)
		end,
	},
}

TypeClass = CORARAD