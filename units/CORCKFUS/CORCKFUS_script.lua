#ARM Cloakable Fusion Reactor - Produces Energy
#CORCKFUS
#
#Blueprint created by Raevn

local TACKFusion = import('/mods/SCTA-master/lua/TAStructure.lua').TACKFusion

CORCKFUS = Class(TACKFusion) {
    OnStopBeingBuilt = function(self,builder,layer)
        TACKFusion.OnStopBeingBuilt(self,builder,layer)
        self:SetScriptBit('RULEUTC_CloakToggle', false)
        self:RequestRefreshUI()
    end,
}

TypeClass = CORCKFUS
