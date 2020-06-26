#COR Construction Hovercraft - Tech Level 1
#CORCH
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA/lua/TAconstructor.lua').TAconstructor
local TAutils = import('/mods/SCTA/lua/TAutils.lua')

CORCH = Class(TAconstructor) {

	OnCreate = function(self)
		self.Spinners = {
			nanogun = CreateRotator(self, 'nanogun', 'x', nil, 0, 0, 0),
			turret = CreateRotator(self, 'turret', 'y', nil, 0, 0, 0),
			post = CreateRotator(self, 'post', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			plate = CreateSlider(self, 'plate'),			
			door1 = CreateSlider(self, 'door1'),
			door2 = CreateSlider(self, 'door2'),

		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	Aim = function(self,target)
		#Aim at build job
		local selfPosition = self:GetPosition('turret') 
		local targetPosition = target:GetPosition()
			
		--TURN turret to y-axis buildheading SPEED <160.03>;
		self.Spinners.turret:SetGoal(TAutils.GetAngle(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z) - (self:GetHeading() * 180) / math.pi)
		self.Spinners.turret:SetSpeed(160.03)
		WaitFor(self.Spinners.turret)

		local distance = VDist2(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z)
		selfPosition = self:GetPosition('muzzle') 

		self.Spinners.nanogun:SetGoal(-180 + TAutils.GetAngle(0, selfPosition.y, distance, targetPosition.y))
		self.Spinners.nanogun:SetSpeed(45.01)

		WaitFor(self.Spinners.nanogun)
		TAconstructor.Aim(self, target)
	end,

	Close = function(self)
			
		self.Spinners.turret:SetGoal(0)
		self.Spinners.turret:SetSpeed(160.03)
		WaitFor(self.Spinners.turret)

		--TURN post to x-axis <0> SPEED <196.98>;
		self.Spinners.post:SetGoal(0)
		self.Spinners.post:SetSpeed(196.98)

		--TURN nanogun to x-axis <0> SPEED <196.98>;
		self.Spinners.nanogun:SetGoal(0)
		self.Spinners.nanogun:SetSpeed(196.98)

		--SLEEP <457>;
		WaitSeconds(0.45)

		--MOVE door1 to y-axis <0> SPEED <4.00>;
		self.Sliders.door1:SetGoal(0,0,0)
		self.Sliders.door1:SetSpeed(4)

		--MOVE door2 to y-axis <0> SPEED <4.00>;
		self.Sliders.door2:SetGoal(0,0,0)
		self.Sliders.door2:SetSpeed(4)

		--MOVE plate to y-axis <0> SPEED <8.00>;
		self.Sliders.plate:SetGoal(0,0,0)
		self.Sliders.plate:SetSpeed(8)

		--SLEEP <27>;
		TAconstructor.Close(self)
	end,
}

TypeClass = CORCH