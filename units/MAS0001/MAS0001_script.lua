#****************************************************************************
#**
#**  File     :  /cdimage/units/URB5101/URB5101_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  -- 				local terrain = GetTerrainType(xpos, zpos)
#-- 				if terrain.TypeCode >= 220 then
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local Entity = import('/lua/sim/Entity.lua').Entity


MAS0001 = Class(AWalkingLandUnit) {
    OnCreate = function(self)
    AWalkingLandUnit.OnCreate(self)
    self:SetUnSelectable(true)
    self:SetBusy(true)
    self:SetBlockCommandQueue(true)
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
    end,

   GiveInitialResources = function(self)
       WaitTicks(2)
        self:GetAIBrain():GiveResource('Energy', self:GetBlueprint().Economy.StorageEnergy)
        self:GetAIBrain():GiveResource('Mass', self:GetBlueprint().Economy.StorageMass)
    end,
	
    OnStartBuild = function(self, unitBeingBuilt, order)
        AWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
		local cdrUnit = false
		local army = self:GetArmy()
		cdrUnit = CreateInitialArmyUnit(army, unitBeingBuilt.UnitId)
        self:AddBuildRestriction(categories.COMMAND)
		self:Destroy()
		unitBeingBuilt:Destroy()
    end,

    PlayCommanderWarpInEffect = function(self, bones)
        self:HideBone(0, true)
        self:SetUnSelectable(false)
        self:SetBusy(true)
        self:ForkThread(self.WarpInEffectThread, bones)
    end,

    WarpInEffectThread = function(self)
        self:PlayUnitSound('CommanderArrival')
        self:CreateProjectile( '/effects/entities/UnitTeleport01/UnitTeleport01_proj.bp', 0, 1.35, 0, nil, nil, nil):SetCollision(false)
        WaitSeconds(2.1)
		self:ShowBone(0, true)
        self:SetUnSelectable(false)
        self:SetBusy(false)
        self:SetBlockCommandQueue(false)
        WaitSeconds(6)
        self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
    end,
}


TypeClass = MAS0001

