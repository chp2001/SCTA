#CORE Diplomat - Mobile Rocket Launcher
#CORVROC
#
#Script created by Raevn

local TATreads = import('/mods/SCTA-master/lua/TAMotion.lua').TATreads
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORVROC = Class(TATreads) {
	Weapons = {
		CORTRUCK_ROCKET = Class(TAweapon) {

    			PlayFxRackReloadSequence = function(self)
				self.unit:ShowBone('dummy', true)
				TAweapon.PlayFxRackReloadSequence(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				self.unit:ShowBone('dummy', true)
				TAweapon.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)
				TAweapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}
TypeClass = CORVROC
