#CORE Shipyard - Produces Ships
#CORDY
#
#Script created by Raevn

local TASeaFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TASeaFactory

CORDSY = Class(TASeaFactory) {

	OnCreate = function(self)
		TASeaFactory.OnCreate(self)
		self.Spinners = {
			turreta = CreateRotator(self, 'turreta', 'y', nil, 0, 0, 0),
			turretb = CreateRotator(self, 'turretb', 'y', nil, 0, 0, 0),
			gunax = CreateRotator(self, 'guna', 'x', nil, 0, 0, 0),
			--gunaz = CreateRotator(self, 'guna', 'z', nil, 0, 0, 0),
			gunbx = CreateRotator(self, 'gunb', 'x', nil, 0, 0, 0),
			--gunbz = CreateRotator(self, 'gunb', 'z', nil, 0, 0, 0),
		}
		self.Sliders = {
			turreta = CreateSlider(self, 'turreta'),
			turretb = CreateSlider(self, 'turretb'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	Open = function(self)

		--MOVE turreta to y-axis <6.89> SPEED <5.00>;
		self.Sliders.turreta:SetGoal(0,6.9,0)
		self.Sliders.turreta:SetSpeed(5)

		--MOVE turretb to y-axis <6.94> SPEED <5.00>;
		self.Sliders.turretb:SetGoal(0,6.9,0)
		self.Sliders.turretb:SetSpeed(5)

		--TURN turreta to y-axis <-33.98> SPEED <47.07>;
		self.Spinners.turreta:SetGoal(-34)
		self.Spinners.turreta:SetSpeed(47)

		--TURN turretb to y-axis <-43.00> SPEED <59.58>;
		self.Spinners.turretb:SetGoal(-43)
		self.Spinners.turretb:SetSpeed(60)

		--TURN gunb to x-axis <-71.68> SPEED <99.30>;
		self.Spinners.gunbx:SetGoal(-72)
		self.Spinners.gunbx:SetSpeed(99)

		--TURN guna to x-axis <66.90> SPEED <92.68>;
		self.Spinners.gunax:SetGoal(66.90)
		self.Spinners.gunax:SetSpeed(92.68)

		TASeaFactory.Open(self)
	end,


	Close = function(self)
		TASeaFactory.Close(self)
		--TURN turreta to y-axis <0> SPEED <50.28>;
		self.Spinners.turreta:SetGoal(0)
		self.Spinners.turreta:SetSpeed(50.28)

		--TURN turretb to y-axis <0> SPEED <63.63>;
		self.Spinners.turretb:SetGoal(0)
		self.Spinners.turretb:SetSpeed(63.63)

		--TURN gunb to x-axis <0> SPEED <106.06>;
		self.Spinners.gunbx:SetGoal(0)
		self.Spinners.gunbx:SetSpeed(106.06)

		--TURN guna to x-axis <0> SPEED <98.98>;
		self.Spinners.gunax:SetGoal(0)
		self.Spinners.gunax:SetSpeed(98.98)

		--MOVE turreta to y-axis <0> SPEED <5.00>;
		self.Sliders.turreta:SetGoal(0,0,0)
		self.Sliders.turreta:SetSpeed(5)

		--MOVE turretb to y-axis <0> SPEED <5.00>;
		self.Sliders.turretb:SetGoal(0,0,0)
		self.Sliders.turretb:SetSpeed(5)
	end,


}

TypeClass = CORDSY