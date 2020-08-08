#CORE Wind Generator - Produces Energy
#CORWIN
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

CORWIN = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			fan = CreateRotator(self, 'fan', 'z', nil, 0, 0, 0),
			cradle = CreateRotator(self, 'cradle', 'y', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.blades)
		self.Trash:Add(self.Spinners.post)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.cradle:SetSpeed(35)
		self.Spinners.fan:SetSpeed(50)
	end,
}

TypeClass = CORWIN