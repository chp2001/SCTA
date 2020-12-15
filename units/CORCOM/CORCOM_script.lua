#CORE Commander - Commander
#CORCOM
#
#Script created by Raevn

local TACommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TACommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TACommanderDeathWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderDeathWeapon
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

CORCOM = Class(TACommander) {
	Weapons = {
		COMLASER = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
			end,
		},
		DGun = Class(TADGun) {
		},
		DeathWeapon = Class(TACommanderDeathWeapon) {},
	},

	PlayCommanderWarpInEffect = function(self)
        self:HideBone(0, true)
        self:SetUnSelectable(false)
        self:SetBusy(true)
		self:SetBlockCommandQueue(true)
		self.PlayCommanderWarpInEffectFlag = true
        self:ForkThread(self.ExplosionInEffectThread)
    end,

    ExplosionInEffectThread = function(self)
		self:PlayUnitSound('CommanderArrival')
		self.PlayCommanderWarpInEffectFlag = false
		self:CreateProjectile( '/mods/SCTA-master/effects/entities/TAEntrance/TAEntrance_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
		WaitSeconds(2.7)
			self:ShowBone(0, true)
			self:HideBone('Mlasflsh', true)
			self:HideBone('BigFlsh', true)
			self:SetUnSelectable(false)
			self:SetBusy(false)
			self:SetBlockCommandQueue(false)
	
			WaitSeconds(6)
			self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
		end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACommander.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.GiveInitialResources, self)
			self:SetScriptBit('RULEUTC_CloakToggle', true)
			self:ForkThread(self.PlayCommanderWarpInEffect)
			self.motion = 'Stopped'
	end,


	OnScriptBitSet = function(self, bit)
		if bit == 8 then
			self:OnIntelDisabled()
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(TACommander.CloakDetection)	
		end
		TACommander.OnScriptBitSet(self, bit)
	end,



	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.cloakOn = nil
			end
		end
		TACommander.OnScriptBitClear(self, bit)
	end,

	GiveInitialResources = function(self)
		self:GetAIBrain():GiveResource('ENERGY', self:GetBlueprint().Economy.StorageEnergy)
		self:GetAIBrain():GiveResource('MASS', self:GetBlueprint().Economy.StorageMass)
	end,
}

TypeClass = CORCOM