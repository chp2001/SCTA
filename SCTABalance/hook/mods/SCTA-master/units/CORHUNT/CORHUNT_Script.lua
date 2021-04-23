local oldCORHUNT = CORHUNT
CORHUNT = Class(oldCORHUNT) { 
    OnIntelEnabled = function(self)
        oldCORHUNT.OnIntelEnabled(self)
        self:EnableUnitIntel('ToggleBit8', 'CloakField')
    end,

    OnIntelDisabled = function(self)
        oldCORHUNT.OnIntelDisabled(self)
        self:DisableUnitIntel('ToggleBit8', 'CloakField')
    end,

}

TypeClass = CORHUNT
