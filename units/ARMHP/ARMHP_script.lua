#ARM Hovercraft Platform - Builds Hovercraft
#ARMHP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMHP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			door1 = CreateRotator(self, 'door1', 'z', nil, 0, 0, 0),
			door2 = CreateRotator(self, 'door2', 'z', nil, 0, 0, 0),
			post1 = CreateRotator(self, 'post1', 'x', nil, 0, 0, 0),
			post2 = CreateRotator(self, 'post2', 'x', nil, 0, 0, 0),
			post1x = CreateRotator(self, 'post1', 'z', nil, 0, 0, 0),
			post2x = CreateRotator(self, 'post2', 'z', nil, 0, 0, 0),
			nano1 = CreateRotator(self, 'nano1', 'x', nil, 0, 0, 0),
			nano2 = CreateRotator(self, 'nano2', 'x', nil, 0, 0, 0),
			pad = CreateRotator(self, 'pad', 'y', nil, 0, 0, 0),
		}
		self.Sliders = {
			door1 = CreateSlider(self, 'door1'),
			door2 = CreateSlider(self, 'door2'),
			plate1 = CreateSlider(self, 'plate2'),
			plate2 = CreateSlider(self, 'plate1'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,


	Open = function(self)

		--TURN door1 to z-axis <-90.00> SPEED <175.13>;
		self.Spinners.door1:SetGoal(-90)
		self.Spinners.door1:SetSpeed(175)

		--TURN door2 to z-axis <90.00> SPEED <175.13>;
		self.Spinners.door2:SetGoal(90)
		self.Spinners.door2:SetSpeed(175)

		--MOVE door1 to y-axis <-5.25> SPEED <10.00>;
		self.Sliders.door1:SetGoal(5.25,0,0)
		self.Sliders.door1:SetSpeed(10)

		--MOVE door2 to y-axis <-5.85> SPEED <11.00>;
		self.Sliders.door2:SetGoal(-5.25,0,0)
		self.Sliders.door2:SetSpeed(10)

		--MOVE plate1 to y-axis <4.05> SPEED <7.00>;
		self.Sliders.plate1:SetGoal(0,3.75,0) #Stuck out
		self.Sliders.plate1:SetSpeed(7)

		--MOVE plate2 to y-axis <4.15> SPEED <7.00>;
		self.Sliders.plate2:SetGoal(0,3.75,0) #Stuck out
		self.Sliders.plate2:SetSpeed(7)

		self.Spinners.post2:SetGoal(90)
		self.Spinners.post2:SetSpeed(173.45)

		self.Spinners.post1:SetGoal(90)
		self.Spinners.post1:SetSpeed(173.45)

		--TURN nano2 to y-axis <-90.00> SPEED <173.45>;
		self.Spinners.nano2:SetGoal(-65) #Changed to aim better
		self.Spinners.nano2:SetSpeed(173.45)

		--TURN nano1 to y-axis <90.00> SPEED <173.45>;
		self.Spinners.nano1:SetGoal(-65) #Changed to aim better
		self.Spinners.nano1:SetSpeed(173.45)

		self.Spinners.post2x:SetGoal(90)
		self.Spinners.post2x:SetSpeed(173.45)

		self.Spinners.post1x:SetGoal(-90)
		self.Spinners.post1x:SetSpeed(173.45)

		TAFactory.Open(self)
	end,

	Close = function(self)

		self.Spinners.post2x:SetGoal(0)
		self.Spinners.post2x:SetSpeed(173.45)

		self.Spinners.post1x:SetGoal(0)
		self.Spinners.post1x:SetSpeed(173.45)


		--TURN nano2 to y-axis <0> SPEED <173.45>;
		self.Spinners.nano2:SetGoal(0)
		self.Spinners.nano2:SetSpeed(173.45)

		--TURN nano1 to y-axis <0> SPEED <173.45>;
		self.Spinners.nano1:SetGoal(0)
		self.Spinners.nano1:SetSpeed(173.45)

		self.Spinners.post2:SetGoal(0)
		self.Spinners.post2:SetSpeed(173.45)

		self.Spinners.post1:SetGoal(0)
		self.Spinners.post1:SetSpeed(173.45)

		--MOVE plate1 to y-axis <0> SPEED <7.00>;
		self.Sliders.plate1:SetGoal(0,0,0)
		self.Sliders.plate1:SetSpeed(7)

		--MOVE plate2 to y-axis <0> SPEED <7.00>;
		self.Sliders.plate2:SetGoal(0,0,0)
		self.Sliders.plate2:SetSpeed(7)

		--MOVE door1 to y-axis <0> SPEED <10.00>;
		self.Sliders.door1:SetGoal(0,0,0)
		self.Sliders.door1:SetSpeed(10)

		--MOVE door2 to y-axis <0> SPEED <11.00>;
		self.Sliders.door2:SetGoal(0,0,0)
		self.Sliders.door2:SetSpeed(10)

		--TURN door1 to z-axis <0> SPEED <175.13>;
		self.Spinners.door1:SetGoal(0)
		self.Spinners.door1:SetSpeed(175)

		--TURN door2 to z-axis <0> SPEED <175.13>;
		self.Spinners.door2:SetGoal(0)
		self.Spinners.door2:SetSpeed(175)
		TAFactory.Close(self)
	end,
}

TypeClass = ARMHP