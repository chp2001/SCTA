local oldARMSPY = ARMSPY
ARMSPY = Class(oldARMSPY) { 

	OnIntelDisabled = function(self)
		oldARMSPY.OnIntelDisabled(self)
		self:DisableIntel('RadarStealth')
		self:EnableIntel('Jammer')
	end,

	OnIntelEnabled = function(self)
		oldARMSPY.OnIntelEnabled(self)
		self:EnableIntel('RadarStealth')
		self:DisableIntel('Jammer')
	end,
}

TypeClass = ARMSPY
