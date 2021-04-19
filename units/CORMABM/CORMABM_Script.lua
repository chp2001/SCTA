#ARM Jeffy - Fast Attack Vehicle
#CORMABM
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local DefaultWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

CORMABM = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
	end,

	OnMotionHorzEventChange = function( self, new, old )
		if new == 'Stopped' then
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnfold)
			self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnfoldRate or 0.2))
		end
		if old == 'Stopped' then
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnfold)
			self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationUnfoldRate or 0.2))
        end
		TAunit.OnMotionHorzEventChange(self, new, old)
	end,

	Weapons = {
			Turret01 = Class(DefaultWeapon) {
		},
	},
}

TypeClass = CORMABM