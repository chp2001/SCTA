#ARM Adv. Construction Vehicle - Tech Level 2
#ARMACV
#
#Blueprint created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMACV = Class(TAconstructor) {

	OnCreate = function(self)
		self.Spinners = {
			door1 = CreateRotator(self, 'Door_01', 'z', nil, 0, 0, 0),
			door2 = CreateRotator(self, 'Door_02', 'z', nil, 0, 0, 0),
			arm = CreateRotator(self, 'Arm', 'x', nil, 0, 0, 0),
			nano = CreateRotator(self, 'Hinge', 'x', nil, 0, 0, 0),
			turret = CreateRotator(self, 'Turret', 'y', nil, 0, 0, 0),
			turretBarrel = CreateRotator(self, 'Build_Nozzle', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			plate = CreateSlider(self, 'Plate'),
			door1 = CreateSlider(self, 'Door_01'),
			door2 = CreateSlider(self, 'Door_02'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	Open = function(self)

		--TURN door1 to z-axis <-65.69> SPEED <154.25>;
		self.Spinners.door1:SetGoal(65)
		self.Spinners.door1:SetSpeed(153)

		--TURN door2 to z-axis <65.24> SPEED <153.20>;
		self.Spinners.door2:SetGoal(-65)
		self.Spinners.door2:SetSpeed(153)

		--MOVE door1 to y-axis <-3.09> SPEED <7.00>;
		self.Sliders.door1:SetGoal(-3,-1.25,0)
		self.Sliders.door1:SetSpeed(7)

		--MOVE door2 to y-axis <-3.05> SPEED <7.00>;
		self.Sliders.door2:SetGoal(3,-1.25,0)
		self.Sliders.door2:SetSpeed(7)

		--MOVE plate to y-axis <3.80> SPEED <8.00>;
		self.Sliders.plate:SetGoal(0,3.8,0)
		self.Sliders.plate:SetSpeed(8)
		--TURN arm to x-axis <85.94> SPEED <200.39>;
		self.Spinners.arm:SetGoal(90)
		self.Spinners.arm:SetSpeed(200)

		--TURN nano to x-axis <-69.74> SPEED <162.62>;
		self.Spinners.nano:SetGoal(-69.74)
		self.Spinners.nano:SetSpeed(162.62)

		TAconstructor.Open(self)
	end,

	OnPrepareArmToBuild = function(self)
		WaitFor(self.Spinners.nano)
		TACommander.OnPrepareArmToBuild(self)
	end,

	Close = function(self)

		self.Spinners.turret:SetGoal(0)
		self.Spinners.turret:SetSpeed(160.03)

		--TURN arm to x-axis <0> SPEED <221.57>;
		self.Spinners.arm:SetGoal(0)
		self.Spinners.arm:SetSpeed(221.57)

		--TURN nano to x-axis <0> SPEED <179.80>;
		self.Spinners.nano:SetGoal(0)
		self.Spinners.nano:SetSpeed(179.80)

		--MOVE plate to y-axis <0> SPEED <9.00>;
		self.Sliders.plate:SetGoal(0,0,0)
		self.Sliders.plate:SetSpeed(9)

		--MOVE door1 to y-axis <0> SPEED <7.00>;
		self.Sliders.door1:SetGoal(0,0,0)
		self.Sliders.door1:SetSpeed(7)

		--MOVE door2 to y-axis <0> SPEED <7.00>;
		self.Sliders.door2:SetGoal(0,0,0)
		self.Sliders.door2:SetSpeed(7)

		--TURN door1 to z-axis <0> SPEED <168.50>;
		self.Spinners.door1:SetGoal(0)
		self.Spinners.door1:SetSpeed(168)

		--TURN door2 to z-axis <0> SPEED <167.34>;
		self.Spinners.door2:SetGoal(0)
		self.Spinners.door2:SetSpeed(168)

		--SLEEP <20>
		TAconstructor.Close(self)
	end,
}

TypeClass = ARMACV