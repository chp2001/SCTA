#CORE The SUMO - Armored Assault Kbot
#CORSUMO
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon


CORSUMO = Class(TAWalking) {

	Weapons = {
		CORE_SUMOLASER = Class(TAweapon) {
		},
	},
}
TypeClass = CORSUMO