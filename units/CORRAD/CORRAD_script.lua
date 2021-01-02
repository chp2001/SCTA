#CORE Radar Tower - Radar Tower
#CORRAD
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

CORRAD = Class(TAStructure) {
	OnCreate = function(self)
		TAStructure.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAStructure.OnStopBeingBuilt(self,builder,layer)
		self.StartSpin(self)
		self:PlayUnitSound('Activate')
	end,

	OnScriptBitSet = function(self, bit)
		if bit == 3 then
			self:PlayUnitSound('Deactivate')
			self.StopSpin(self)
		end
		TAStructure.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			self:PlayUnitSound('Activate')
			self.StartSpin(self)
		end
		TAStructure.OnScriptBitClear(self, bit)
	end,

	StartSpin = function(self)
		--SPIN dish around y-axis SPEED <40>
		self.Spinners.dish:SetSpeed(40)

		self:SetMaintenanceConsumptionActive()
	end,

	StopSpin = function(self)
		--SPIN dish around y-axis SPEED <0>
		self.Spinners.dish:SetSpeed(0)

		self:SetMaintenanceConsumptionInactive()
	end,
}

TypeClass = CORRAD