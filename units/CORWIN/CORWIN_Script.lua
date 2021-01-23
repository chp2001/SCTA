#CORE Wind Generator - Produces Energy
#CORWIN
#
#Script created by Raevn

local TAWin = import('/mods/SCTA-master/lua/TAWeather.lua').TAWin

CORWIN = Class(TAWin) {
	OnCreate = function(self,builder,layer)
		TAWin.OnCreate(self,builder,layer)
		self:SetProductionPerSecondEnergy(0)
		self.Spinners = {
		   --CreateRotator(Win, bone, axis, [goal], [speed], [accel], [goalspeed])
		   fan = CreateRotator(self, 'Rotors', 'z', nil, 0, 0, 0),
		   cradle = CreateRotator(self, 'Tower', 'z', nil, 0, 0, 0),
	   }
	   for k, v in self.Spinners do
		self.Trash:Add(v)
	end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAWin.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.cradle:SetSpeed(35)
		self.Spinners.fan:SetSpeed(50)
	end,
}

TypeClass = CORWIN