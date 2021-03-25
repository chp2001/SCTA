#CORE Avenger - Fighter
#CORVENG
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORVENG = Class(TAair) {
	OnCreate = function(self)
		TAair.OnCreate(self)
		self.Spinners = {
			base = CreateRotator(self, 0, 'z', nil, 0, 0, 0),
			winga = CreateRotator(self, 'winga', 'z', nil, 0, 0, 0),
			wingb = CreateRotator(self, 'wingb', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OpenWings = function(self)
		--TURN winga to z-axis <-91.21> SPEED <63.22>;
		self.Spinners.winga:SetGoal(90)
		self.Spinners.winga:SetSpeed(63)

		--TURN wingb to z-axis <91.21> SPEED <63.22>;
		self.Spinners.wingb:SetGoal(-90)
		self.Spinners.wingb:SetSpeed(63)
	end,

	CloseWings = function(self)
		--TURN winga to z-axis <0> SPEED <63.13>;
		self.Spinners.winga:SetGoal(0)
		self.Spinners.winga:SetSpeed(63)

		--TURN wingb to z-axis <0> SPEED <63.13>;
		self.Spinners.wingb:SetGoal(0)
		self.Spinners.wingb:SetSpeed(63)
	end,

	Weapons = {
		CORVTOL_MISSILE = Class(TAweapon) {},
		
	},
}

TypeClass = CORVENG