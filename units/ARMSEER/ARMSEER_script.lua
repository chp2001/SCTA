#ARM Seer - Mobile Radar
#ARMSEER
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

ARMSEER = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'Radar', 'y', nil, 0, 120, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
		self:OnIntelEnabled()
	end,


	OnIntelDisabled = function(self)
		self.Spinners.dish:SetSpeed(0)
	TAunit.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
	self.Spinners.dish:SetSpeed(100)
	TAunit.OnIntelEnabled(self)
end,
}
TypeClass = ARMSEER