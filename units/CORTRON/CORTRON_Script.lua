#CORE Silencer - Nuclear Missile Launcher
#CORSILO
#
#Script created by Raevn

local TAnoassistbuild = import('/mods/SCTA-master/lua/TAStructure.lua').TAnoassistbuild
local TIFStrategicMissileWeapon = import('/lua/terranweapons.lua').TIFStrategicMissileWeapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORTRON = Class(TAnoassistbuild) {
	OnCreate = function(self)
		TAnoassistbuild.OnCreate(self)
	end,

	Weapons = {
		EMBMSSL = Class(TIFStrategicMissileWeapon ) {},
	},
}

TypeClass = CORTRON
