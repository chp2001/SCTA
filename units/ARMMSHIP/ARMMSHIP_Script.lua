#ARM Ranger - Missile Ship
#ARMMSHIP
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TARocket = import('/mods/SCTA-master/lua/TAweapon.lua').TARocket
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon

ARMMSHIP = Class(TASea) {
	OnCreate = function(self)
		TASea.OnCreate(self)
		self.Spinners = {
			launcher1 = CreateRotator(self, 'launcher1', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			door1 = CreateSlider(self, 'door1'),
			door2 = CreateSlider(self, 'door2'),
			plate = CreateSlider(self, 'plate'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		self.currentShot = 0
	end,

	Weapons = {
		ARMMSHIP_ROCKET = Class(TARocket) {
			PlayFxRackReloadSequence = function(self)
				self.unit.currentShot = self.unit.currentShot + 1
				if self.unit.currentShot == 2 then
					
					self.unit:HideBone('rocket1', true)
					self.unit:HideBone('rocket2', true)
					--TURN launcher1 to x-axis <0> SPEED <120.02>;
					self.unit.Spinners.launcher1:SetGoal(0)
					self.unit.Spinners.launcher1:SetSpeed(120)

					--SLEEP <750>;
					WaitSeconds(0.75)

					--MOVE plate to y-axis <0> SPEED <7.00>;
					self.unit.Sliders.plate:SetGoal(0,0,0)
					self.unit.Sliders.plate:SetSpeed(7)

					--SLEEP <600>;
					WaitSeconds(0.6)
	
					--MOVE door1 to x-axis <0> SPEED <6.00>;
					self.unit.Sliders.door1:SetGoal(0,0,0)
					self.unit.Sliders.door1:SetSpeed(6)

					--MOVE door2 to x-axis <0> SPEED <7.00>;
					self.unit.Sliders.door2:SetGoal(0,0,0)
					self.unit.Sliders.door2:SetSpeed(6)

					--SLEEP <600>;
					WaitSeconds(1.5) #0.6 not long enough
	
					--SLEEP <10>;

					self.unit:ShowBone('rocket1', true)
					self.unit:ShowBone('rocket2', true)
	
	
					--MOVE door1 to x-axis <4.19> SPEED <6.00>;
					self.unit.Sliders.door1:SetGoal(-4.19,0,0)
					self.unit.Sliders.door1:SetSpeed(6)
	
					--MOVE door2 to x-axis <-4.35> SPEED <7.00>;
					self.unit.Sliders.door2:SetGoal(4.19,0,0)
					self.unit.Sliders.door2:SetSpeed(6)
	
					--SLEEP <600>;
					WaitSeconds(0.6)
	
					--MOVE plate to y-axis <4.34> SPEED <7.00>;
					self.unit.Sliders.plate:SetGoal(0,4.34,0)
					self.unit.Sliders.plate:SetSpeed(7)
	
					--SLEEP <600>;
					WaitSeconds(0.6)
	
					--TURN launcher1 to x-axis <-90.00> SPEED <120.02>;
					self.unit.Spinners.launcher1:SetGoal(-90)
					self.unit.Spinners.launcher1:SetSpeed(120)
	
					--SLEEP <750>;
					WaitSeconds(0.75)
	
					--SLEEP <10>;
					self.unit.currentShot = 0	
					end	
				TARocket.PlayFxRackReloadSequence(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				--MOVE door1 to x-axis <4.19> SPEED <6.00>;
				self.unit.Sliders.door1:SetGoal(-4.19,0,0)
				self.unit.Sliders.door1:SetSpeed(6)

				--MOVE door2 to x-axis <-4.35> SPEED <7.00>;
				self.unit.Sliders.door2:SetGoal(4.19,0,0)
				self.unit.Sliders.door2:SetSpeed(6)

				--SLEEP <600>;
				WaitSeconds(0.6)

				--MOVE plate to y-axis <4.34> SPEED <7.00>;
				self.unit.Sliders.plate:SetGoal(0,4.34,0)
				self.unit.Sliders.plate:SetSpeed(7)

				self.unit:ShowBone('rocket1', true)
				self.unit:ShowBone('rocket2', true)
				--SLEEP <600>;
				WaitSeconds(0.6)

				--TURN launcher1 to x-axis <-90.00> SPEED <120.02>;
				self.unit.Spinners.launcher1:SetGoal(-90)
				self.unit.Spinners.launcher1:SetSpeed(120)

				--SLEEP <750>;
				WaitSeconds(1) #Not long enough, shot on an angle

				--SLEEP <10>;

				TARocket.PlayFxWeaponUnpackSequence(self)
			end,	

			PlayFxWeaponPackSequence = function(self)
				--TURN launcher1 to x-axis <0> SPEED <120.02>;
				self.unit.Spinners.launcher1:SetGoal(0)
				self.unit.Spinners.launcher1:SetSpeed(120)

				--SLEEP <750>;
				WaitSeconds(0.75)

				--MOVE plate to y-axis <0> SPEED <7.00>;
				self.unit.Sliders.plate:SetGoal(0,0,0)
				self.unit.Sliders.plate:SetSpeed(7)

				--SLEEP <600>;
				WaitSeconds(0.6)

				--MOVE door1 to x-axis <0> SPEED <6.00>;
				self.unit.Sliders.door1:SetGoal(0,0,0)
				self.unit.Sliders.door1:SetSpeed(6)

				--MOVE door2 to x-axis <0> SPEED <7.00>;
				self.unit.Sliders.door2:SetGoal(0,0,0)
				self.unit.Sliders.door2:SetSpeed(6)


				TARocket.PlayFxWeaponPackSequence(self)
			end,	
		},
		ARMSHIP_MISSILE = Class(TAMPhalanxWeapon) {},
	},
}

TypeClass = ARMMSHIP
