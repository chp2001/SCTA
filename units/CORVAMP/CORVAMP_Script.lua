#CORE Vamp - Stealth Fighter
#CORVAMP
#
#Script created by Raevn

local TAIntelAir = import('/mods/SCTA-master/lua/TAair.lua').TAIntelAir
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORVAMP = Class(TAIntelAir) {

	OnCreate = function(self)
		TAIntelAir.OnCreate(self)
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
		--TURN winga to z-axis <-111.67> SPEED <76.81>;
		self.Spinners.winga:SetGoal(111.67)
		self.Spinners.winga:SetSpeed(77)

		--TURN wingb to z-axis <111.67> SPEED <76.81>;
		self.Spinners.wingb:SetGoal(-111.67)
		self.Spinners.wingb:SetSpeed(77)
	end,

	CloseWings = function(self)

		self.Spinners.winga:SetGoal(0)
		self.Spinners.winga:SetSpeed(77)

		--TURN wingb to z-axis <0> SPEED <76.87>;
		self.Spinners.wingb:SetGoal(0)
		self.Spinners.wingb:SetSpeed(77)
	end,

	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = CORVAMP