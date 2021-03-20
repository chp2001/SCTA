#ARM Eraser - Mobile Radar Jammer
#ARMASER
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter

ARMASER = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			ltong = CreateRotator(self, 'LeftFork', 'y', nil, 0, 0, 0),
			rtong = CreateRotator(self, 'RightFork', 'y', nil, 0, 0, 0),
			tongpivot = CreateRotator(self, 'ForkPivot', 'z', nil, 0, 0, 0),
		}
		self.Sliders = {
			ltong = CreateSlider(self, 'LeftFork', 0, -3, 0, 6),
			rtong = CreateSlider(self, 'RightFork', 0, -3, 0, 6),
			tongend = CreateSlider(self, 'ForkEnd'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	Close = function(self)

		self:PlayUnitSound('Deactivate')

		--TURN ltong to y-axis <0> SPEED <174.54>;
		self.Spinners.ltong:SetGoal(0)
		self.Spinners.ltong:SetSpeed(171)

		--TURN rtong to y-axis <-0.3> SPEED <170.98>;
		self.Spinners.rtong:SetGoal(0)
		self.Spinners.rtong:SetSpeed(171)

		WaitSeconds(0.7)

		--MOVE tongend to y-axis <0> SPEED <4.00>;
		self.Sliders.tongend:SetGoal(0,0,0)
		self.Sliders.tongend:SetSpeed(4)


	end,

	Open = function(self)

		self:PlayUnitSound('Activate')
		self.Sliders.tongend:SetGoal(0,-3,0)
		self.Sliders.tongend:SetSpeed(3)

		--MOVE ltong to y-axis <-2.99> SPEED <3.00>;
		self.Sliders.ltong:SetGoal(0,-3,0)
		self.Sliders.ltong:SetSpeed(3)

		--MOVE rtong to y-axis <-2.99> SPEED <3.00>;
		self.Sliders.rtong:SetGoal(0,-3,0)
		self.Sliders.rtong:SetSpeed(3)

		--SLEEP <751>;
		WaitSeconds(0.75)

		--TURN ltong to y-axis <-119.17> SPEED <157.26>;
		self.Spinners.ltong:SetGoal(-118)
		self.Spinners.ltong:SetSpeed(155)

		--TURN rtong to y-axis <116.71> SPEED <154.01>;
		self.Spinners.rtong:SetGoal(118)
		self.Spinners.rtong:SetSpeed(155)
				--SLEEP <758>;
				WaitSeconds(0.75)
		self.Spinners.tongpivot:SetSpeed(100)
		self.Spinners.tongpivot:ClearGoal()
	end,

	OnIntelDisabled = function(self)
		ForkThread(self.Close, self)
		TACounter.OnIntelDisabled(self)
		self.Sliders.ltong:SetGoal(0,0,0)
		self.Sliders.ltong:SetSpeed(4)
		--MOVE rtong to y-axis <0> SPEED <4.00>;
		self.Sliders.rtong:SetGoal(0,0,0)
		self.Sliders.rtong:SetSpeed(4)
		self.Spinners.tongpivot:SetSpeed(100)
		self.Spinners.tongpivot:SetGoal(0)
	end,

	OnIntelEnabled = function(self)
		ForkThread(self.Open, self)		
		TACounter.OnIntelEnabled(self)
	end,
}
TypeClass = ARMASER