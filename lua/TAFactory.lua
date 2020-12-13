local FactoryUnit = import('/lua/defaultunits.lua').FactoryUnit
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

TAFactory = Class(FactoryUnit) {	
		OnStartBuild = function(self, unitBeingBuilt, order )
			self:Open()
			FactoryUnit.OnStartBuild(self, unitBeingBuilt, order )
		end,
	
		OnStopBuild = function(self, unitBeingBuilt, order )
			self:Close()
			FactoryUnit.OnStopBuild(self, unitBeingBuilt, order )
		end,
		
		Open = function(self)
		end,

		CreateBuildEffects = function(self, unitBeingBuilt, order)
			TAutils.CreateTAFactBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
		end,
		
		Close = function(self)
		end,
	}

TypeClass = TAFactory