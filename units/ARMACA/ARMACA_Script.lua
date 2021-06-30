#ARM Construction Aircraft - Tech Level 1
#ARMCA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor

ARMACA = Class(TAAirConstructor) {
	SetupBuildBones = function(self)
        local bp = self:GetBlueprint()
        TAAirConstructor.SetupBuildBones(self)
        local buildbones = bp.General.BuildBones
        if self.BuildArmManipulator then
            self.BuildArmManipulator:SetAimingArc(buildbones.YawMin or -180, buildbones.YawMax or 180, buildbones.YawSlew or 360, buildbones.PitchMin or -90, buildbones.PitchMax or 90, buildbones.PitchSlew or 360)
        end
        if bp.General.BuildBonesAlt1 then
            self.BuildArm2Manipulator = CreateBuilderArmController(self, bp.General.BuildBonesAlt1.YawBone or 0 , bp.General.BuildBonesAlt1.PitchBone or 0, bp.General.BuildBonesAlt1.AimBone or 0)
            self.BuildArm2Manipulator:SetAimingArc(bp.General.BuildBonesAlt1.YawMin or -180, bp.General.BuildBonesAlt1.YawMax or 180, bp.General.BuildBonesAlt1.YawSlew or 360, bp.General.BuildBonesAlt1.PitchMin or -90, bp.General.BuildBonesAlt1.PitchMax or 90, bp.General.BuildBonesAlt1.PitchSlew or 360)
            self.BuildArm2Manipulator:SetPrecedence(5)
            if self.BuildingOpenAnimManip and self.Build2ArmManipulator then
                self.BuildArm2Manipulator:Disable()
            end
            self.Trash:Add(self.BuildArm2Manipulator)
        end
    end,
	
	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,


	OpenWings = function(self)
		--MOVE wing1 to x-axis <5.59> SPEED <5.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <4.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,
}

TypeClass = ARMACA