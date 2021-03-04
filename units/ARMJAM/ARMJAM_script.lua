#ARM Jammer - Mobile Radar Jammer
#ARMJAM
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

ARMJAM = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'Jammer', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.fork:SetSpeed(100)
	end,


	OnIntelDisabled = function(self)
		self.Spinners.fork:SetSpeed(0)
		self:PlayUnitSound('Deactivate')
		TAunit.OnIntelDisabled(self)
	end,


	OnIntelEnabled = function(self)
		self.Spinners.fork:SetSpeed(100)
		self:PlayUnitSound('Activate')
		TAunit.OnIntelEnabled(self)
	end,
}
TypeClass = ARMJAM