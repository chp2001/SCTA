#ARM Zipper - Fast Attack Kbot
#ARMFAST
#
#Script created by Raevn

local TACloaker = import('/mods/SCTA-master/lua/TAMotion.lua').TACloaker
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSNIPE = Class(TACloaker) {
    OnStopBeingBuilt = function(self, builder, layer)
		TACloaker.OnStopBeingBuilt(self, builder, layer)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,

	Weapons = {
		ARM_FAST = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
			end,
		},
	},
}
TypeClass = ARMSNIPE