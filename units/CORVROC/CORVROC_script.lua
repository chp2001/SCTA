#CORE Diplomat - Mobile Rocket Launcher
#CORVROC
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TARocket = import('/mods/SCTA-master/lua/TAweapon.lua').TARocket

CORVROC = Class(TAunit) {
	Weapons = {
		CORTRUCK_ROCKET = Class(TARocket) {

    			PlayFxRackReloadSequence = function(self)
				self.unit:ShowBone('dummy', true)
				TARocket.PlayFxRackReloadSequence(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				self.unit:ShowBone('dummy', true)
				TARocket.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)
				TARocket.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}
TypeClass = CORVROC
