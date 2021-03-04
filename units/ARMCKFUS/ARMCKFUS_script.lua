#ARM Cloakable Fusion Reactor - Produces Energy
#ARMCKFUS
#
#Blueprint created by Raevn

local TACKFusion = import('/mods/SCTA-master/lua/TAStructure.lua').TACKFusion

ARMCKFUS = Class(TACKFusion) {
    OnStopBeingBuilt = function(self,builder,layer)
        TACKFusion.OnStopBeingBuilt(self,builder,layer)
        self:SetScriptBit('RULEUTC_CloakToggle', false)
        self:RequestRefreshUI()
    end,
}

TypeClass = ARMCKFUS
