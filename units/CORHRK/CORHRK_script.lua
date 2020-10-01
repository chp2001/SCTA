#CORE Diplomat - Mobile Rocket Launcher
#CORVROC
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORVROC = Class(TAWalking) {
	
	OnCreate = function(self)
		TAWalking.OnCreate(self)
	end,

	Weapons = {
		CORTRUCK_ROCKET = Class(TAweapon) {

    			PlayFxRackReloadSequence = function(self)
				TAweapon.PlayFxRackReloadSequence(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				TAweapon.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)

				TAweapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}
TypeClass = CORVROC
