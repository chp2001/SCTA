local oldARMSEHAK = ARMSEHAK
ARMSEHAK = Class(oldARMSEHAK) { 
    OnIntelEnabled = function(self)
        oldARMSEHAK.OnIntelEnabled(self)
        self:EnableUnitIntel('ToggleBit8', 'CloakField')
    end,

    OnIntelDisabled = function(self)
        oldARMSEHAK.OnIntelDisabled(self)
        self:DisableUnitIntel('ToggleBit8', 'CloakField')
    end,

}

TypeClass = ARMSEHAK
