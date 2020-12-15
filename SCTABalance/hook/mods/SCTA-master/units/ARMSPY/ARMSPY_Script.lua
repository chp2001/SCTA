local oldARMSPY = ARMSPY
ARMSPY = Class(oldARMSPY) { 

	OnIntelDisabled = function(self)
		local bp = self:GetBlueprint()
		oldARMSPY.OnIntelDisabled(self)
		--self.SetJammerBlips(0) 
	end,

	OnIntelEnabled = function(self)
		local bp = self:GetBlueprint()
		oldARMSPY.OnIntelEnabled(self)
		---self.SetJammerBlips(bp.Intel.JammerBlips * 5)
	end,
}

TypeClass = ARMSPY
