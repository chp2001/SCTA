#CORE Doomsday Machine - Energy Weapon
#CORDOOM
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAPopLaser = import('/mods/SCTA-master/lua/TAweapon.lua').TAPopLaser

CORDOOM = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.Fold, self)
	end,

	Fold = function(self)
		TAunit.Fold(self)
	end,



	Weapons = {
		CORE_DOOMSDAY = Class(TAPopLaser) {

			PlayFxWeaponUnpackSequence = function(self)
				TAPopLaser.PlayFxWeaponUnpackSequence(self)
			end,	

			PlayFxWeaponPackSequence = function(self)
				TAPopLaser.PlayFxWeaponPackSequence(self)
			end,	
		},
		CORE_LIGHTLASER = Class(TAPopLaser) {
			PlayFxWeaponUnpackSequence = function(self)
				while (not self.unit.Pack) do
					WaitSeconds(0.2)
				end
				TAPopLaser.PlayFxWeaponUnpackSequence(self)
                        end,
                },
	


		CORE_LASERH1 = Class(TAPopLaser) {
			PlayFxWeaponUnpackSequence = function(self)
				while (not self.unit.Pack) do
					WaitSeconds(0.2)
				end
				TAPopLaser.PlayFxWeaponUnpackSequence(self)
                        end,
                },

	},
}

TypeClass = CORDOOM
