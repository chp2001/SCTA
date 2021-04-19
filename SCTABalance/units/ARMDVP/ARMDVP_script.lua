#ARM Vehicle Plant - Produces Vehicles
#ARMDVP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMDVP = Class(TAFactory) {
	OnCreate = function(self)
		self.Sliders = {
			building1 = CreateSlider(self, 'building1', 20, 0, 0, 40),
			building3 = CreateSlider(self, 'building3', 20, 0, 0, 40),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,

	Open = function(self)
		TAFactory.Open(self)
		self.Sliders.building1:SetGoal(0,0,0)
		self.Sliders.building1:SetSpeed(10)
		self.Sliders.building3:SetGoal(0,0,0)
		self.Sliders.building3:SetSpeed(10)
	end,


	Close = function(self)
		TAFactory.Close(self)
		self.Sliders.building1:SetGoal(20,0,0)
		self.Sliders.building1:SetSpeed(5)
		self.Sliders.building3:SetGoal(20,0,0)
		self.Sliders.building3:SetSpeed(5)
	end,
}

TypeClass = ARMDVP