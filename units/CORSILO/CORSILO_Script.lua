#CORE Silencer - Nuclear Missile Launcher
#CORSILO
#
#Script created by Raevn

local TAnoassistbuild = import('/mods/SCTA-master/lua/TAStructure.lua').TAnoassistbuild
local TIFStrategicMissileWeapon = import('/lua/terranweapons.lua').TIFStrategicMissileWeapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORSILO = Class(TAnoassistbuild) {
	
	OnCreate = function(self)
		TAnoassistbuild.OnCreate(self)
	end,

	Weapons = {
		CRBLMSSL = Class(TIFStrategicMissileWeapon) {
			PlayFxWeaponUnpackSequence = function(self)
				TIFStrategicMissileWeapon.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)
				TIFStrategicMissileWeapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}

TypeClass = CORSILO
