#ARM Commander - Commander
#ARMCOM
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TACommanderDeathWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderDeathWeapon
local TACommanderSuicideWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderSuicideWeapon

#ARM Commander - Commander

ARMCOM = Class(TAconstructor) {
	motion = 'Stopped',
	cloakOn = false,

	Weapons = {
		ARMCOMLASER = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
			end,
		},
		ARM_DISINTEGRATOR = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				self:ForkThread(self.PauseOvercharge)
				self.unit:SetWeaponEnabledByLabel('ARM_DISINTEGRATOR', true)
			end,

		        OnLostTarget = function(self)
				self.unit:SetWeaponEnabledByLabel('ARM_DISINTEGRATOR', true)
				TAweapon.OnLostTarget(self)
				end,
				
				PauseOvercharge = function(self)
					if not self.unit:IsOverchargePaused() then
						self.unit:SetOverchargePaused(true)
						WaitSeconds(1/self:GetBlueprint().RateOfFire)
						self.unit:SetOverchargePaused(false)
					end
				end,
		},
		DeathWeapon = Class(TACommanderDeathWeapon) {},
		SuicideWeapon = Class(TACommanderSuicideWeapon) {},
	},

	OnCreate = function(self)
		self.Spinners = {
			torso = CreateRotator(self, 'Torso', 'y', nil, 0, 0, 0),
			luparm = CreateRotator(self, 'LeftLowerArm', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
		self:SetCapturable(false)
	end,

	OnStartCapture = function(self, target)
		self:SetCaptureTimeMultiplier(1)
		self:SetBuildRate(self:GetBlueprint().Economy.BuildRate * 0.6)
		TAconstructor.OnStartCapture(self, target)
		self.desiredTarget = target
		if (self.currentState == "aimed") then
			self.currentState = "opened"
			self.desiredState = "aimed"
		else
			self.desiredState = "opened"
		end
		self.isReclaiming = false
		self.isBuilding = false
		if self.cloakOn == false then
		self.isCapturing = true
		if (not self.animating) then
			ForkThread(self.AnimationThread, self)
		end
		end
	end,

    CloakDetection = function(self)
        local GetUnitsAroundPoint = moho.aibrain_methods.GetUnitsAroundPoint
        local brain = moho.entity_methods.GetAIBrain(self)
        local cat = categories.SELECTABLE * categories.MOBILE
        local getpos = moho.entity_methods.GetPosition
        while not self.Dead do
            coroutine.yield(11)
            local dudes = GetUnitsAroundPoint(brain, cat, getpos(self), 4, 'Enemy')
            if dudes[1] and self.cloakOn then
                self:DisableIntel('Cloak')
            elseif not dudes[1] and self.cloakOn then
                self:EnableIntel('Cloak')
            end
        end
    end,

	PlayCommanderWarpInEffect = function(self)
        self:HideBone(0, true)
        self:SetUnSelectable(true)
        self:SetBusy(true)
        self:SetBlockCommandQueue(true)
        self:ForkThread(self.WarpInEffectThread)
    end,

    WarpInEffectThread = function(self)
        self:PlayUnitSound('CommanderArrival')
        self:CreateProjectile( '/effects/entities/UnitTeleport01/UnitTeleport01_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
        WaitSeconds(2.1)
		self:ShowBone(0, true)
		self:HideBone('DGunMuzzle', true)
        self:HideBone('LaserMuzzle', true)
        self:SetUnSelectable(false)
        self:SetBusy(false)
        self:SetBlockCommandQueue(false)
        WaitSeconds(6)
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
    end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAconstructor.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.GiveInitialResources, self)
			self:SetScriptBit('RULEUTC_CloakToggle', true)
	end,

	OnMotionHorzEventChange = function(self, new, old )
		TAconstructor.OnMotionHorzEventChange(self, new, old)
		if old == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(1000)
			self.motion = 'Moving'
		elseif new == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(200)
			self.motion = 'Stopped'
		end
	end,

	OnIntelDisabled = function(self)
		self.cloakOn = false
		self:DisableIntel('Cloak')
        self:SetIntelRadius('Omni', 10)
        self:PlayUnitSound('Uncloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
	end,

	OnIntelEnabled = function(self)
		--self:EnableIntel('Cloak')
		if self.motion == 'Moving' then
			self:SetConsumptionPerSecondEnergy(1000)
		end
        self:SetIntelRadius('Omni', self:GetBlueprint().Intel.OmniRadius)
		self.cloakOn = true
        	self:PlayUnitSound('Cloak')
		self:SetMesh('/mods/SCTA-master/units/ARMCOM/ARMCOM_cloak_mesh', true)
		ForkThread(self.CloakDetection, self)
	end,



	OnScriptBitSet = function(self, bit)
		if bit == 8 then
			self:OnIntelDisabled()
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(self.CloakDetection)	
		end
		TAconstructor.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.cloakOn = false
			end
		end
		TAconstructor.OnScriptBitClear(self, bit)
	end,


	GiveInitialResources = function(self)
		#need to convert options to ints - they are strings
		self:GetAIBrain():GiveResource('ENERGY', self:GetBlueprint().Economy.StorageEnergy)
		self:GetAIBrain():GiveResource('MASS', self:GetBlueprint().Economy.StorageMass)
	end,

	OnKilled = function(self, instigator, type, overkillRatio)
		TAconstructor.OnKilled(self, instigator, type, overkillRatio)
	end,

	Aim = function(self,target)
		local selfPosition = self:GetPosition('Torso') 
		local targetPosition = target:GetPosition()
			

		--TURN torso to y-axis heading SPEED <300.07>;
		self.Spinners.torso:SetGoal(TAutils.GetAngle(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z) - (self:GetHeading() * 180) / math.pi)
		self.Spinners.torso:SetSpeed(300)

		local distance = VDist2(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z)
		selfPosition = self:GetPosition('LaserMuzzle') 

		--TURN luparm to x-axis (0 - pitch - 29.99) SPEED <45.01>;
		self.Spinners.luparm:SetGoal(-180 + TAutils.GetAngle(0, selfPosition.y, distance, targetPosition.y))
		self.Spinners.luparm:SetSpeed(45.01)

		WaitFor(self.Spinners.torso)
		WaitFor(self.Spinners.luparm)
		TAconstructor.Aim(self, target)
	end,



	Close = function(self)
		self.Spinners.torso:SetGoal(0)
		self.Spinners.torso:SetSpeed(90)
			
		self.Spinners.luparm:SetGoal(0)
		self.Spinners.luparm:SetSpeed(45)

		WaitFor(self.Spinners.torso)
		WaitFor(self.Spinners.luparm)

		TAconstructor.Close(self)
	end,
}

TypeClass = ARMCOM