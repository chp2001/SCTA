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

	AnimationThread = function(self)
	TAconstructor.AnimationThread(self)
	end,
    OnKilled = function(self, instigator, type, overkillRatio)
        TAconstructor.OnKilled(self, instigator, type, overkillRatio)
            if self.currentTarget and not self.currentTarget:IsDead() and self.currentTarget:GetFractionComplete() != 1 then
				self.currentTarget:Kill()
        	end
    end,


	OnStartBuild = function(self, unitBeingBuilt, order )
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

    OnFailedToBuild = function(self)
        self.FactoryBuildFailed = true        
        TAconstructor.OnFailedToBuild(self)
        self:DestroyBuildRotator()
        --self:StopBuildFx()
        ChangeState(self, self.IdleState)
    end,

	OnStopBuild = function(self, unitBeingBuilt, order )
		TAconstructor.OnStopBuild(self, unitBeingBuilt, order )
		self:SetBusy(true)
		self:SetBlockCommandQueue(true)
    end,
	RollOff = function(self)
		TAconstructor.RollOff(self)
        if not IsDestroyed(self) and self.isFactory == true then
            WaitSeconds(0.5)
			self:SetBusy(false)
			self:SetBlockCommandQueue(false)
		end 
	end,


	
	Nano = function(self, unitBeingBuilt)
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

    IdleState = State {
        Main = function(self)
            self:SetBusy(false)
            self:SetBlockCommandQueue(false)
            self:DestroyBuildRotator()
        end,
	},

	UpgradingState = State {
        Main = function(self)
            self:StopRocking()
            local bp = self:GetBlueprint().Display
            self:DisableDefaultToggleCaps()
        end,

        OnStopBuild = function(self, unitBuilding)
            TAconstructor.OnStopBuild(self, unitBuilding)
            self:EnableDefaultToggleCaps()
            
            if unitBuilding:GetFractionComplete() == 1 then
                NotifyUpgrade(self, unitBuilding)
                self:Destroy()
            end
        end,

        OnFailedToBuild = function(self)
            TAconstructor.OnFailedToBuild(self)
            self:EnableDefaultToggleCaps()
            if self:GetCurrentLayer() == 'Water' then
                self:StartRocking()
            end
            ChangeState(self, self.IdleState)
        end,
        
	},
	
}

TypeClass = TAFactory