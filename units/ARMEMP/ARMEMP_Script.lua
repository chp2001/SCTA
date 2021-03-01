#CORE Silencer - Nuclear Missile Launcher
#CORSILO
#
#Script created by Raevn

local TAnoassistbuild = import('/mods/SCTA-master/lua/TAStructure.lua').TAnoassistbuild
local TIFStrategicMissileWeapon = import('/lua/terranweapons.lua').TIFStrategicMissileWeapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMEMP = Class(TAnoassistbuild) {
	Weapons = {
		EMBMSSL = Class(TIFStrategicMissileWeapon) {
		},
	},
}

TypeClass = ARMEMP
