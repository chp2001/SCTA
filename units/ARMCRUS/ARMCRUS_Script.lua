#ARM Conqueror - Cruiser
#ARMCRUS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local DefaultWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

ARMCRUS = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {
		},
		Turret01 = Class(DefaultWeapon) {
		},
	},
}

TypeClass = ARMCRUS
