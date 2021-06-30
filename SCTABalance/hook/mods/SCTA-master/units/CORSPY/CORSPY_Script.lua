local oldCORSPY = CORSPY
CORSPY = Class(oldCORSPY) { 

	OnIntelDisabled = function(self)
		oldCORSPY.OnIntelDisabled(self)
		self:DisableIntel('RadarStealth')
		self:EnableIntel('Jammer')
	end,

	OnIntelEnabled = function(self)
		oldCORSPY.OnIntelEnabled(self)
		self:EnableIntel('RadarStealth')
		self:DisableIntel('Jammer')
	end,
}

TypeClass = CORSPY
