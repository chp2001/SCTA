local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

TAFactory = Class(TAconstructor) {
	currentState = "closed",
	desiredState = "closed",
    currentTarget = nil,
	desiredTarget = nil,
	order = nil,

	isBuilding = false,
	isReclaiming = false,

	pauseTime = 3,
	hideUnit = false,
	isFactory = true,
	spinUnit = true,

	animating = false,
	wantStopAnimation = false,

    OnKilled = function(self, instigator, type, overkillRatio)
        TAconstructor.OnKilled(self, instigator, type, overkillRatio)
            if self.currentTarget and not self.currentTarget:IsDead() and self.currentTarget:GetFractionComplete() != 1 then
				self.currentTarget:Kill()
        	end
    end,


	OnStartBuild = function(self, unitBeingBuilt, order )
        self:LOGDBG('TAFactory.OnStartBuild')
		self.desiredTarget = unitBeingBuilt
		if (self.currentState == "aimed" or self.currentState == "opened" or self.currentState == "rolloff") then
			self.currentState = "opened"
			self.desiredState = "aimed"
		else
			self.desiredState = "opened"
		end
		---self:SetAllWeaponsEnabled(false)
		if self.hideUnit and IsDestroyed(unitBeingBuilt) == false then
			unitBeingBuilt:HideBone(0, true)
		end
		self.isBuilding = true
		self.order = order
		self.wantStopAnimation = false
		if (self.animating == false) then
			ForkThread(self.AnimationThread, self)
		end
	end,

	OnStopBuild = function(self, unitBeingBuilt, order )
		self:LOGDBG('TAFactory.OnStopBuild')
		TAconstructor.OnStopBuild(self, unitBeingBuilt, order )
		ForkThread(self.FactoryOnStopBuild, self, unitBeingBuilt, order )
	end,

	FactoryOnStopBuild = function(self, unitBeingBuilt, order )
		--WaitSeconds(1)
		self:SetBusy(true)
		self:SetBlockCommandQueue(false)
        if unitBeingBuilt and unitBeingBuilt.Dead then
            self.desiredState = "aimed"
		end
	end,

	RollOff = function(self)
        self:LOGDBG('TAFactory.RollOff')
        if not IsDestroyed(self) and self.isFactory == true then
			ChangeState(self, self.IdleState)
			WaitSeconds(0.5)
			if not IsDestroyed(self) then
			self:SetBusy(false)
			self:SetBlockCommandQueue(false)
			end
		end 
		---self:OnStopBuild()
	end,

	Unpack = function(self)
        self:LOGDBG('TAFactory.Unpack')
	end,

	Open = function(self)
        self:LOGDBG('TAFactory.Open')
	end,
	
	Aim = function(self, target)
        self:LOGDBG('TAFactory.Aim')
	end,

	DelayedClose = function(self)
        self:LOGDBG('TAFactory.DelayedClose')
		ChangeState(self, self.IdleState)
		if self.isFactory then
			# Wait until unit factory is clear to close
				if self.isBuilding == true then
					return
				end
			WaitSeconds(0.5)
		end
		self:OnStopBuild()
	end,

	DestroyUnitBeingBuilt = function(self)
        self:LOGDBG('TAFactory.DestroyUnitBeingBuilt')
        if self.UnitBeingBuilt and not self.UnitBeingBuilt.Dead and self.UnitBeingBuilt:GetFractionComplete() < 1 then
            if self.UnitBeingBuilt:GetFractionComplete() > 0.5 then
                self.UnitBeingBuilt:Kill()
            else
                self.UnitBeingBuilt:Destroy()
			end
			self:OnStopBuild()
		end
		ChangeState(self, self.IdleState)
    end,

	Close = function(self)
        self:LOGDBG('TAFactory.Close')
		self:SetBusy(false)
		self:SetBlockCommandQueue(false)
		if self.isBuilding == true then
			self.desiredState = "aimed"
		end
		---self:OnStopBuild()
	end,

	StopSpin = function(self, unitBeingBuilt)
        self:LOGDBG('TAFactory.StopSpin')
		---self:OnStopBuild()
		if not IsDestroyed(self) and self.isFactory == true and unitBeingBuilt then
			WaitSeconds(0.5)
			if IsDestroyed(unitBeingBuilt) == false then
            unitBeingBuilt:DetachFrom(true)
		end
	end
    end,

	Nano = function(self, unitBeingBuilt)
        self:LOGDBG('TAFactory.Nano')
		local target = 1
		local current = 0
		while not IsDestroyed(self) and self.isBuilding == true and IsDestroyed(unitBeingBuilt) == false and unitBeingBuilt:GetFractionComplete() < 1 or self.isReclaiming == true and self.currentState == "aimed" do
			if self:IsPaused() == false then

				current = current + 1
				if current >= target then
					for k,v in self:GetBlueprint().Display.BuildBones do

                        local selfPosition = self:GetPosition(v) 
                        local targetPosition = unitBeingBuilt:GetPosition()
                        local distance = VDist3(Vector(selfPosition.x,selfPosition.y, selfPosition.z), Vector(targetPosition.x, targetPosition.y, targetPosition.z))
                        local time = distance * 0.85
                        if (time >10) then
                            time = 10
                        end

						local aiBrain = self:GetAIBrain()
						local storedMass = aiBrain:GetEconomyStoredRatio('MASS')
						local storedEnergy = aiBrain:GetEconomyStoredRatio('ENERGY')
						local ratioMass = aiBrain:GetEconomyIncome('MASS') / aiBrain:GetEconomyRequested('MASS')
						local ratioEnergy =  aiBrain:GetEconomyIncome('ENERGY') / aiBrain:GetEconomyRequested('ENERGY')
						local lowestStored = math.min(storedMass, storedEnergy)
						if lowestStored == storedMass then 
							lowestRatio = ratioMass
						else
							lowestRatio = ratioEnergy
						end

						local bp
						if (self.isBuilding == true) then
							bp = self:GetBlueprint().Display.BuildEmitter or 'nanolathe.bp'
							CreateEmitterAtBone(self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/' .. bp ):ScaleEmitter(0.1):SetEmitterCurveParam('LIFETIME_CURVE',time,0)
						end
						

						if lowestRatio < 1 and lowestStored < 0.1 then
							target = math.floor(1 / lowestRatio)
						else
							target = 1
						end
					end
					current = 0
				end
			end
			WaitSeconds(0.25)
		end
	end,
}

TypeClass = TAFactory