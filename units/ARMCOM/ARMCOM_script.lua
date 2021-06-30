#ARM Commander - Commander
#ARMCOM
#
#Script created by Raevn

local TARealCommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TARealCommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

local TACommanderDeathWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderDeathWeapon

#ARM Commander - Commander

ARMCOM = Class(TARealCommander) {

	Weapons = {
		COMLASER = Class(TAweapon) {
		},
		OverCharge = Class(TADGun) {
		},		
		AutoOverCharge = Class(TADGun) {
		},
		DeathWeapon = Class(TACommanderDeathWeapon) {},
	},


}

TypeClass = ARMCOM