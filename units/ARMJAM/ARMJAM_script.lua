#ARM Jammer - Mobile Radar Jammer
#ARMJAM
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter

ARMJAM = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'Jammer', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACounter.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.fork:SetSpeed(100)
	end,


	OnIntelDisabled = function(self)
		self.Spinners.fork:SetSpeed(0)
		self:PlayUnitSound('Deactivate')
		TACounter.OnIntelDisabled(self)
	end,


	OnIntelEnabled = function(self)
		self.Spinners.fork:SetSpeed(100)
		self:PlayUnitSound('Activate')
		TACounter.OnIntelEnabled(self)
	end,
}
TypeClass = ARMJAM