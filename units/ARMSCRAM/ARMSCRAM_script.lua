local TASeaCounter = import('/mods/SCTA-master/lua/TAMotion.lua').TASeaCounter

ARMSCRAM = Class(TASeaCounter) {
	OnCreate = function(self)
		TASeaCounter.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'fork', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TASeaCounter.OnStopBeingBuilt(self,builder,layer)
		--spin fork around z-axis speed <100>
		self.Spinners.fork:SetSpeed(100)
	end,


	OnIntelDisabled = function(self)
		self.Spinners.fork:SetSpeed(0)
		self:PlayUnitSound('Deactivate')
	TASeaCounter.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
	self.Spinners.fork:SetSpeed(100)
	self:PlayUnitSound('Activate')
	TASeaCounter.OnIntelEnabled(self)
end,
}
TypeClass = ARMSCRAM