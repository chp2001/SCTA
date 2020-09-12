#ARM Peewee - Infantry Kbot
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMPW = Class(TAWalking) {
		Weapons = {
			EMG = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
			end,
		},
	},
}

TypeClass = ARMPW
