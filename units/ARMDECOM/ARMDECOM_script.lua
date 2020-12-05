#ARM Decoy Commander - Decoy Commander
#ARMCOM
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

ARMDECOM = Class(TAconstructor) {

	Weapons = {
		ARMCOMLASER = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				
			end,
		},
		DGun = Class(TADGun) {
		},
	},

	OnCreate = function(self)
		self.Spinners = {
			torso = CreateRotator(self, 'Torso', 'y', nil, 0, 0, 0),
			luparm = CreateRotator(self, 'LeftLowerArm', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAconstructor.OnCreate(self)
	end,

	OnStartReclaim = function(self, target)
		TAconstructor.OnStartReclaim(self, target)
		self.Spinners.luparm:SetGoal(-60)
		self.Spinners.luparm:SetSpeed(45.01)
	end,


	Open = function(self)
		self.Spinners.luparm:SetGoal(-85)
		self.Spinners.luparm:SetSpeed(45.01)
		TAconstructor.Open(self)
	end,


	Aim = function(self, target)
		local selfPosition = self:GetPosition('Torso') 
		local targetPosition = target:GetPosition()
			
		WaitFor(self.Spinners.luparm)

		--TURN torso to y-axis heading SPEED <300.07>;
		self.Spinners.torso:SetGoal(TAutils.GetAngleTA(selfPosition.x, selfPosition.z, targetPosition.x, targetPosition.z) - (self:GetHeading() * 180) / math.pi)
		self.Spinners.torso:SetSpeed(300)

		WaitFor(self.Spinners.torso)
		TAconstructor.Aim(self, target)
	end,


	Close = function(self)
		self.Spinners.torso:SetGoal(0)
		self.Spinners.torso:SetSpeed(90)
	
		self.Spinners.luparm:SetGoal(0)
		self.Spinners.luparm:SetSpeed(45.01)

		WaitFor(self.Spinners.torso)
		WaitFor(self.Spinners.luparm)

		TAconstructor.Close(self)
	end,
}

TypeClass = ARMDECOM