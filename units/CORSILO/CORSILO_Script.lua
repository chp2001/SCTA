#CORE Silencer - Nuclear Missile Launcher
#CORSILO
#
#Script created by Raevn

local TAnoassistbuild = import('/mods/SCTA-master/lua/TAStructure.lua').TAnoassistbuild
local TIFStrategicMissileWeapon = import('/lua/terranweapons.lua').TIFStrategicMissileWeapon


CORSILO = Class(TAnoassistbuild) {
	Weapons = {
		CRBLMSSL = Class(TIFStrategicMissileWeapon) {
		},
	},
}

TypeClass = CORSILO
