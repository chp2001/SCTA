#CORE Construction Aircraft - Tech Level 1
#CORCA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORCA = Class(TAAirConstructor) {

	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.Spinners = {
			nozzle = CreateRotator(self, 'nozzle', 'x', nil, 0, 0, 0),
			winga = CreateRotator(self, 'winga', 'z', nil, 0, 0, 0),
			wingb = CreateRotator(self, 'wingb', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
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
		--TURN winga to z-axis <-90.12> SPEED <61.86>;
		self.Spinners.winga:SetGoal(90)
		self.Spinners.winga:SetSpeed(61)

		--TURN wingb to z-axis <90.12> SPEED <61.86>;
		self.Spinners.wingb:SetGoal(-90)
		self.Spinners.wingb:SetSpeed(61)
	end,

	CloseWings = function(self)
		--TURN winga to z-axis <0> SPEED <61.95>;
		self.Spinners.winga:SetGoal(0)
		self.Spinners.winga:SetSpeed(61)

		--TURN wingb to z-axis <0> SPEED <61.95>;
		self.Spinners.wingb:SetGoal(0)
		self.Spinners.wingb:SetSpeed(61)
	end,

}

TypeClass = CORCA