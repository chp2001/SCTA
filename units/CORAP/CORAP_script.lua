#CORE Aircraft Plant - Produces Aircraft
#CORAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

CORAP = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,


	OnCreate = function(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
			pad = CreateRotator(self, 'pad', 'y', nil, 0, 0, 0),
			gunb = CreateRotator(self, 'gunb', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end

		#TODO: Multiple sliders for the same bone to do independant movement along each axis?

		self.Sliders = {
			section1 = CreateSlider(self, 'section1'),
			section2 = CreateSlider(self, 'section2'),
			guna = CreateSlider(self, 'guna'),
			gunb = CreateSlider(self, 'gunb'),
		}
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
		--MOVE section1 to x-axis <5.85> SPEED <12.00>;
		self.Sliders.section1:SetGoal(-5.85,0,0)
		self.Sliders.section1:SetSpeed(12)

		--MOVE section2 to x-axis <4.50> SPEED <6.00>;
		--MOVE section2 to z-axis <2.10> SPEED <3.00>;
		self.Sliders.section2:SetGoal(-4.5,0,2.1)
		self.Sliders.section2:SetSpeed(6)

		--MOVE guna to x-axis <7.05> SPEED <10.00>;
		self.Sliders.guna:SetGoal(-7.05,0,0)
		self.Sliders.guna:SetSpeed(10)

		--MOVE gunb to x-axis <4.85> SPEED <7.00>;
		--MOVE gunb to z-axis <2.00> SPEED <3.00>;
		self.Sliders.gunb:SetGoal(-5,0,2.0)
		self.Sliders.gunb:SetSpeed(7)

		--MOVE guna to z-axis <2.50> SPEED <5.00>;
		self.Sliders.guna:SetGoal(-7.05,0,2.5)
		self.Sliders.guna:SetSpeed(5)

		--MOVE gunb to x-axis <3.65> SPEED <2.00>;
		--MOVE gunb to z-axis <4.14> SPEED <4.00>;
		self.Sliders.gunb:SetGoal(-3.65,0,4.14)
		self.Sliders.gunb:SetSpeed(4)


		--SPIN pad around y-axis  SPEED <30.00>
		self.Spinners.pad:SetSpeed(0)

		TAFactory.Open(self)
	end,

	Close = function(self)
		--STOP-SPIN pad around y-axis 
		self.Spinners.pad:SetSpeed(0)

		--MOVE guna to z-axis <0> SPEED <5.00>;
		self.Sliders.guna:SetGoal(0,0,0)
		self.Sliders.guna:SetSpeed(5)

		--MOVE gunb to x-axis <4.85> SPEED <2.00>;
		--MOVE gunb to z-axis <2.00> SPEED <5.00>;
		self.Sliders.gunb:SetGoal(4.85,0,2.0)
		self.Sliders.gunb:SetSpeed(5)


		--MOVE guna to x-axis <0> SPEED <12.00>;
		self.Sliders.guna:SetGoal(0,0,0)
		self.Sliders.guna:SetSpeed(12)

		--MOVE gunb to x-axis <0> SPEED <8.00>;
		--MOVE gunb to z-axis <0> SPEED <3.00>;
		self.Sliders.gunb:SetGoal(0,0,0)
		self.Sliders.gunb:SetSpeed(8)

		--MOVE section2 to x-axis <0> SPEED <8.00>;
		--MOVE section2 to z-axis <0> SPEED <3.00>;
		self.Sliders.section2:SetGoal(0,0,0)
		self.Sliders.section2:SetSpeed(8)


		--MOVE section1 to x-axis <0> SPEED <12.00>;
		self.Sliders.section1:SetGoal(0,0,0)
		self.Sliders.section1:SetSpeed(12)

		ChangeState(self, self.IdleState)
		TAFactory.Close(self)
	end,
}

TypeClass = CORAP