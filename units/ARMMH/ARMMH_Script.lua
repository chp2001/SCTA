#ARM Wombat - Hovercraft Rocket Launcher
#ARMMH
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMMH = Class(TASea) {
	OnCreate = function(self)
		TASea.OnCreate(self)
		self.Spinners = {
			box = CreateRotator(self, 'Box', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	Weapons = {
		ARMMH_WEAPON = Class(TAweapon) {

			PlayFxWeaponUnpackSequence = function(self)


				--TURN box to x-axis <-90.00> SPEED <8.91>
				self.unit.Spinners.box:SetGoal(-90.00)
				self.unit.Spinners.box:SetSpeed(45)
				WaitFor(self.unit.Spinners.box)

				--SLEEP <16>

				TAweapon.PlayFxWeaponUnpackSequence(self)
			end,

			PlayFxWeaponPackSequence = function(self)
				self.unit.Spinners.box:SetGoal(0)
				self.unit.Spinners.box:SetSpeed(90)
				WaitFor(self.unit.Spinners.box)
				--SLEEP <13>
				TAweapon.PlayFxWeaponPackSequence(self)
			end,
		},
	},
}

TypeClass = ARMMH
