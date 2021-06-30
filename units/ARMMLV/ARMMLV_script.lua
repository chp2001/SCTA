#ARM Podger - Mine Layer Vehicle
#ARMMLV
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor


ARMMLV = Class(TAconstructor) {

	OnCreate = function(self)
		self.Spinners = {
			Tires1 = CreateRotator(self, 'Tire1', 'x', nil, 0, 0, 0),
			Tires2 = CreateRotator(self, 'Tire2', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	OnMotionHorzEventChange = function(self, new, old )
		TAconstructor.OnMotionHorzEventChange(self, new, old)
		if (new == 'Cruise') then
			self.Spinners.Tires1:SetSpeed(150)
			self.Spinners.Tires2:SetSpeed(150)
		elseif (new == 'Stopped') then
			self.Spinners.Tires1:SetSpeed(0)
			self.Spinners.Tires2:SetSpeed(0)
		end
	end,
}
TypeClass = ARMMLV