#CORE Diplomat - Mobile Rocket Launcher
#CORHRK
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TARocket = import('/mods/SCTA-master/lua/TAweapon.lua').TARocket

CORHRK = Class(TAWalking) {
	Weapons = {
		CORTRUCK_ROCKET = Class(TARocket) {

				PlayFxRackReloadSequence = function(self)
					self.unit:ShowBone('Missile1', true)
					WaitSeconds(0.025)
					self.unit:ShowBone('Missile2', true)
				TARocket.PlayFxRackReloadSequence(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				self.unit:ShowBone('Missile1', true)
				WaitSeconds(0.025)
				self.unit:ShowBone('Missile2', true)
				TARocket.PlayFxWeaponUnpackSequence(self)
			end,
		},		
	},
}
TypeClass = CORHRK
