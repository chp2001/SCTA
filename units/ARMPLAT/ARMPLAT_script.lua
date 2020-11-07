#ARM Adv. Aircraft Plant - Produces Aircraft
#ARMAAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMPLAT = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,

	---Water = false,

	OnCreate = function(self)
		self.Sliders = {
			chassis = CreateSlider(self, 0),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAFactory.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		local bp = self:GetBlueprint()
        local scale = 0.5
		self:DisableIntel('RadarStealth')
		if layer == 'Water' then
			self.Water = true
			self.Sliders.chassis:SetSpeed(10)
			self.Sliders.chassis:SetGoal(0,-20,0)
			self:SetCollisionShape( 'Box', bp.CollisionOffsetX or -5,(bp.CollisionOffsetY + (bp.SizeY*-0.5)) or 0,bp.CollisionOffsetZ or -5, bp.SizeX * scale, bp.SizeY * scale, bp.SizeZ * scale )
			self:EnableIntel('RadarStealth')
		end
	end,

	Open = function(self)
		ForkThread(self.WaterRise, self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		TAFactory.Open(self)
	end,

	WaterRise = function(self)
		local bp = self:GetBlueprint()
        local scale = 0.5
		if self.Water then
			self.Sliders.chassis:SetSpeed(10)
			self.Sliders.chassis:SetGoal(0,-10,0)
			self:SetCollisionShape( 'Box', bp.CollisionOffsetX or 0,(bp.CollisionOffsetY + (bp.SizeY*0.5)) or 0,bp.CollisionOffsetZ or 0, bp.SizeX * scale, bp.SizeY * scale, bp.SizeZ * scale )
			self:DisableIntel('RadarStealth')
		end
	end,

	Aim = function(self, target)
		TAFactory.Aim(self, target)
		WaitFor(self.AnimManip)
	end,

	Close = function(self)
		ForkThread(self.WaterFall, self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		ChangeState(self, self.IdleState)
		TAFactory.Close(self)
	end,

	WaterFall = function(self)
		local bp = self:GetBlueprint()
        local scale = 0.5
		if self.Water then
			self.Sliders.chassis:SetSpeed(10)
			self.Sliders.chassis:SetGoal(0,-20,0)
			self:SetCollisionShape( 'Box', bp.CollisionOffsetX or -5,(bp.CollisionOffsetY + (bp.SizeY*-0.5)) or 0,bp.CollisionOffsetZ or -5, bp.SizeX * scale, bp.SizeY * scale, bp.SizeZ * scale )
			self:EnableIntel('RadarStealth')
		end
	end,
}

TypeClass = ARMPLAT