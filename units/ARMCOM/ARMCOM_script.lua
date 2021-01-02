#ARM Commander - Commander
#ARMCOM
#
#Script created by Raevn

local TARealCommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TARealCommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TACommanderDeathWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderDeathWeapon

#ARM Commander - Commander

ARMCOM = Class(TARealCommander) {

	Weapons = {
		COMLASER = Class(TAweapon) {
		},
		DGun = Class(TADGun) {
		},		
		AutoDGun = Class(TADGun) {
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
		self:ShowBone(0, true)
		self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
		WaitSeconds(3)
		---CreateAttachedEmitter( self, 0, army, '/mods/SCTA-master/effects/emitters/ENTRANCE_emit.bp'):ScaleEmitter(4)
		self:HideBone('DGunMuzzle', true)
		self:HideBone('LaserMuzzle', true)
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
        self:SetUnSelectable(false)
		self:SetBusy(false)
		self:SetBlockCommandQueue(false)
    end,

	OnStopBeingBuilt = function(self,builder,layer)
		TARealCommander.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.GiveInitialResources, self)
			self:SetScriptBit('RULEUTC_CloakToggle', true)
			self:ForkThread(self.PlayCommanderWarpInEffect)
			self.motion = 'Stopped'
	end,




	OnScriptBitSet = function(self, bit)
		if bit == 8 then
			self:DisableUnitIntel('ToggleBit8', 'Cloak')
			self.cloakOn = nil
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(TARealCommander.CloakDetection)	
		end
		TARealCommander.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.cloakOn = nil
			end
		end
		TARealCommander.OnScriptBitClear(self, bit)
	end,


	GiveInitialResources = function(self)
		#need to convert options to ints - they are strings
		self:GetAIBrain():GiveResource('ENERGY', self:GetBlueprint().Economy.StorageEnergy)
		self:GetAIBrain():GiveResource('MASS', self:GetBlueprint().Economy.StorageMass)
	end,


}

TypeClass = ARMCOM