#ARM Scarab - Anti Missile
#ARMSCAB
#
#Blueprint created by Dragun

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local DefaultWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

ARMSCAB = Class(TAWalking) {
	Weapons = {
			Turret01 = Class(DefaultWeapon) {}
	},
}

TypeClass = ARMSCAB