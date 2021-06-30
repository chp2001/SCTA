#CORE Rapier - Gunship
#CORAPE
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local TARotatingWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TARotatingWeapon

CORAPE = Class(TAair) {
	OnCreate = function(self)
		TAair.OnCreate(self)
		self.Spinners = {
			winga = CreateRotator(self, 'winga', 'z', nil, 0, 0, 0),
			wingb = CreateRotator(self, 'wingb', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OpenWings = function(self)
		--TURN winga to z-axis <-90.00> SPEED <120.02>;
		self.Spinners.winga:SetGoal(90)
		self.Spinners.winga:SetSpeed(120.02)

		--TURN wingb to z-axis <90.00> SPEED <120.02>;
		self.Spinners.wingb:SetGoal(-90)
		self.Spinners.wingb:SetSpeed(120.02)
	end,

	CloseWings = function(self)
		--TURN winga to z-axis <0> SPEED <120.02>;
		self.Spinners.winga:SetGoal(0)
		self.Spinners.winga:SetSpeed(120.02)

		--TURN wingb to z-axis <0> SPEED <120.02>;
		self.Spinners.wingb:SetGoal(0)
		self.Spinners.wingb:SetSpeed(120.02)
	end,

	Weapons = {
		VTOL_ROCKET = Class(TARotatingWeapon) {
			PlayRackRecoil = function(self, rackList)
			if not self.Rotator then
				self.Rotator = CreateRotator(self.unit, 'gun1', 'z')
				self.Rotator2 = CreateRotator(self.unit, 'gun2', 'z')
			end
			self.MaxRound = 3
			self.Rotation = -120
			self.Speed = 1000
			TARotatingWeapon.PlayRackRecoil(self, rackList)
		end,
		},
	},
}

TypeClass = CORAPE