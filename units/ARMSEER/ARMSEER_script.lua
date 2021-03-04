#ARM Seer - Mobile Radar
#ARMSEER
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter

ARMSEER = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'Radar', 'y', nil, 0, 120, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACounter.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
	end,


	OnIntelDisabled = function(self)
		self.Spinners.dish:SetSpeed(0)
	TACounter.OnIntelDisabled(self)
	end,


	OnIntelEnabled = function(self)
		self.Spinners.dish:SetSpeed(100)
		TACounter.OnIntelEnabled(self)
	end,
}
TypeClass = ARMSEER