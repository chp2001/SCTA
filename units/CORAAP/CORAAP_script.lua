#CORE Adv. Aircraft Plant - Produces Aircraft
#CORAAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORAAP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
			pad = CreateRotator(self, 'pad', 'y', nil, 0, 0, 0),
			block1 = CreateRotator(self, 'block1', 'z', nil, 0, 0, 0),
			block2 = CreateRotator(self, 'block2', 'z', nil, 0, 0, 0),
			gun1 = CreateRotator(self, 'gun1', 'x', nil, 0, 0, 0),
			gun2 = CreateRotator(self, 'gun2', 'x', nil, 0, 0, 0),
			nozzle1 = CreateRotator(self, 'beam1', 'y', nil, 0, 0, 0),
			nozzle2 = CreateRotator(self, 'beam2', 'y', nil, 0, 0, 0),
		}
		self.Sliders = {
			head1 = CreateSlider(self, 'head1'),
			head2 = CreateSlider(self, 'head2'),
			pedistal = CreateSlider(self, 'pedistal'),
			sleeve1 = CreateSlider(self, 'sleeve1'),
			sleeve2 = CreateSlider(self, 'sleeve2'),
			conduit1 = CreateSlider(self, 'conduit1'),
			conduit2 = CreateSlider(self, 'conduit2'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.dish:SetSpeed(150)
	end,

	Open = function(self)
		self.Spinners.block1:SetGoal(90)
		self.Spinners.block1:SetSpeed(114)

		self.Spinners.block2:SetGoal(-90)
		self.Spinners.block2:SetSpeed(114)

		self.Spinners.block1:SetGoal(180)
		self.Spinners.block1:SetSpeed(360)

		self.Spinners.block2:SetGoal(-180)
		self.Spinners.block2:SetSpeed(360)

		self.Sliders.pedistal:SetGoal(0,5,0)
		self.Sliders.pedistal:SetSpeed(20)

		self.Sliders.sleeve1:SetGoal(-3.69,0,0)
		self.Sliders.sleeve1:SetSpeed(12)

		self.Sliders.sleeve2:SetGoal(3.69,0,0)
		self.Sliders.sleeve2:SetSpeed(12)

		--MOVE head2 to y-axis <-2.85> SPEED <9.00>;
		self.Sliders.head2:SetGoal(0,-2.85,0)
		self.Sliders.head2:SetSpeed(9)

		--MOVE head1 to y-axis <-2.85> SPEED <9.00>;
		self.Sliders.head1:SetGoal(0,-2.85,0)
		self.Sliders.head1:SetSpeed(9)


		--MOVE bump2 to x-axis <2.40> SPEED <6.00>;
		--MOVE bump2 to y-axis <0.40> SPEED <1.00>;


		--MOVE conduit2 to x-axis <-3.74> SPEED <10.00>;
		self.Sliders.conduit2:SetGoal(3.7,0,0)
		self.Sliders.conduit2:SetSpeed(10)

		--MOVE bump1 to x-axis <-2.40> SPEED <6.00>;
		--MOVE bump1 to y-axis <0.40> SPEED <1.00>;


		--MOVE conduit1 to x-axis <3.69> SPEED <10.00>;
		self.Sliders.conduit1:SetGoal(-3.7,0,0)
		self.Sliders.conduit1:SetSpeed(10)

		--TURN gun2 to x-axis <179.76> SPEED <241.68>;
		self.Spinners.gun2:SetGoal(180)
		self.Spinners.gun2:SetSpeed(242)

		--TURN gun1 to x-axis <179.76> SPEED <241.68>;
		self.Spinners.gun1:SetGoal(180)
		self.Spinners.gun1:SetSpeed(242)

			
		self.Spinners.nozzle1:SetGoal(-45)
		self.Spinners.nozzle1:SetSpeed(160.03)

		self.Spinners.nozzle2:SetGoal(45)
		self.Spinners.nozzle2:SetSpeed(160.03)

		TAFactory.Open(self)
	end,

	Close = function(self)
	
		self.Spinners.nozzle1:SetGoal(0)
		self.Spinners.nozzle1:SetSpeed(160.03)

		self.Spinners.nozzle2:SetGoal(0)
		self.Spinners.nozzle2:SetSpeed(160.03)
		--TURN gun2 to x-axis <0> SPEED <337.99>;

		self.Spinners.gun2:SetGoal(0)
		self.Spinners.gun2:SetSpeed(338)

		--TURN gun1 to x-axis <0> SPEED <337.99>;
		self.Spinners.gun1:SetGoal(0)
		self.Spinners.gun1:SetSpeed(338)

		--MOVE bump2 to x-axis <0> SPEED <6.00>;
		--MOVE bump2 to y-axis <0> SPEED <1.00>;


		--MOVE conduit2 to x-axis <0> SPEED <9.00>;
		self.Sliders.conduit2:SetGoal(0,0,0)
		self.Sliders.conduit2:SetSpeed(9)

		--MOVE bump1 to x-axis <0> SPEED <6.00>;
		--MOVE bump1 to y-axis <0> SPEED <1.00>;


		--MOVE conduit1 to x-axis <0> SPEED <9.00>;
		self.Sliders.conduit1:SetGoal(0,0,0)
		self.Sliders.conduit1:SetSpeed(9)

		--MOVE sleeve1 to x-axis <0> SPEED <9.00>;
		self.Sliders.sleeve1:SetGoal(0,0,0)
		self.Sliders.sleeve1:SetSpeed(9)

		--MOVE sleeve2 to x-axis <0> SPEED <9.00>;
		self.Sliders.sleeve2:SetGoal(0,0,0)
		self.Sliders.sleeve2:SetSpeed(9)

		--MOVE head2 to y-axis <0> SPEED <7.00>;
		self.Sliders.head2:SetGoal(0,0,0)
		self.Sliders.head2:SetSpeed(7)

		--MOVE head1 to y-axis <0> SPEED <7.00>;
		self.Sliders.head1:SetGoal(0,0,0)
		self.Sliders.head1:SetSpeed(7)

		--MOVE pedistal to y-axis <0> SPEED <8.00>;
		self.Sliders.pedistal:SetGoal(0,0,0)
		self.Sliders.pedistal:SetSpeed(8)

		--TURN block1 to z-axis <-90.22> SPEED <223.93>;
		self.Spinners.block1:SetGoal(90)
		self.Spinners.block1:SetSpeed(224)

		--TURN block2 to z-axis <90.22> SPEED <223.93>;
		self.Spinners.block2:SetGoal(-90)
		self.Spinners.block2:SetSpeed(224)

		--MOVE head2 to x-axis <0> SPEED <1.00>;
		self.Sliders.head2:SetGoal(0,0,0)
		self.Sliders.head2:SetSpeed(1)

		--MOVE head1 to x-axis <0> SPEED <1.00>;
		self.Sliders.head1:SetGoal(0,0,0)
		self.Sliders.head1:SetSpeed(1)

		--TURN block1 to z-axis <0> SPEED <224.50>;
		self.Spinners.block1:SetGoal(0)
		self.Spinners.block1:SetSpeed(224)

		--TURN block2 to z-axis <0> SPEED <224.50>;
		self.Spinners.block2:SetGoal(0)
		self.Spinners.block2:SetSpeed(224)
		TAFactory.Close(self)
	end,
}

TypeClass = CORAAP