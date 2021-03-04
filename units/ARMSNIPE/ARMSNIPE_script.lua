#ARM Zipper - Fast Attack Kbot
#ARMFAST
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSNIPE = Class(TACounter) {
    OnStopBeingBuilt = function(self, builder, layer)
		TACounter.OnStopBeingBuilt(self, builder, layer)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,

	Weapons = {
		ARM_FAST = Class(TAweapon) {
		},
	},
}
TypeClass = ARMSNIPE