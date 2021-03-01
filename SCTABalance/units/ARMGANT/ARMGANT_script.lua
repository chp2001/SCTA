#ARM Drake Gantry - Builds Drake
#ARMGANT
#
#Script created by Raevn

local TAGantry = import('/mods/SCTA-master/lua/TAFactory.lua').TAGantry

ARMGANT = Class(TAGantry) {
	OnCreate = function(self)
		self.Spinners = {
			nozzle1 = CreateRotator(self, 'nano1', 'y', nil, 0, 0, 0),
			nozzle2 = CreateRotator(self, 'nano2', 'y', nil, 0, 0, 0),
			nozzle3 = CreateRotator(self, 'flashy', 'x', nil, 0, 0, 0),
			--nozzle1 = CreateSlider(self, 'nano1'),
			--nozzle2 = CreateSlider(self, 'nano2'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAGantry.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAGantry.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.nozzle1:SetGoal(-10)
		self.Spinners.nozzle1:SetSpeed(10)
		self.Spinners.nozzle2:SetGoal(10)
		self.Spinners.nozzle2:SetSpeed(10)
		self.Spinners.nozzle3:SetGoal(15)
		self.Spinners.nozzle3:SetSpeed(15)
	end,


	Open = function(self)
		TAGantry.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,


	Close = function(self)
		TAGantry.Close(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,
}

TypeClass = ARMGANT