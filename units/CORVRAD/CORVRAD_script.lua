#CORE Informer - Mobile Radar
#CORVRAD
#
#Script created by Raevn
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

CORVRAD = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 100, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
	end,
}
TypeClass = CORVRAD