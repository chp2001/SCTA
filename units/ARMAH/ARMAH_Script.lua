#ARM Swatter - Anti-Air Hovercraft
#ARMAH
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMAH = Class(TASea) {
	OnCreate = function(self)
		TASea.OnCreate(self)
		self.Sliders = {
			box = CreateSlider(self, 'Box'),
		}
		self.Spinners = {
			box = CreateRotator(self, 'Box', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	Weapons = {
		ARMAH_WEAPON = Class(TAweapon) {

			PlayFxWeaponUnpackSequence = function(self)
				self.unit.Sliders.box:SetGoal(0,1,-0.6)
				self.unit.Sliders.box:SetSpeed(6)
				--MOVE Box to y-axis <1.95> SPEED <14.00>
				--MOVE Box to z-axis <-0.60> SPEED <4.00>
				self.unit.Spinners.box:SetGoal(-20)
				self.unit.Spinners.box:SetSpeed(15)


				TAweapon.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)
				self.unit.Sliders.box:SetGoal(0,0,0)
				self.unit.Sliders.box:SetSpeed(6)
				self.unit.Spinners.box:SetGoal(0)
				self.unit.Spinners.box:SetSpeed(45)
				--SLEEP <7>
				TAweapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}

TypeClass = ARMAH
