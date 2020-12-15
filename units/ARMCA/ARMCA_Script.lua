#ARM Construction Aircraft - Tech Level 1
#ARMCA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMCA = Class(TAAirConstructor) {
	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.Spinners = {
			nozzle = CreateRotator(self, 'Nozzle', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.Sliders = {
			wing1 = CreateSlider(self, 'Wing_01'),
			wing2 = CreateSlider(self, 'Wing_02'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OnMotionVertEventChange = function(self, new, old )
		if (new == 'Down' or new == 'Bottom') then
                	self:PlayUnitSound('Landing')
			self:CloseWings(self)
		elseif (new == 'Up' or new == 'Top') then
                	self:PlayUnitSound('TakeOff')
			self:OpenWings(self)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAAirConstructor.OnStopBeingBuilt(self,builder,layer)
		self:OpenWings(self)
	end,

	OpenWings = function(self)
		--MOVE wing1 to x-axis <-4.50> SPEED <4.00>;
		self.Sliders.wing1:SetGoal(4.5,0,0)
		self.Sliders.wing1:SetSpeed(4)

		--MOVE wing2 to x-axis <5.84> SPEED <6.00>;
		self.Sliders.wing2:SetGoal(-5.84,0,0)
		self.Sliders.wing2:SetSpeed(6)
	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <4.00>;
		self.Sliders.wing1:SetGoal(0,0,0)
		self.Sliders.wing1:SetSpeed(4)

		--MOVE wing2 to x-axis <0> SPEED <6.00>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(6)
	end,
}

TypeClass = ARMCA