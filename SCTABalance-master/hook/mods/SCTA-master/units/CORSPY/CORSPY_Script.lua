local oldCORSPY = CORSPY
CORSPY = Class(oldCORSPY) { 

	OnIntelDisabled = function(self)
		local bp = self:GetBlueprint()
		oldCORSPY.OnIntelDisabled(self)
		--self.SetJammerBlips(0) 
	end,

	OnIntelEnabled = function(self)
		local bp = self:GetBlueprint()
		oldCORSPY.OnIntelEnabled(self)
		---self.SetJammerBlips(bp.Intel.JammerBlips * 5)
	end,
}

TypeClass = CORSPY
