#ARM Wind Generator - Produces Energy
#ARMWIN
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

ARMWIN = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			blades = CreateRotator(self, 'Blades', 'z', nil, 0, 0, 0),
			post = CreateRotator(self, 'Turret', 'y', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.blades)
		self.Trash:Add(self.Spinners.post)
	end,

	OnStopBeingBuilt = function(self, builder, layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.post:SetSpeed(40)
		self.Spinners.blades:SetSpeed(60)
	end,

}

TypeClass = ARMWIN
