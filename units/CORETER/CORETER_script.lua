#CORE Deleter - Mobile Radar Jammer
#CORETER
#
#Script created by Raevn

local TATreads = import('/mods/SCTA-master/lua/TAMotion.lua').TATreads

CORETER = Class(TATreads) {
	OnCreate = function(self)
		TATreads.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'fork', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TATreads.OnStopBeingBuilt(self,builder,layer)
		--spin fork around z-axis speed <100>
		self.Spinners.fork:SetSpeed(100)
		self:SetMaintenanceConsumptionActive()
	end,


	OnScriptBitSet = function(self, bit)
		if bit == 5 then
			--spin fork around z-axis speed <0>
			self.Spinners.fork:SetSpeed(0)
			self:SetMaintenanceConsumptionInactive()
			self:PlayUnitSound('Deactivate')
		end
		TATreads.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 5 then
			--spin fork around z-axis speed <100>
			self.Spinners.fork:SetSpeed(100)
			self:SetMaintenanceConsumptionActive()
			self:PlayUnitSound('Activate')
		end
		TATreads.OnScriptBitClear(self, bit)
	end,
}
TypeClass = CORETER