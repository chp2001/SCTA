#CORE Targeting Facility - Automatic Radar Targeting
#CORTARG
#
#Script created by Raevn

local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

CORTARG = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,


	OpeningState = State {
		Main = function(self)
			TACloser.Unfold(self)
			self:PlayUnitSound('Activate')
			self:EnableIntel('Radar')
			---self.intelIsActive = true
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		ChangeState(self, self.IdleOpenState)
	end,
},


ClosingState = State {
	Main = function(self)
		self:DisableIntel('Radar')
		TACloser.Fold(self)
		self:PlayUnitSound('Deactivate')
		---self.intelIsActive = nil
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		WaitFor(self.AnimManip)
		ChangeState(self, self.IdleClosedState)
	end,
},
}

TypeClass = CORTARG