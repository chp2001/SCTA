#ARM Pelican - Amphibious Kbot
#ARMAMPH
#
#Script created by Axle

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORAMPH = Class(TAunit) {

	Weapons = {
		armamph_weapon2 = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				TAunit.ShowMuzzleFlare(self, 0.15)
			end,
		},
	},
}

TypeClass = CORAMPH
