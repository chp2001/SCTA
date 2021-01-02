#CORE Fortitude Missile Defense - Anti Missile Defense System
#CORFMD
#
#Script created by Raevn

local TAnoassistbuild = import('/mods/SCTA-master/lua/TAStructure.lua').TAnoassistbuild
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORFMD = Class(TAnoassistbuild) {
	OnCreate = function(self)
		TAnoassistbuild.OnCreate(self)
		self.Sliders = {
			dummy = CreateSlider(self, 'dummy'),
			drawer = CreateSlider(self, 'drawer'),
			wedge = CreateSlider(self, 'wedge'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		self.currentRound = 1
		self.PackTime = 0
	end,

	Weapons = {
		FMD_ROCKET = Class(TAweapon) {
		OnWeaponFired = function(self)
			self.unit:ShowBone('dummy', true)
			TAweapon.OnWeaponFired(self)
		end,

		},
	},
}

TypeClass = CORFMD
