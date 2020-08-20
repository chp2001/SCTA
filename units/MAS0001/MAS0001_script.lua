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
local EffectUtil = import('/lua/EffectUtilities.lua')

MAS0001 = Class(AWalkingLandUnit) {
    OnCreate = function(self)
	AWalkingLandUnit.OnCreate(self)
	self.AnimManip = CreateAnimator(self)
	self.Trash:Add(self.AnimManip)
	#WaitSeconds(1)
	end,

    OnStopBeingBuilt = function(self,builder,layer)
        AWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
    end,

   GiveInitialResources = function(self)
       #WaitTicks(2)
        self:GetAIBrain():GiveResource('Energy', self:GetBlueprint().Economy.StorageEnergy)
        self:GetAIBrain():GiveResource('Mass', self:GetBlueprint().Economy.StorageMass)
    end,
	
	OnStartBuild = function(self, unitBeingBuilt, order)
		local gtime = GetGameTimeSeconds()
		if gtime < 5 then
			ForkThread(self.Spawn, self, unitBeingBuilt, order)
		else
			AWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
			local cdrUnit = false
			local army = self:GetArmy()
			cdrUnit = CreateInitialArmyUnit(army, unitBeingBuilt.UnitId)
			self:AddBuildRestriction(categories.COMMAND)
			self:Destroy()
			unitBeingBuilt:Destroy()
		end

		--ForkThread(self:Spawn,self, unitBeingBuilt, order)

    end,

	Spawn = function(self, unitBeingBuilt, order)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen):SetRate(0.8)
		local gtime = GetGameTimeSeconds()
		while gtime < 5 do
			WaitSeconds(0.2)
			gtime = GetGameTimeSeconds()
		end
		---AWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
		local cdrUnit = false
		local army = self:GetArmy()
		cdrUnit = CreateInitialArmyUnit(army, unitBeingBuilt.UnitId)
		self:AddBuildRestriction(categories.COMMAND)
		WaitSeconds(2)
		self:Destroy()
		unitBeingBuilt:Destroy()
	end
}


TypeClass = MAS0001

