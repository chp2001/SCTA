
local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

CORDECOM = Class(TAconstructor) {

	Weapons = {
		CORCOMLASER = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
			end,
		},
		DGun = Class(TADGun) {
		},

	},

	OnCreate = function(self)
		self.Spinners = {
			Torso = CreateRotator(self, 'Torso', 'y', nil, 0, 0, 0),
			Nanogun = CreateRotator(self, 'Nanogun', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	OnStartReclaim = function(self, target)
		TAconstructor.OnStartReclaim(self, target)
		self.Spinners.Nanogun:SetGoal(-60)
		self.Spinners.Nanogun:SetSpeed(45.01)
	end,


	Open = function(self)
		self.Spinners.Nanogun:SetGoal(-85)
		self.Spinners.Nanogun:SetSpeed(45.01)
		TAconstructor.Open(self)
	end,

	Aim = function(self, target)
		local selfPosition = self:GetPosition('Torso') 
		local targetPosition = target:GetPosition()
			
		WaitFor(self.Spinners.Nanogun)
		--TURN torso to y-axis heading SPEED <300.07>;
		self.Spinners.Torso:SetGoal(TAutils.GetAngleTA(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z) - (self:GetHeading() * 180) / math.pi)
		self.Spinners.Torso:SetSpeed(300)

		WaitFor(self.Spinners.Torso)

		TAconstructor.Aim(self, target)
	end,


	Close = function(self)
		self.Spinners.Torso:SetGoal(0)
		self.Spinners.Torso:SetSpeed(90)
	
		self.Spinners.Nanogun:SetGoal(0)
		self.Spinners.Nanogun:SetSpeed(45.01)

		WaitFor(self.Spinners.Torso)
		WaitFor(self.Spinners.Nanogun)

		TAconstructor.Close(self)
	end,
}

TypeClass = CORDECOM