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
		self.Spinners.luparm:SetSpeed(120.01)
	end,


	Open = function(self)
		self.Spinners.luparm:SetGoal(-70)
		self.Spinners.luparm:SetSpeed(140.01)
		TAconstructor.Open(self)
	end,


	Close = function(self)
		self.Spinners.luparm:SetGoal(0)
		self.Spinners.luparm:SetSpeed(45.01)

		TAconstructor.Close(self)
	end,
}

TypeClass = ARMDECOM