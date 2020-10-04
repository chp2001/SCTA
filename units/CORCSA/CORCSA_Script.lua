#ARM Adv. Construction Aircraft - Tech Level 2
#ARMACA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORCSA = Class(TAAirConstructor) {

	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.Spinners = {
			nozzle1 = CreateRotator(self, 'nano1', 'x', nil, 0, 0, 0),
			nozzle2 = CreateRotator(self, 'nano2', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.Sliders = {
			wing1 = CreateSlider(self, 'rightwing'),
			wing2 = CreateSlider(self, 'leftwing'),
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
		--MOVE wing1 to x-axis <5.59> SPEED <5.00>;
		self.Sliders.wing1:SetGoal(0,0,5)
		self.Sliders.wing1:SetSpeed(5)

		self.Sliders.wing2:SetGoal(0,0,5)
		self.Sliders.wing2:SetSpeed(5)
	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <5.00>;
		self.Sliders.wing1:SetGoal(0,0,0)
		self.Sliders.wing1:SetSpeed(5)

		--MOVE wing2 to x-axis <0> SPEED <5.00>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(5)
	end,

	Aim = function(self, target)
		local selfPosition = self:GetPosition('nano1') 
		local targetPosition = target:GetPosition()
		local distance = VDist2(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z)

		self.Spinners.nozzle1:SetGoal(TAutils.GetAngle(0, targetPosition.y, distance, selfPosition.y))
		self.Spinners.nozzle1:SetSpeed(160.03)

		WaitFor(self.Spinners.nozzle1)

		self.Spinners.nozzle2:SetGoal(TAutils.GetAngle(0, targetPosition.y, distance, selfPosition.y))
		self.Spinners.nozzle2:SetSpeed(160.03)

		WaitFor(self.Spinners.nozzle2)
		TAAirConstructor.Aim(self, target)
	end,
}

TypeClass = CORCSA