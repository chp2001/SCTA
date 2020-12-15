local FactoryUnit = import('/lua/defaultunits.lua').FactoryUnit
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

TAFactory = Class(FactoryUnit) {	
		OnStartBuild = function(self, unitBeingBuilt, order )
			self:Open()
			ForkThread(self.FactoryStartBuild, self, unitBeingBuilt, order )
		end,

		FactoryStartBuild = function(self, unitBeingBuilt, order )
			WaitFor(self.AnimManip)
			FactoryUnit.OnStartBuild(self, unitBeingBuilt, order )
		end,

		Open = function(self)
		end,

		Close = function(self)
		WaitTicks(5)
		end,

		CreateBuildEffects = function(self, unitBeingBuilt, order)
			TAutils.CreateTAFactBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
		end,

		IdleState = State {
			Main = function(self)
				ForkThread(self.Close, self)
				self:SetBusy(false)
				self:SetBlockCommandQueue(false)
				self:DestroyBuildRotator()
			end,
		},
	}

TypeClass = TAFactory