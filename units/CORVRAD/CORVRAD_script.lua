#CORE Informer - Mobile Radar
#CORVRAD
#
#Script created by Raevn
local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter

CORVRAD = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 100, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACounter.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
	end,
}
TypeClass = CORVRAD