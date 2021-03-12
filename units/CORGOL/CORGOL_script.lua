#CORE Goliath - Very Heavy Assault Tank
#CORGOL
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORGOL = Class(TAunit) {

	Weapons = {
		COR_GOL = Class(TAweapon) {

		},
	},
}
TypeClass = CORGOL
