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
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAFactory.OnCreate(self)
	end,

	Open = function(self)
		TAFactory.Open(self)
		self.Sliders.building1:SetGoal(0,0,0)
		self.Sliders.building1:SetSpeed(10)
		self.Sliders.building3:SetGoal(0,0,0)
		self.Sliders.building3:SetSpeed(10)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,


	Close = function(self)
		TAFactory.Close(self)
		self.Sliders.building1:SetGoal(20,0,0)
		self.Sliders.building1:SetSpeed(5)
		self.Sliders.building3:SetGoal(20,0,0)
		self.Sliders.building3:SetSpeed(5)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,
}

TypeClass = ARMDVP