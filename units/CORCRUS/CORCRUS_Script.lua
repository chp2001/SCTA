#CORE Executioner - Cruiser
#CORCRUS
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORCRUS = Class(TAunit) {
	Weapons = {
		COR_CRUS = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
			end,
		},
		COREDEPTHCHARGE = Class(TAweapon) {},
	},
}

TypeClass = CORCRUS
