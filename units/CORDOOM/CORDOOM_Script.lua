#CORE Doomsday Machine - Energy Weapon
#CORDOOM
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORDOOM = Class(TAunit) {
	damageReduction = 1,
	unpacked = false,

	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			hatch = CreateRotator(self, 'hatch', 'z', nil, 0, 0, 0),
		}
		self.Sliders = {
			hatch = CreateSlider(self, 'hatch'),
			shell1a = CreateSlider(self, 'shell1a'),
			shell2a = CreateSlider(self, 'shell2a'),
			shell3a = CreateSlider(self, 'shell3a'),
			shell4a = CreateSlider(self, 'shell4a'),
			shell1b = CreateSlider(self, 'shell1b'),
			shell2b = CreateSlider(self, 'shell2b'),
			shell3b = CreateSlider(self, 'shell3b'),
			shell4b = CreateSlider(self, 'shell4b'),
			turreta = CreateSlider(self, 'turreta'),
			turretb = CreateSlider(self, 'turretb'),
			turretc = CreateSlider(self, 'turretc'),
			barrela = CreateSlider(self, 'barrela'),
			barrelb = CreateSlider(self, 'barrelb'),
			barrelc1 = CreateSlider(self, 'barrelc1'),

		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OnDamage = function(self, instigator, amount, vector, damageType)
		TAunit.OnDamage(self, instigator, amount * self.damageReduction, vector, damageType) 
		#Has Damage Reduction
	end,

	Weapons = {
		CORE_DOOMSDAY = Class(TAweapon) {

			PlayFxWeaponUnpackSequence = function(self)
				self.unit.damageReduction = 1
				self.unit.unpacked = true
				TAweapon.PlayFxWeaponUnpackSequence(self)
			end,	

			PlayFxWeaponPackSequence = function(self)
				self.unit.damageReduction = 0.5
				self.unit.unpacked = false

				--MOVE barrela to z-axis <0> SPEED <5.00>;
				self.unit.Sliders.barrela:SetGoal(0,0,0)
				self.unit.Sliders.barrela:SetSpeed(5) 

				--SLEEP <672>;
				WaitSeconds(0.7)

				--MOVE barrelb to z-axis <0> SPEED <5.00>;
				self.unit.Sliders.barrelb:SetGoal(0,0,0)
				self.unit.Sliders.barrelb:SetSpeed(5) 

				--SLEEP <678>;
				WaitSeconds(0.7)

				--MOVE barrelc1 to z-axis <0> SPEED <4.00>;
				self.unit.Sliders.barrelc1:SetGoal(0,0,0)
				self.unit.Sliders.barrelc1:SetSpeed(4)




				--SLEEP <681>;
				WaitSeconds(0.7)



				--SLEEP <684>;
				WaitSeconds(0.7)

				--MOVE turreta to y-axis <8.85> SPEED <4.00>;
				self.unit.Sliders.turreta:SetGoal(0,8.85,0)
				self.unit.Sliders.turreta:SetSpeed(4)

				--MOVE turretb to y-axis <4.45> SPEED <4.00>;
				self.unit.Sliders.turretb:SetGoal(0,4.45,0)
				self.unit.Sliders.turretb:SetSpeed(4)

				--MOVE turretc to y-axis <0> SPEED <4.00>;
				self.unit.Sliders.turretc:SetGoal(0,0,0)
				self.unit.Sliders.turretc:SetSpeed(4)

				--SLEEP <655>;
				WaitSeconds(0.7)

				--MOVE turreta to y-axis <4.30> SPEED <6.00>;
				self.unit.Sliders.turreta:SetGoal(0,4.3,0)
				self.unit.Sliders.turreta:SetSpeed(6)

				--MOVE turretb to y-axis <0> SPEED <6.00>;
				self.unit.Sliders.turretb:SetGoal(0,0,0)
				self.unit.Sliders.turretb:SetSpeed(6)

				--SLEEP <660>;
				WaitSeconds(0.7)

				--MOVE turreta to y-axis <0> SPEED <6.00>;
				self.unit.Sliders.turreta:SetGoal(0,0,0)
				self.unit.Sliders.turreta:SetSpeed(6)

				--SLEEP <661>;
				--SLEEP <296>;
				WaitSeconds(1.0)

				--MOVE shell1a to y-axis <0> SPEED <17.00>;
				self.unit.Sliders.shell1a:SetGoal(-3.3,0,0)
				self.unit.Sliders.shell1a:SetSpeed(17)

				--MOVE shell2a to y-axis <0> SPEED <17.00>;
				self.unit.Sliders.shell2a:SetGoal(0,0,-3.3)
				self.unit.Sliders.shell2a:SetSpeed(17)

				--MOVE shell3a to y-axis <0> SPEED <17.00>;
				self.unit.Sliders.shell3a:SetGoal(3.3,0,0)
				self.unit.Sliders.shell3a:SetSpeed(17)

				--MOVE shell4a to y-axis <0> SPEED <17.00>;
				self.unit.Sliders.shell4a:SetGoal(0,0,3.3)
				self.unit.Sliders.shell4a:SetSpeed(17)

				--SLEEP <655>;
				WaitSeconds(0.7)

				--MOVE shell1a to x-axis <0> SPEED <5.00>;
				self.unit.Sliders.shell1a:SetGoal(0,0,0)
				self.unit.Sliders.shell1a:SetSpeed(5)

				--MOVE shell2a to z-axis <0> SPEED <5.00>;
				self.unit.Sliders.shell2a:SetGoal(0,0,0)
				self.unit.Sliders.shell2a:SetSpeed(5)

				--MOVE shell3a to x-axis <0> SPEED <5.00>;
				self.unit.Sliders.shell3a:SetGoal(0,0,0)
				self.unit.Sliders.shell3a:SetSpeed(5)

				--MOVE shell4a to z-axis <0> SPEED <5.00>;
				self.unit.Sliders.shell4a:SetGoal(0,0,0)
				self.unit.Sliders.shell4a:SetSpeed(5)

				--SLEEP <649>;
				WaitSeconds(0.7)

				--MOVE shell4b to x-axis <0> SPEED <6.00>;
				self.unit.Sliders.shell4b:SetGoal(0,0,0)
				self.unit.Sliders.shell4b:SetSpeed(6)

				--MOVE shell3b to z-axis <0> SPEED <6.00>;
				self.unit.Sliders.shell3b:SetGoal(0,0,0)
				self.unit.Sliders.shell3b:SetSpeed(6)

				--MOVE shell2b to x-axis <0> SPEED <6.00>;
				self.unit.Sliders.shell2b:SetGoal(0,0,0)
				self.unit.Sliders.shell2b:SetSpeed(6)

				--MOVE shell1b to z-axis <0> SPEED <5.00>;
				self.unit.Sliders.shell1b:SetGoal(0,0,0)
				self.unit.Sliders.shell1b:SetSpeed(6)

				--SLEEP <661>;
				WaitSeconds(0.7)

				--MOVE hatch to x-axis <0> SPEED <4.00>;
				--MOVE hatch to y-axis <0> SPEED <5.00>;
				self.unit.Sliders.hatch:SetGoal(0,0,0)
				self.unit.Sliders.hatch:SetSpeed(5)

				#Not needed?
				--TURN hatch to z-axis <-31.58> SPEED <26.79>;
				#self.unit.Spinners.hatch:SetGoal(32)
				#self.unit.Spinners.hatch:SetSpeed(27)

				--SLEEP <659>;
				WaitSeconds(0.7)

				--TURN hatch to z-axis <0> SPEED <48.08>;
				self.unit.Spinners.hatch:SetGoal(0)
				self.unit.Spinners.hatch:SetSpeed(48)

				--SLEEP <657>;
				--SLEEP <54>;
				WaitSeconds(0.7)
	
				TAweapon.PlayFxWeaponPackSequence(self)
			end,	
		},
		CORE_LIGHTLASER = Class(TAweapon) {
			PlayFxWeaponUnpackSequence = function(self)
				while (self.unit.unpacked == false) do
					WaitSeconds(0.2)
				end
				TAweapon.PlayFxWeaponUnpackSequence(self)
                        end,
                },
	


		CORE_LASERH1 = Class(TAweapon) {
			PlayFxWeaponUnpackSequence = function(self)
				while (self.unit.unpacked == false) do
					WaitSeconds(0.2)
				end
				TAweapon.PlayFxWeaponUnpackSequence(self)
                        end,
                },

	},
}

TypeClass = CORDOOM
