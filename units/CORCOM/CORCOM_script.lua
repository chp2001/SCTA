#CORE Commander - Commander
#CORCOM
#
#Script created by Raevn

local TARealCommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TARealCommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TACommanderDeathWeapon = import('/mods/SCTA-master/lua/TAweapon.lua').TACommanderDeathWeapon
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

CORCOM = Class(TARealCommander) {
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
			self:HideBone('Mlasflsh', true)
			self:HideBone('BigFlsh', true)
			self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
			self:SetUnSelectable(false)
			self:SetBusy(false)
			self:SetBlockCommandQueue(false)
		end,

	OnStopBeingBuilt = function(self,builder,layer)
		TARealCommander.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.GiveInitialResources, self)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
		self:ForkThread(self.PlayCommanderWarpInEffect)
	end,

	GiveInitialResources = function(self)
		self:GetAIBrain():GiveResource('ENERGY', self:GetBlueprint().Economy.StorageEnergy)
		self:GetAIBrain():GiveResource('MASS', self:GetBlueprint().Economy.StorageMass)
	end,
}

TypeClass = CORCOM