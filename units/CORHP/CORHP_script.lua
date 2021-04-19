#COR Hovercraft Platform - Builds Hovercraft
#CORHP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

CORHP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			beam1 = CreateRotator(self, 'beam1', 'y', nil, 0, 0, 0),
			beam2 = CreateRotator(self, 'beam2', 'y', nil, 0, 0, 0),
			beam3 = CreateRotator(self, 'beam3', 'y', nil, 0, 0, 0),
			beam4 = CreateRotator(self, 'beam4', 'y', nil, 0, 0, 0),
		}
			for k, v in self.Spinners do
				self.Trash:Add(v)
			end
		TAFactory.OnCreate(self)
	end,


	Open = function(self)
		TAFactory.Open(self)
		self.Spinners.beam1:SetGoal(90)
		self.Spinners.beam1:SetSpeed(175)
		
		--TURN door2 to z-axis <90.00> SPEED <175.13>;
		self.Spinners.beam2:SetGoal(90)
		self.Spinners.beam2:SetSpeed(175)
		
		self.Spinners.beam3:SetGoal(-90)
		self.Spinners.beam3:SetSpeed(175)
		
		--TURN door2 to z-axis <90.00> SPEED <175.13>;
		self.Spinners.beam4:SetGoal(-90)
		self.Spinners.beam4:SetSpeed(175)
	end,

	Close = function(self)
		TAFactory.Close(self)

		self.Spinners.beam1:SetGoal(0)
		self.Spinners.beam1:SetSpeed(175)
		
		--TURN door2 to z-axis <90.00> SPEED <175.13>;
		self.Spinners.beam2:SetGoal(0)
		self.Spinners.beam2:SetSpeed(175)

		self.Spinners.beam3:SetGoal(0)
		self.Spinners.beam3:SetSpeed(175)

--TURN door2 to z-axis <90.00> SPEED <175.13>;
		self.Spinners.beam4:SetGoal(0)
		self.Spinners.beam4:SetSpeed(175)
	end,
}

TypeClass = CORHP