#ARM Cloakable Fusion Reactor - Produces Energy
#ARMCKFUS
#
#Blueprint created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

ARMCKFUS = Class(TAStructure) {
    OnStopBeingBuilt = function(self,builder,layer)
        TAStructure.OnStopBeingBuilt(self,builder,layer)
        self:SetScriptBit('RULEUTC_CloakToggle', false)
        self:RequestRefreshUI()
    end,
}

TypeClass = ARMCKFUS
